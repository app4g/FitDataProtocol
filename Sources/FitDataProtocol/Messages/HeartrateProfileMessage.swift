//
//  HeartrateProfileMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/21/18.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import DataDecoder
import FitnessUnits
import AntMessageProtocol

/// FIT HRM Profile Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class HeartrateProfileMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 4 }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Enabled
    private(set) public var enabled: Bool?

    /// ANT ID
    private(set) public var antID: ValidatedBinaryInteger<UInt16>?

    /// Log HRV
    private(set) public var logHrv: Bool?

    /// Transmission Type
    private(set) public var transmissionType: TransmissionType?

    public required init() {}

    public init(messageIndex: MessageIndex? = nil,
                enabled: Bool? = nil,
                antID: ValidatedBinaryInteger<UInt16>? = nil,
                logHrv: Bool? = nil,
                transmissionType: TransmissionType? = nil) {
        
        self.messageIndex = messageIndex
        self.enabled = enabled
        self.antID = antID
        self.logHrv = logHrv
        self.transmissionType = transmissionType
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage Result
    override func decode<F: HeartrateProfileMessage>(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) -> Result<F, FitDecodingError> {
        var messageIndex: MessageIndex?
        var enabled: Bool?
        var antID: ValidatedBinaryInteger<UInt16>?
        var logHrv: Bool?
        var transmissionType: TransmissionType?
        
        let arch = definition.architecture
        
        var localDecoder = DecodeData()
        
        for definition in definition.fieldDefinitions {
            
            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))
            
            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("HeartrateProfileMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")
                
            case .some(let key):
                switch key {
                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)
                    
                case .enabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        enabled = value.boolValue
                    }
                    
                case .antID:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    antID = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                     definition: definition,
                                                                     dataStrategy: dataStrategy)
                    
                case .logHrv:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        logHrv = value.boolValue
                    }
                    
                case .transType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        transmissionType = TransmissionType(value)
                    }
                    
                }
            }
        }
        
        let msg = HeartrateProfileMessage(messageIndex: messageIndex,
                                          enabled: enabled,
                                          antID: antID,
                                          logHrv: logHrv,
                                          transmissionType: transmissionType)
        return.success(msg as! F)
    }

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {

//        do {
//            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
//        } catch let error as FitEncodingError {
//            return.failure(error)
//        } catch {
//            return.failure(FitEncodingError.fileType(error.localizedDescription))
//        }

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .messageIndex:
                if let _ = messageIndex { fileDefs.append(key.fieldDefinition()) }

            case .enabled:
                if let _ = enabled {fileDefs.append(key.fieldDefinition()) }
            case .antID:
                if let _ = antID { fileDefs.append(key.fieldDefinition()) }
            case .logHrv:
                if let _ = logHrv { fileDefs.append(key.fieldDefinition()) }
            case .transType:
                if let _ = transmissionType { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: HeartrateProfileMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return.success(defMessage)
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }

    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data Result
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) -> Result<Data, FitEncodingError> {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            return.failure(self.encodeWrongDefinitionMessage())
        }

        let msgData = MessageData()

        for key in FitCodingKeys.allCases {

            switch key {
            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())
                }

            case .enabled:
                if let enabled = enabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: enabled)) {
                        return.failure(error)
                    }
                }

            case .antID:
                if let antID = antID {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: antID)) {
                        return.failure(error)
                    }
                }

            case .logHrv:
                if let logHrv = logHrv {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: logHrv)) {
                        return.failure(error)
                    }
                }

            case .transType:
                if let transmissionType = transmissionType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: transmissionType)) {
                        return.failure(error)
                    }
                }

            }
        }

        if msgData.message.count > 0 {
            return.success(encodedDataMessage(localMessageType: localMessageType, msgData: msgData.message))
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }
}
