unit xdom;

// ********************************************************************
// This is a modified version of the XDOM 2.3.14 distribution which is
// included with Borland's Kylix, Delphi and C++ Builder products.
// all modifications from the original are marked with the text:
// "Borland Change".
// ********************************************************************
//
// XDOM 2.3.14
// Extended Document Object Model 2.3.14
// Delphi 3/4/5 Implementation
//
// Copyright (c) 1999-2001 by Dieter K�hler
// ("http://www.philo.de/xml/")
//
// Definitions:
// - "Package" refers to the collection of files distributed by
//   the Copyright Holder, and derivatives of that collection of
//   files created through textual modification.
// - "Standard Version" refers to such a Package if it has not
//   been modified, or has been modified in accordance with the
//   wishes of the Copyright Holder.
// - "Copyright Holder" is whoever is name in the copyright or
//   copyrights for the package.
// - "You" is you, if you're thinking about copying or distributing
//   this Package.
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Package"), to deal in the Package without restriction,
// including without limitation the rights to use, copy, modify,
// merge, publish, distribute, sublicense, and/or sell copies of the
// Package, and to permit persons to whom the Package is furnished
// to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Package.
//
// You may modify your copy of this Package in any way, provided
// that you insert a prominent notice in each changed file stating
// how and when you changed a file, and provided that you do at
// least one of the following:
//
// a) allow the Copyright Holder to include your modifications in
// the Standard Version of the Package.
//
// b) use the modified Package only within your corporation or
// organization.
//
// c) rename any non standard executables, units, and classes so
// the names do not conflict with standard executables, units, and
// classes, and provide a separate manual page that clearly documents
// how it differs from the standard version.
//
// d) make other distribution arrangements with the Copyright Holder.
//
// The name of the Copyright Holder may not be used to endorse or
// promote products derived from this Package without specific prior
// written permission.
//
// THE PACKAGE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// PACKAGE OR THE USE OR OTHER DEALINGS IN THE PACKAGE.

interface

uses
  {$IFDEF LINUX}
  Libc,
  {$ENDIF}
  Math, SysUtils, Classes;

resourcestring
  SCannotReadOddPos = 'Cannot read WideString from odd byte position';
  SCannotWriteOddPos = 'Cannot write WideString to odd byte position';
  SOddSizeInvalid = 'Odd size not valid for WideString';
  SNegativeSizeInvalid = 'Negative stream size invalid';
  SOddPosInvalid = 'Odd byte position not valid for WideString';
  SCapacityLessSize = 'Capacity cannot be less than size';
  STargetNil = 'Must have a target stream';

type
  EDomException = class(Exception);

  EIndex_Size_Err = class(EdomException);
  EDomstring_Size_Err = class(EdomException);
  EHierarchy_Request_Err = class(EdomException);
  EWrong_Document_Err = class(EdomException);
  EInvalid_Character_Err = class(EdomException);
  ENo_Data_Allowed_Err = class(EdomException);
  ENo_Modification_Allowed_Err = class(EdomException);
  ENot_Found_Err = class(EdomException);
  ENot_Supported_Err = class(EdomException);
  EInuse_Attribute_Err = class(EdomException);
  EInvalid_State_Err = class(EdomException);
  ESyntax_Err = class(EdomException);
  EInvalid_Modification_Err = class(EdomException);
  ENamespace_Err = class(EdomException);
  EInvalid_Access_Err = class(EdomException);
  EInuse_Node_Err = class(EdomException);
  EInuse_Content_Model_Err = class(EdomException);
  EInuse_AttributeDefinition_Err = class(EdomException);
  ENo_External_Entity_Allowed_Err = class(EdomException);
  EInvalid_Entity_Reference_Err = class(EdomException);
  EUnknown_Document_Format_Err = class(EdomException);

  EParserException = class(Exception);

  EInternalParserException = class(EParserException);

  EParserFatalError = class(EParserException);
  EParserError = class(EParserException);
  EParserWarning = class(EParserException);
  EParserNamespaceFatalError = class(EParserFatalError);

  EParserMissingWhiteSpace_Err = class(EParserFatalError);
  EParserMissingQuotationMark_Err = class(EParserFatalError);
  EParserMissingEqualitySign_Err = class(EParserFatalError);
  EParserDoubleEqualitySign_Err = class(EParserFatalError);
  EParserInvalidElementName_Err = class(EParserFatalError);
  EParserInvalidAttributeName_Err = class(EParserFatalError);
  EParserInvalidAttributeValue_Err = class(EParserFatalError);
  EParserDoubleAttributeName_Err = class(EParserFatalError);
  EParserInvalidEntityName_Err = class(EParserFatalError);
  EParserInvalidProcessingInstruction_Err = class(EParserFatalError);
  EParserInvalidXmlDeclaration_Err = class(EParserFatalError);
  EParserInvalidCharRef_Err = class(EParserFatalError);
  EParserMissingStartTag_Err = class(EParserFatalError);
  EParserMissingEndTag_Err = class(EParserFatalError);
  EParserInvalidEndTag_Err = class(EParserFatalError);
  EParserInvalidCharacter_Err = class(EParserFatalError);
  EParserNotInRoot_Err = class(EParserFatalError);
  EParserDoubleRootElement_Err = class(EParserFatalError);
  EParserRootNotFound_Err = class(EParserFatalError);
  EParserWrongOrder_Err = class(EParserFatalError);
  EParserInvalidDoctype_Err = class(EParserFatalError);
  EParserInvalidTextDeclaration_Err = class(EParserFatalError);
  EParserLtInAttributeValue_Err = class(EParserFatalError);
  EParserAttributeValueRefersToExternalEntity_Err = class(EParserFatalError);
  EParserReferenceToUnparsedEntity_Err = class(EParserFatalError);
  EParserNoProperMarkupReferenced_Err = class(EParserFatalError);
  EParserInvalidComment_Err = class(EParserFatalError);
  EParserInvalidCDATASection_Err = class(EParserFatalError);
  EParserInvalidSystemLiteral_Err = class(EParserFatalError);
  EParserInvalidPubidLiteral_Err = class(EParserFatalError);
  EParserInvalidDoctypeName_Err = class(EParserFatalError);

  EParserInvalidQualifiedName_Err = class(EParserNamespaceFatalError);
  EParserInvalidPrefix_Err = class(EParserNamespaceFatalError);
  EParserInvalidNamespaceURI_Err = class(EParserNamespaceFatalError);
  EParserNamespaceURINotFound_Err = class(EParserNamespaceFatalError);
  EParserWrongPrefixMappingNesting_Err = class(EParserNamespaceFatalError);

  EParserDoubleDoctype_Err = class(EParserInvalidDoctype_Err);
  EParserUnknownDeclarationType_Err = class(EParserInvalidDoctype_Err);
  EParserInvalidEntityDeclaration_Err = class(EParserInvalidDoctype_Err);
  EParserInvalidElementDeclaration_Err = class(EParserInvalidDoctype_Err);
  EParserInvalidAttributeDeclaration_Err = class(EParserInvalidDoctype_Err);
  EParserInvalidNotationDeclaration_Err = class(EParserInvalidDoctype_Err);
  EParserInvalidConditionalSection_Err = class(EParserInvalidDoctype_Err);

  EParserDouble_AttDef_Warning = class(EParserWarning);
  EParserDouble_Entity_Decl_Warning = class(EParserWarning);
  EParserDouble_Parameter_Entity_Decl_Warning = class(EParserWarning);
  EParserUnusable_Entity_Decl_Warning = class(EParserWarning);

  EParserMissing_Entity_Declaration_Err = class(EParserError);
  EParserDouble_Element_Type_Declaration_Err = class(EParserError);
  EParserDuplicate_Name_In_Mixed_Content_Err = class(EParserError);
  EParserDuplicate_ID_On_Element_Type_Err = class(EParserError);
  EParserUndeclared_Notation_Name_Err = class(EParserError);
  EParserDuplicate_Notation_On_Element_Type_Err = class(EParserError);
  EParserDuplicate_Notation_Token_Err = class(EParserError);
  EParserNotation_On_Empty_Element_Err = class(EParserError);
  EParserDuplicate_Enumeration_Token_Err = class(EParserError);
  EParserAttribute_Type_Mismatch_Err = class(EParserError);
  EParserDuplicate_Tokens_Err = class(EParserError);
  EParserId_Neither_Implied_Nor_Required_Err = class(EParserError);
  EParserWrong_Root_Element_Type_Err = class(EParserError);
  EParserElement_Type_Declaration_Not_Found_Err = class(EParserError);
  EParserElement_Declared_Empty_Has_Content_Err = class(EParserError);
  EParserElement_With_Illegal_Mixed_Content_Err = class(EParserError);
  EParserElement_With_Illegal_Element_Content_Err = class(EParserError);
  EParserNondeterministic_Element_Content_Model_Err = class(EParserError);
  EParserDuplicate_Notation_Decl_Err = class(EParserError);
  EParserAttribute_Definition_Not_Found_Err = class(EParserError);
  EParserRequired_Attribute_Not_Found_Err = class(EParserError);
  EParserFixed_Attribute_Mismatch_Err = class(EParserError);
  EParserAttribute_Default_Type_Mismatch_Err = class(EParserError);
  EParserDuplicate_ID_Value_Err = class(EParserError);
  EParserTarget_ID_Value_Not_Found_Err = class(EParserError);
  EParserTarget_Unparsed_Entity_Not_Found_Err = class(EParserError);
  EParserWrong_Declaration_Of_Predefined_Entity_Err = class(EParserError);
  EParserUnresolvable_Entity_Reference_Err = class(EParserError);
  EParserUnresolvable_Parameter_Entity_Reference_Err = class(EParserError);
  EParserExternal_Subset_Not_Found_Err = class(EParserError);
  EParserExternal_Entity_Not_Found_Err = class(EParserError);

  TdomNodeType = (ntUnknown,
                  ntElement_Node,
                  ntAttribute_Node,
                  ntText_Node,
                  ntCDATA_Section_Node,
                  ntEntity_Reference_Node,
                  ntEntity_Node,
                  ntProcessing_Instruction_Node,
                  ntComment_Node,
                  ntDocument_Node,
                  ntDocument_Type_Node,
                  ntDocument_Fragment_Node,
                  ntNotation_Node);

  TdomWhatToShow = set of TdomNodeType;

const
  show_all: TdomWhatToShow = [ntElement_Node .. High(TDomNodeType)];

type
  TdomNodeTypeSet = set of TdomNodeType;

  TdomPieceType = (xmlProcessingInstruction,xmlXmlDeclaration,
                   xmlTextDeclaration,xmlComment,xmlCDATA,xmlPCDATA,
                   xmlDoctype,xmlStartTag,xmlEndTag,xmlEmptyElementTag,
                   xmlCharRef,xmlEntityRef,xmlParameterEntityRef,
                   xmlEntityDecl,xmlElementDecl,xmlAttributeDecl,
                   xmlNotationDecl,xmlCondSection,xmlUnknown);

  TdomEntityResolveOption = (erReplace,erExpand);

  TdomContentspecType = (ctEmpty,ctAny,ctMixed,ctChildren);

  // October 16, 2001 - Borland Change - Added etsystem enumeration
  TdomEncodingType = (etUTF8,etUTF16BE,etUTF16LE,etLatin1,etLatin2,
                      etLatin3,etLatin4,etCyrillic,etArabic,etGreek,
                      etHebrew,etLatin5,etLatin6,etLatin7,etLatin8,
                      etLatin9,etKOI8R,etcp10000_MacRoman,etcp1250,
                      etcp1251,etcp1252,etsystem);

  TdomFilterResult = (filter_accept,filter_reject,filter_skip);

  TdomNode = class;
  TdomElement = class;
  TdomDocument = class;
  TdomDocumentType = class;
  TdomEntity = class;
  TdomNotation = class;
  TdomNodeList = class;

  TdomAbstractView = class;

  TdomMediaList = class;

  TXmlSourceCodePiece = class;

  TdomDocumentClass = class of TdomDocument;

  PdomDocumentFormat = ^TdomDocumentFormat;

  TdomDocumentFormat = record
    DocumentClass: TdomDocumentClass;
    NamespaceUri:  wideString;
    QualifiedName: wideString;
    next:          PdomDocumentFormat;
  end;

  TdomNameValueList = class
  protected
    FNames: TStringList;
    FValues: TStringList;
    function getLength: integer; virtual;
    function getCapacity: integer; virtual;
    function getNames(index: integer): wideString; virtual;
    function getValues(index: integer): wideString; virtual;
    procedure setCapacity(const value: integer); virtual;
  public
    constructor create;
    destructor destroy; override;
    function add(const name,
                       value: wideString): integer; virtual;
    procedure clear; virtual;
    procedure Delete(const item: integer); virtual;
    procedure exchange(const index1,
                             index2: integer); virtual;
    function indexOf(const name,
                           value: wideString): integer; virtual;
    function indexOfName(const name: wideString): integer; virtual;
    procedure insert(const index: integer;
                     const name,
                           value: wideString); virtual;
    property capacity: integer read getCapacity write setCapacity;
    property length: integer read getLength;
    property names[index: integer]: wideString read getNames;
    property values[index: integer]: wideString read getValues;
  end;

  TdomCustomStr = class
  private
    FActualLen: integer;
    FCapacity: integer;
    FContent: wideString;
  protected
    function getWideChars(indx: integer): wideChar; virtual;
    procedure setWideChars(indx: integer;
                           ch: wideChar); virtual;
  public
    constructor create;
    procedure addWideChar(const ch: wideChar); virtual;
    procedure addWideString(const s: wideString); virtual;
    function  endsWith(const s: wideString): boolean; virtual;
    function  isEqual(const s: wideString): boolean; virtual;
    procedure reset; virtual;
    function  startsWith(const s: wideString): boolean; virtual;
    function  value: wideString; virtual;
              // Since calling the value function involves time
              // consuming string copying, always use one of the
              // other TdomCustomStr access functions, if possible,
              // e.g. wideChars[indx] instead of value[indx],
              // isEqual[s] instead of (value = s), or
              // length instead of length(value).
    property  length: integer read FActualLen;
    property  wideChars[indx: integer]: wideChar read getWideChars write setWideChars; default;
  end;

  TdomWideStringStream = class(TStream)
  private
    FDataStringP: PChar;
    FSize: longint;
    FCapacity: longint;
    FPosition: longint;
  protected
    procedure setCapacity(newCapacity: longint); virtual;
    procedure setSize(newSize: longint); override;
    procedure setStringPosition(value: longint);
    function getStringPosition: longint;
    procedure setStringLength(value: longint);
    function getStringLength: longint;
    function getDataString: wideString;
  public
    constructor createFromString(const aString: WideString);
    destructor destroy; override;
    function read(var buffer; count: longint): longint; override;
    function readString(count: longint): wideString;
    function seek(offset: longint; origin: word): longint; override;
    function write(const buffer; count: longint): longint; override;
    procedure writeString(const aString: wideString);
    property capacity: longint read FCapacity write setCapacity;
    property stringLength: longint read getStringLength write setStringLength;
    property stringPosition: longint read getStringPosition write setStringPosition;
    property dataString: wideString read getDataString;
  end;

  EConversionStream = class(EStreamError);

  TConversionStream = class(TStream)
  private
    FTarget: TStream;
    FConvertCount: longint;
    FConvertBufP: pointer;
    FConvertBufSize: longint;
  protected
    function convertReadBuffer(const buffer; count: longint): longint; virtual;
    function convertWriteBuffer(const buffer; count: longint): longint; virtual;
    procedure setConvertBufSize(newSize: longint); virtual;
  public
    constructor create(target: TStream);
    destructor destroy; override;
    function read(var buffer; count: longint): longint; override;
    function write(const buffer; count: longint): longint; override;
    function seek(offset: longint; origin: word): longint; override;
    procedure freeConvertBuffer;
    property target: TStream read FTarget;
    property convertBufP: pointer read FConvertBufP;
    property convertCount: longint read FConvertCount;
    property convertBufSize: longint read FConvertBufSize;
  end;

  TUTF16BEToUTF8Stream = class(TConversionStream)
  private
    FExpandLF: boolean;
  protected
    function convertWriteBuffer(const buffer; count: longint): longint; override;
  public
    property expandLF: boolean read FExpandLF write FExpandLF;
  end;

  TdomCMNodeList = class;
  TdomCMObject = class;
  TdomCMEntity = class;
  TdomCMExternalObject = class;
  TdomCMInternalObject = class;

  TdomCustomErrorHandler = class;

  TXmlParserAction = (paFail,paRetry,paOK);

  TXmlParserEvent = procedure(      sender: TObject;
                              const parentSystemId: wideString;
                                var publicId,
                                    systemId: wideString;
                                var stream: TStream;
                                var action: TXmlParserAction) of object;

  TDomImplementation = class (TComponent)
  private
    FCreatedCMExternalObjects: TdomCMNodeList;
    FCreatedCMInternalObjects: TdomCMNodeList;
    FCreatedCMObjects: TdomCMNodeList;
    FCreatedDocuments: TdomNodeList;
    FCreatedDocumentTypes: TdomNodeList;
    FCreatedCMExternalObjectsListing: TList;
    FCreatedCMInternalObjectsListing: TList;
    FCreatedCMObjectsListing: TList;
    FCreatedDocumentsListing: TList;
    FCreatedDocumentTypesListing: TList;
    FOnExternalParsedEntity: TXmlParserEvent;
    function getCMExternalObjects: TdomCMNodeList; virtual;
    function getCMInternalObjects: TdomCMNodeList; virtual;
    function getCMObjects: TdomCMNodeList; virtual;
    function getDocuments: TdomNodeList; virtual;
    function getDocumentTypes: TdomNodeList; virtual;
  public
    constructor create(aOwner: TComponent); override;
    destructor destroy; override;
    procedure clear; virtual;
    procedure freeCMExternalObject(var arg: TdomCMExternalObject); virtual;
    procedure freeCMInternalObject(var arg: TdomCMInternalObject); virtual;
    procedure freeCMObject(var arg: TdomCMObject); virtual;
    procedure freeDocument(var doc: TdomDocument); virtual;
    procedure freeDocumentType(var docType: TdomDocumentType); virtual;
    function hasFeature(const feature,
                              version: wideString): boolean; virtual;
    function createCMExternalObject(const pubId,
                                          sysId: wideString): TdomCMExternalObject; virtual;
    function createCMInternalObject(const pubId,
                                          sysId: wideString): TdomCMInternalObject; virtual;
    function createCMObject: TdomCMObject; virtual;
    function createDocument(const name: wideString;
                                  doctype: TdomDocumentType): TdomDocument; virtual;
    function createDocumentNS(const namespaceURI,
                                    qualifiedName: WideString;
                                    doctype: TdomDocumentType): TdomDocument; virtual;

{
  The following two methods have been removed from this version of
  the XDOM, but will be reintroduced in a further release.

    function createDocumentType(const name,
                                      publicId,
                                      systemId,
                                      intSubset: WideString): TdomDocumentType; virtual;
    function createDocumentTypeNS(const qualifiedName,
                                        publicId,
                                        systemId,
                                        intSubset: WideString): TdomDocumentType; virtual;
}

    function getDocumentClass(const aNamespaceUri,
                                    aQualifiedName: wideString): TdomDocumentClass; virtual;
    class procedure registerDocumentFormat(const aNamespaceUri,
                                                 aQualifiedName: wideString;
                                                 aDocumentClass: TdomDocumentClass); virtual;
    function supportsDocumentFormat(const aNamespaceUri,
                                          aQualifiedName: wideString): boolean; virtual;
    class procedure unregisterDocumentClass(const aDocumentClass: TdomDocumentClass); virtual;
    property cmExternalObjects: TdomCMNodeList read getCMExternalObjects;
    property cmInternalObjects: TdomCMNodeList read getCMInternalObjects;
    property cmObjects: TdomCMNodeList read getCMObjects;
    property documents: TdomNodeList read getDocuments;
    property documentTypes: TdomNodeList read getDocumentTypes;
  published
    property onExternalParsedEntity: TXmlParserEvent read FOnExternalParsedEntity write FOnExternalParsedEntity;
  end;

  TdomNodeFilter = class
  public
    function acceptNode(const n: TdomNode): TdomFilterResult; virtual; abstract;
  end;

  TdomTreeWalker = class
  private
    FRoot: TdomNode;
    FCurrentNode: TdomNode;
    FExpandEntityReferences: boolean;
    FWhatToShow: TdomWhatToShow;
    FFilter: TdomNodeFilter;
  protected
    function getCurrentNode: TdomNode; virtual;
    procedure setCurrentNode(const node: TdomNode); virtual;
    function findNextSibling(const oldNode: TdomNode): TdomNode; virtual;
    function findPreviousSibling(const oldNode: TdomNode): TdomNode; virtual;
    function findParentNode(const oldNode: TdomNode): TdomNode; virtual;
    function findFirstChild(const oldNode: TdomNode): TdomNode; virtual;
    function findLastChild(const oldNode: TdomNode): TdomNode; virtual;
    function findNextNode(oldNode: TdomNode): TdomNode; virtual;
    function findPreviousNode(const oldNode: TdomNode): TdomNode; virtual;
  public
    constructor create(const root: TdomNode;
                       const whatToShow: TdomWhatToShow;
                       const nodeFilter: TdomNodeFilter;
                       const entityReferenceExpansion: boolean); virtual;
    function parentNode: TdomNode; virtual;
    function firstChild: TdomNode; virtual;
    function lastChild: TdomNode; virtual;
    function previousSibling: TdomNode; virtual;
    function nextSibling: TdomNode; virtual;
    function nextNode: TdomNode; virtual;
    function previousNode: TdomNode; virtual;
    property currentNode: TdomNode read getCurrentNode write setCurrentNode;
    property expandEntityReferences: boolean read FExpandEntityReferences;
    property filter: TdomNodeFilter read FFilter;
    property root: TdomNode read FRoot;
    property whatToShow: TdomWhatToShow read FWhatToShow;
  end;

  TdomPosition = (posBefore,posAfter);

  TdomNodeIterator = class
  private
    FRoot: TdomNode;
    FReferenceNode: TdomNode;
    FPosition: TdomPosition; // Position of the Iterator relativ to FReferenceNode
    FWhatToShow: TdomWhatToShow;
    FExpandEntityReferences: boolean;
    FFilter: TdomNodeFilter;
    FInvalid: boolean;
  protected
    procedure findNewReferenceNode(const nodeToRemove: TdomNode); virtual; // To be called if the current FReferenceNode is being removed
    function findNextNode(oldNode: TdomNode): TdomNode; virtual;
    function findPreviousNode(const oldNode: TdomNode): TdomNode; virtual;
  public
    constructor create(const root: TdomNode;
                       const whatToShow: TdomWhatToShow;
                       const nodeFilter: TdomNodeFilter;
                       const entityReferenceExpansion: boolean); virtual;
    procedure detach; virtual;
    function nextNode: TdomNode; virtual;
    function previousNode: TdomNode; virtual;
    property expandEntityReferences: boolean read FExpandEntityReferences;
    property filter: TdomNodeFilter read FFilter;
    property root: TdomNode read FRoot;
    property whatToShow: TdomWhatToShow read FWhatToShow;
  end;

  TdomNodeList = class
  private
    FNodeList: TList;
  protected
    function getLength: integer; virtual;
    function indexOf(const node: TdomNode): integer; virtual;
  public
    constructor create(const nodeList: TList);
    function item(const index: integer): TdomNode; virtual;
    property length: integer read getLength;
  end;

  TdomElementsNodeList = class(TdomNodeList)
  private
    FQueryName: WideString;
    FStartElement: TdomNode;
  protected
    function getLength: integer; override;
  public
    function indexOf(const node: TdomNode): integer; override;
    function item(const index: integer): TdomNode; override;
    constructor create(const queryName: wideString;
                       const startElement: TdomNode); virtual;
  end;

  TdomElementsNodeListNS = class(TdomNodeList)
  private
    FQueryNamespaceURI: WideString;
    FQueryLocalName: WideString;
    FStartElement: TdomNode;
  protected
    function getLength: integer; override;
  public
    function indexOf(const node: TdomNode): integer; override;
    function item(const index: integer): TdomNode; override;
    constructor create(const queryNamespaceURI,
                             queryLocalName: wideString;
                       const startElement: TdomNode); virtual;
  end;

  TdomSpecialNodeList = class(TdomNodeList)
  protected
    FAllowedNodeTypes: TDomNodeTypeSet;
    function getLength: integer; override;
    function getNamedIndex(const name: WideString): integer; virtual;
    function getNamedItem(const name: WideString): TdomNode; virtual;
  public
    function indexOf(const node: TdomNode): integer; override;
    function item(const index: integer): TdomNode; override;
    constructor create(const nodeList: TList;
                       const allowedNTs: TDomNodeTypeSet); virtual;
  end;

  TdomNamedNodeMap = class(TdomNodeList)
  private
    FOwner: TdomNode;     // The owner document.
    FOwnerNode: TdomNode; // The node to which the map is attached to.
    FNamespaceAware: boolean;
    FIsReadonly: boolean;
    function getOwnerNode: TdomNode; virtual;
    function getNamespaceAware: boolean; virtual;
    procedure setNamespaceAware(const value: boolean); virtual;
  protected
    FAllowedNodeTypes: TDomNodeTypeSet;
    function getNamedIndex(const name: WideString): integer; virtual;
    function removeItem(const arg: TdomNode): TdomNode; virtual;
    procedure setIsReadonly(const value: boolean); virtual;
  public
    constructor create(const aOwner,
                             aOwnerNode: TdomNode;
                       const nodeList: TList;
                       const allowedNTs: TDomNodeTypeSet); virtual;
    function getNamedItem(const name: WideString): TdomNode; virtual;
    function setNamedItem(const arg: TdomNode): TdomNode; virtual;
    function removeNamedItem(const name: WideString): TdomNode; virtual;
    function getNamedItemNS(const namespaceURI,
                                  localName: WideString): TdomNode; virtual;
    function setNamedItemNS(const arg: TdomNode): TdomNode; virtual;
    function removeNamedItemNS(const namespaceURI,
                                     localName: WideString): TdomNode; virtual;
    property isReadonly: boolean read FIsReadonly;
    property namespaceAware: boolean read getNamespaceAware write setNamespaceAware;
    property ownerNode: TdomNode read getOwnerNode;
  end;

  TdomEntitiesNamedNodeMap = class(TdomNamedNodeMap)
  private
    procedure resolveAfterAddition(const addedEntity: TdomEntity); virtual;
    procedure resolveAfterRemoval(const removedEntity: TdomEntity); virtual;
  public
    function setNamedItem(const arg: TdomNode): TdomNode; override;
    function removeNamedItem(const name: WideString): TdomNode; override;
    function setNamedItemNS(const arg: TdomNode): TdomNode; override;
    function removeNamedItemNS(const namespaceURI,
                                     localName: WideString): TdomNode; override;
  end;

  TdomNode = class
  private
    FNodeName: WideString;
    FNodeValue: WideString;
    FNodeType: TdomNodeType;
    FNodeList: TdomNodeList;
    FNodeListing: TList;
    FDocument: TdomDocument;
    FParentNode: TdomNode;
    FIsReadonly: boolean;
    procedure makeChildrenReadonly; virtual;
    function refersToExternalEntity: boolean; virtual;
    function refersToUnparsedEntity: boolean; virtual;
    function hasEntRef(const entName: widestring): boolean; virtual;
    procedure addEntRefSubtree(const entName: widestring); virtual;
    procedure removeEntRefSubtree(const entName: widestring); virtual;
    function getNodeName: wideString; virtual;
    function getNodeValue: wideString; virtual;
    procedure setNodeValue(const value: WideString); virtual;
    function getNodeType: TdomNodeType; virtual;
    function getAttributes: TdomNamedNodeMap; virtual;
    function getParentNode: TdomNode; virtual;
    function getChildNodes: TdomNodeList; virtual;
    function getFirstChild: TdomNode; virtual;
    function getLastChild: TdomNode; virtual;
    function getPreviousSibling: TdomNode; virtual;
    function getNextSibling: TdomNode; virtual;
    function getDocument: TdomDocument; virtual;
    function getCode: wideString; virtual;
    function getTextContent: wideString; virtual;
  protected
    FAllowedChildTypes: set of TDomNodeType;
    FLocalName: wideString;
    FNamespaceURI: wideString;
    FPrefix: wideString;
    procedure setIsReadonly(const value: boolean); virtual;
    procedure setPrefix(const value: wideString); virtual;
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; virtual;
    function validateIDREFS(const errorHandler: TdomCustomErrorHandler): boolean; virtual;
  public
    constructor create(const aOwner: TdomDocument);
    destructor destroy; override;
    function  appendChild(const newChild: TdomNode): TdomNode; virtual;
    procedure clear; virtual;
    function  cloneNode(const deep: boolean): TdomNode; virtual;
    function  getFirstChildElement(const name: wideString): TdomElement; virtual;
    function  getFirstChildElementNS(const namespaceURI,
                                           localName: WideString): TdomElement; virtual;
    function  getLastChildElement(const name: wideString): TdomElement; virtual;
    function  getLastChildElementNS(const namespaceURI,
                                          localName: WideString): TdomElement; virtual;
    function  getNextSiblingElement(const name: wideString): TdomElement; virtual;
    function  getNextSiblingElementNS(const namespaceURI,
                                            localName: WideString): TdomElement; virtual;
    function  getParentElement(const name: wideString): TdomElement; virtual;
    function  getParentElementNS(const namespaceURI,
                                       localName: WideString): TdomElement; virtual;
    function  getPreviousSiblingElement(const name: wideString): TdomElement; virtual;
    function  getPreviousSiblingElementNS(const namespaceURI,
                                                localName: WideString): TdomElement; virtual;
    function  hasChildNodes: boolean; virtual;
    function  insertBefore(const newChild,
                                 refChild: TdomNode): TdomNode; virtual;
    function  isAncestor(const AncestorNode: TdomNode): boolean; virtual;
    procedure normalize; virtual;
    function  removeChild(const oldChild: TdomNode): TdomNode; virtual;
    function  replaceChild(const newChild,
                                 oldChild: TdomNode): TdomNode; virtual;
    function  resolveEntityReferences(const opt: TdomEntityResolveOption): boolean; virtual;
    function  supports(const feature,
                             version: wideString): boolean; virtual;
    procedure writeCode(Stream: TStream); virtual;
    property attributes:      TdomNamedNodeMap read getAttributes;
    property childNodes:      TdomNodeList     read getChildNodes;
    property code:            wideString       read getCode;
    property firstChild:      TdomNode         read getFirstChild;
    property isReadonly:      boolean          read FIsReadonly;
    property lastChild:       TdomNode         read getLastChild;
    property localName:       wideString       read FLocalName;
    property namespaceURI:    wideString       read FNamespaceURI;
    property nextSibling:     TdomNode         read getNextSibling;
    property nodeName:        wideString       read getNodeName;
    property nodeType:        TdomNodeType     read getNodeType;
    property nodeValue:       wideString       read getNodeValue write setNodeValue;
    property ownerDocument:   TdomDocument     read getDocument;
    property parentNode:      TdomNode         read getParentNode;
    property previousSibling: TdomNode         read getPreviousSibling;
    property prefix:          wideString       read FPrefix write setPrefix;
    property textContent:     wideString       read getTextContent;
  end;

  TdomCharacterData = class (TdomNode)
  private
    function getData: wideString; virtual;
    procedure setData(const Value: wideString); virtual;
    function getLength: integer; virtual;
  public
    constructor create(const aOwner: TdomDocument); virtual;
    function substringData(const offset,
                                 count: integer): wideString; virtual;
    procedure appendData(const arg: wideString); virtual;
    procedure insertData(const offset: integer;
                         const arg: wideString); virtual;
    procedure deleteData(const offset,
                               count: integer); virtual;
    procedure replaceData(const offset,
                                count: integer;
                          const arg: wideString); virtual;
    property data: wideString read getData write setData;
    property length: integer read getLength;
  end;

  TdomAttr = class (TdomNode)
  private
    FOwnerElement: TdomElement;
    FSpecified: boolean;
    function getName: wideString; virtual;
    function getSpecified: boolean; virtual;
    function getNodeValue: wideString; override;
    procedure setNodeValue(const value: wideString); override;
    function getValue: wideString; virtual;
    procedure setValue(const value: wideString); virtual;
    function getOwnerElement: TdomElement; virtual;
    function getParentNode: TdomNode; override;
    function getPreviousSibling: TdomNode; override;
    function getNextSibling: TdomNode; override;
    function getLiteralValue: wideString; virtual;
  protected
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; override;
    function validateIDREFS(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomDocument;
                       const name: wideString;
                       const spcfd: boolean);
    constructor createNS(const aOwner: TdomDocument;
                         const namespaceURI,
                               qualifiedName: wideString;
                         const spcfd: boolean);
    procedure normalize; override;
    function  resolveEntityReferences(const opt: TdomEntityResolveOption): boolean; override;
    procedure writeCode(stream: TStream); override;
    property literalValue: wideString read getLiteralValue;
    property name: wideString read getName;
    property ownerElement: TdomElement read getOwnerElement;
    property specified: boolean read getSpecified;
    property value: wideString read getValue write setValue;
  end;

  TdomElement = class (TdomNode)
  private
    FCreatedElementsNodeLists: TList;
    FCreatedElementsNodeListNSs: TList;
    FAttributeListing: TList;
    FAttributeList: TdomNamedNodeMap;
    procedure setNodeValue(const value: wideString); override;
  protected
    procedure setIsReadonly(const value: boolean); override;
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; override;
    function validateIDREFS(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomDocument;
                       const tagName: wideString);
    constructor createNS(const aOwner: TdomDocument;
                         const namespaceURI,
                               qualifiedName: wideString);
    destructor destroy; override;
    function getTagName: wideString; virtual;
    function getAttributes: TdomNamedNodeMap; override;
    function getAttribute(const name: wideString): wideString; virtual;
    function setAttribute(const name,
                                value: wideString): TdomAttr; virtual;
    function removeAttribute(const name: wideString): TdomAttr; virtual;
    function getAttributeNode(const name: wideString): TdomAttr; virtual;
    function setAttributeNode(const newAttr: TdomAttr): TdomAttr; virtual;
    function removeAttributeNode(const oldAttr: TdomAttr): TdomAttr; virtual;
    function resolveEntityReferences(const opt: TdomEntityResolveOption): boolean; override;
    function getElementsByTagName(const name: wideString): TdomNodeList; virtual;
    function getAttributeNS(const namespaceURI,
                                  localName: wideString): wideString; virtual;
    function setAttributeNS(const namespaceURI,
                                  qualifiedName,
                                  value: wideString): TdomAttr; virtual;
    function removeAttributeNS(const namespaceURI,
                                     localName: wideString): TdomAttr; virtual;
    function getAttributeNodeNS(const namespaceURI,
                                      localName: wideString): TdomAttr; virtual;
    function setAttributeNodeNS(const newAttr: TdomAttr): TdomAttr; virtual;
    function getElementsByTagNameNS(const namespaceURI,
                                          localName: wideString): TdomNodeList; virtual;
    function hasAttribute(const name: wideString): boolean; virtual;
    function hasAttributeNS(const namespaceURI,
                                  localName: wideString): boolean; virtual;
    procedure normalize; override;
    procedure writeCode(Stream: TStream); override;
    property tagName: wideString read getTagName;
  end;

  TdomText = class (TdomCharacterData)
  protected
    function getIsWhitespaceInElementContent: boolean; virtual;
    function getLiteralValue: wideString; virtual;
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomDocument); override;
    function splitText(const offset: integer): TdomText; virtual;
    procedure writeCode(stream: TStream); override;
    property isWhitespaceInElementContent: boolean read getIsWhitespaceInElementContent;
    property literalValue: wideString read getLiteralValue;
  end;

  TdomComment = class (TdomCharacterData)
  protected
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomDocument); override;
    procedure writeCode(stream: TStream); override;
  end;

  TdomProcessingInstruction = class (TdomNode)
  private
    function getTarget: wideString; virtual;
    function getData: wideString; virtual;
    procedure setData(const value: wideString); virtual;
  protected
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomDocument;
                       const targ: wideString); virtual;
    procedure writeCode(Stream: TStream); override;
    property target: wideString read getTarget;
    property data: wideString read getData write setData;
  end;

  TdomCDATASection = class (TdomText)
  protected
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomDocument); override;
    procedure writeCode(stream: TStream); override;
  end;

  TdomDocumentType = class (TdomNode)
  private
    FInternalSubset: wideString;
    FPublicId: wideString;
    FSystemId: wideString;
    FEntitiesListing: TList;
    FEntitiesList: TdomEntitiesNamedNodeMap;
    FNotationsListing: TList;
    FNotationsList: TdomNamedNodeMap;
    function getEntities: TdomEntitiesNamedNodeMap; virtual;
    function getInternalSubset: wideString; virtual;
    function getName: wideString; virtual;
    function getNotations: TdomNamedNodeMap; virtual;
    function getPublicId: wideString; virtual;
    function getSystemId: wideString; virtual;
    procedure setNodeValue(const value: wideString); override;
  protected  
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomDocument;
                       const name,
                             pubId,
                             sysId,
                             intSubset: wideString); virtual;
    destructor  destroy; override;
    procedure writeCode(stream: TStream); override;
    property entities: TdomEntitiesNamedNodeMap read getEntities;
    property internalSubset: wideString read getInternalSubset;
    property name: wideString read getName;
    property notations: TdomNamedNodeMap read getNotations;
    property publicId: wideString read getPublicId;
    property systemId: wideString read getSystemId;
  end;

  TdomNotation = class (TdomNode)
  private
    FPublicId: wideString;
    FSystemId: wideString;
    function getPublicId: wideString; virtual;
    function getSystemId: wideString; virtual;
    procedure setNodeValue(const value: wideString); override;
  public
    constructor create(const aOwner: TdomDocument;
                       const name,
                             pubId,
                             sysId: wideString); virtual;
    property publicId: wideString read getPublicId;
    property systemId: wideString read getSystemId;
  end;

  TdomEntity = class (TdomNode)
  private
    FEncoding: wideString;
    FIsInternalEntity: boolean;
    FIsUnusable: boolean;
    FNotationName: wideString;
    FPublicId: wideString;
    FSystemId: wideString;
    FVersion: wideString;
    function  getNotationName: wideString; virtual;
    procedure setNodeValue(const value: wideString); override;
  public
    constructor create(const aOwner: TdomDocument;
                       const name,
                             pubId,
                             sysId,
                             notaName: wideString); virtual;
    function insertBefore(const newChild,
                                refChild: TdomNode): TdomNode; override;
    function replaceChild(const newChild,
                                oldChild: TdomNode): TdomNode; override;
    function appendChild(const newChild: TdomNode): TdomNode; override;
    property encoding: wideString read FEncoding write FEncoding;
    property isInternalEntity: boolean read FIsInternalEntity;
    property notationName: wideString read getNotationName;
    property publicId: wideString read FPublicId;
    property systemId: wideString read FSystemId;
    property version: wideString read FVersion write FVersion;
  end;

  TdomEntityReference = class (TdomNode)
  private
    function refersToUnparsedEntity: boolean; override;
    function getCorrespondingCMEntity: TdomCMEntity; virtual;
    function getRefersToPredefinedEntity: boolean; virtual;
    procedure setNodeValue(const value: wideString); override;
  protected
    function expand: boolean; virtual;
    function validate2(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomDocument;
                       const name: wideString); virtual;
    function cloneNode(const deep: boolean): TdomNode; override;
    function  resolveEntityReferences(const opt: TdomEntityResolveOption): boolean; override;
    procedure writeCode(stream: TStream); override;
    property correspondingCMEntity: TdomCMEntity read getCorrespondingCMEntity;
    property refersToPredefinedEntity: boolean read getRefersToPredefinedEntity;
  end;

  TdomDocumentFragment = class (TdomNode)
  private
    procedure setNodeValue(const value: wideString); override;
  public
    constructor create(const aOwner: TdomDocument); virtual;
  end;

  TdomDocument = class (TdomNode)
  private
    FCreatedNodes: TList;
    FCreatedNodeIterators: TList;
    FCreatedTreeWalkers: TList;
    FCreatedElementsNodeLists: TList;
    FCreatedElementsNodeListNSs: TList;
    FIDs: TStringList;
    FCMInternal: TdomCMObject;
    FSystemId: wideString;
    FDefaultView: TdomAbstractView;
    FDOMImpl: TDomImplementation;
    FEncoding: wideString;
    FStandalone: wideString;
    FVersion: wideString;
    function  expandEntRef(const node: TdomEntityReference): boolean; virtual;
    procedure findNewReferenceNodes(const nodeToRemove: TdomNode); virtual;
    function  getCodeAsString: String; virtual;
    function  getCodeAsWideString: wideString; virtual;
    function  getDoctype: TdomDocumentType; virtual;
    function  getDocumentElement: TdomElement; virtual;
    procedure setNodeValue(const value: wideString); override;
  protected
    function createEntity(const name,
                                pubId,
                                sysId,
                                notaName: wideString): TdomEntity; virtual;
    function createNotation(const name,
                                  pubId,
                                  sysId: wideString): TdomNotation; virtual;
    function duplicateNode(const sourceNode: TdomNode;
                           const deep: boolean): TdomNode; virtual;
    procedure initDoc(const tagName: wideString); virtual;
    procedure initDocNS(const namespaceURI,
                              qualifiedName: wideString); virtual;
    function validateIDREFS(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TDomImplementation); virtual;
    destructor destroy; override;
    procedure clear; override;
    procedure clearInvalidNodeIterators; virtual;
    function createElement(const tagName: wideString): TdomElement; virtual;
    function createElementNS(const namespaceURI,
                                   qualifiedName: wideString): TdomElement; virtual;
    function createDocumentFragment: TdomDocumentFragment; virtual;
    function createTextNode(const data: wideString): TdomText; virtual;
    function createComment(const data: wideString): TdomComment; virtual;
    function createCDATASection(const data: wideString): TdomCDATASection; virtual;
    function createProcessingInstruction(const targ,
                                               data : wideString): TdomProcessingInstruction; virtual;
    function createAttribute(const name: wideString): TdomAttr; virtual;
    function createAttributeNS(const namespaceURI,
                                     qualifiedName: wideString): TdomAttr; virtual;
    function createEntityReference(const name: wideString): TdomEntityReference; virtual;
    function createDocumentType(const name,
                                      pubId,
                                      sysId,
                                      intSubset: wideString): TdomDocumentType; virtual;
    procedure freeAllNodes(var node: TdomNode); virtual;
    procedure freeTreeWalker(var treeWalker: TdomTreeWalker); virtual;
    function getElementById(const elementId: wideString): TdomElement; virtual;
    function getElementsByTagName(const tagName: wideString): TdomNodeList; virtual;
    function getElementsByTagNameNS(const namespaceURI,
                                          localName: wideString): TdomNodeList; virtual;
    function importNode(const importedNode: TdomNode;
                        const deep: boolean): TdomNode; virtual;
    function insertBefore(const newChild,
                                refChild: TdomNode): TdomNode; override;
    function replaceChild(const newChild,
                                oldChild: TdomNode): TdomNode; override;
    function appendChild(const newChild: TdomNode): TdomNode; override;
    function createNodeIterator(const root: TdomNode;
                                      whatToShow: TdomWhatToShow;
                                      nodeFilter: TdomNodeFilter;
                                      entityReferenceExpansion: boolean): TdomNodeIterator; virtual;
    function createTreeWalker(const root: TdomNode;
                                    whatToShow: TdomWhatToShow;
                                    nodeFilter: TdomNodeFilter;
                                    entityReferenceExpansion: boolean): TdomTreeWalker; virtual;
    function removeContentModel: TdomCMObject; virtual;
    function setContentModel(const arg: TdomCMObject): TdomCMObject; virtual;
    function validate(const errorHandler: TdomCustomErrorHandler;
                      const opt: TdomEntityResolveOption): boolean; virtual;
    procedure writeCode(stream: TStream); override;
    procedure writeCodeAsUTF8(stream: TStream); virtual;
    procedure writeCodeAsUTF16(stream: TStream); virtual;
    property codeAsString: string read getCodeAsString;
    property codeAsWideString: wideString read getCodeAsWideString;
    property contentModel: TdomCMObject read FCMInternal;
    property defaultView: TdomAbstractView read FDefaultView;
    property doctype: TdomDocumentType read getDoctype;
    property documentElement: TdomElement read getDocumentElement;
    property domImplementation: TdomImplementation read FDomImpl;
    property encoding: wideString read FEncoding write FEncoding;
    property IDs: TStringList read FIDs;
    property standalone: wideString read FStandalone write FStandalone;
    property systemId: wideString read FSystemId write FSystemId;
    property version: wideString read FVersion write FVersion;
  end;


// Content Model

  TdomCMNodeType = (ctUnknown,
                    ctProcessingInstruction,
                    ctComment,
                    ctObject,
                    ctFragment,
                    ctExternalObject,
                    ctInternalObject,
                    ctAttribute,
                    ctNotation,
                    ctEntity,
                    ctParameterEntity,
                    ctParameterEntityReference,
                    ctEntityDeclaration,
                    ctParameterEntityDeclaration,
                    ctElementTypeDeclaration,
                    ctSequenceParticle,
                    ctChoiceParticle,
                    ctPcdataChoiceParticle,
                    ctElementParticle,
                    ctAttributeList,
                    ctAttributeDefinition,
                    ctNotationDeclaration,
                    ctNameParticle,
                    ctNmtokenParticle);

  TdomCMNodeTypeSet = set of TdomCMNodeType;

  TdomCMNode = class;
  TdomCustomCMObject = class;
  TdomCMParameterEntityReference = class;
  TdomCMEntityDeclaration = class;
  TdomCMElementParticle = class;
  TdomCMNameParticle = class;
  TdomCMNmtokenParticle = class;
  TdomCMElementTypeDeclaration = class;
  TdomCMParameterEntityDeclaration = class;
  TdomCMFragment = class;
  TdomCMNotationDeclaration = class;
  TdomCMAttrDefinition = class;
  TdomCMAttrList = class;
  TdomCMChoiceParticle = class;
  TdomCMAttribute = class;
  TdomCMNotation = class;
  TdomCMParameterEntity = class;
  TdomCMPcdataChoiceParticle = class;
  TdomCMSequenceParticle = class;

  TdomStandardErrorHandler = class;

  TdomCMNodeList = class
  private
    FCMNodeList: TList;
    function getLength: integer; virtual;
  protected
    function indexOf(const node: TdomCMNode): integer; virtual;
  public
    function item(const index: integer): TdomCMNode; virtual;
    constructor create(const CMNodeList: TList);
    property length: integer read getLength;
  end;

  TdomNamedCMNodeMap = class(TdomCMNodeList)
  private
    FOwner: TdomCMNode;     // The owner document.
    FOwnerNode: TdomCMNode; // The node to which the map is attached to.
    FIsReadonly: boolean;
    function getOwnerNode: TdomCMNode; virtual;
  protected
    FAllowedNodeTypes: TDomCMNodeTypeSet;
    function getNamedIndex(const name: wideString): integer; virtual;
    function removeItem(const arg: TdomCMNode): TdomCMNode; virtual;
    procedure setIsReadonly(const value: boolean); virtual;
  public
    constructor create(const aOwner,
                             aOwnerNode: TdomCMNode;
                       const nodeList: TList;
                       const allowedNTs: TDomCMNodeTypeSet); virtual;
    function getNamedItem(const name: wideString): TdomCMNode; virtual;
    function setNamedItem(const arg: TdomCMNode): TdomCMNode; virtual;
    function removeNamedItem(const name: wideString): TdomCMNode; virtual;
    property isReadonly: boolean read FIsReadonly;
    property ownerNode: TdomCMNode read getOwnerNode;
  end;

  TdomNamedCMAttributeMap = class
  private
    FOwner: TdomCMObject;     // The owner document.
    FCMAttributesList: TList;
    function getLength: integer; virtual;
  public
    constructor create(const aOwner: TdomCMObject);
    destructor destroy; override;
    function item(const index: integer): TdomCMAttribute; virtual;
    function getNamedItem(const elementName,
                                attributeName: wideString): TdomCMAttribute; virtual;
    function appendNamedItem(const arg: TdomCMAttribute): boolean; virtual;
    function removeLastItem: TdomCMAttribute; virtual;
    property length: integer read getLength;
    property ownerContentModel: TdomCMObject read FOwner;
  end;

  TdomNamedCMEntityMap = class
  private
    FOwner: TdomCMObject;     // The owner document.
    FCMEntitiesList: TList;
    function getLength: integer; virtual;
  public
    constructor create(const aOwner: TdomCMObject);
    destructor destroy; override;
    function item(const index: integer): TdomCMEntity; virtual;
    function getNamedItem(const name: wideString): TdomCMEntity; virtual;
    function appendNamedItem(const arg: TdomCMEntity): boolean; virtual;
    function removeLastItem: TdomCMEntity; virtual;
    property length: integer read getLength;
    property ownerContentModel: TdomCMObject read FOwner;
  end;

  TdomCMNode = class
  private
    FNodeName: wideString;
    FNodeValue: wideString;
    FNodeType: TdomCMNodeType;
    FCMNodeList: TdomCMNodeList;
    FCMNodeListing: TList;
    FCMObject: TdomCustomCMObject;
    FParentNode: TdomCMNode;
    FIsReadonly: boolean;
    procedure makeChildrenReadonly; virtual;
    function getNodeName: wideString; virtual;
    function getNodeValue: wideString; virtual;
    procedure setNodeValue(const value: wideString); virtual;
    function getCMNodeType: TdomCMNodeType; virtual;
    function getParentNode: TdomCMNode; virtual;
    function getChildNodes: TdomCMNodeList; virtual;
    function getFirstChild: TdomCMNode; virtual;
    function getLastChild: TdomCMNode; virtual;
    function getPreviousSibling: TdomCMNode; virtual;
    function getNextSibling: TdomCMNode; virtual;
    function getCMObject: TdomCustomCMObject; virtual;
    function getCode: wideString; virtual;
  protected
    FAllowedChildTypes: set of TDomCMNodeType;
    procedure setIsReadonly(const value: boolean); virtual;
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; virtual;
  public
    constructor create(const aOwner: TdomCustomCMObject);
    destructor destroy; override;
    procedure clear; virtual;
    function insertBefore(const newChild,
                                refChild: TdomCMNode): TdomCMNode; virtual;
    function replaceChild(const newChild,
                                oldChild: TdomCMNode): TdomCMNode; virtual;
    function removeChild(const oldChild: TdomCMNode): TdomCMNode; virtual;
    function appendChild(const newChild: TdomCMNode): TdomCMNode; virtual;
    function hasChildNodes: boolean; virtual;
    function cloneNode(const deep: boolean): TdomCMNode; virtual;
    function isAncestor(const ancestorNode: TdomCMNode): boolean; virtual;
    procedure writeCode(stream: TStream); virtual;
    property childNodes:      TdomCMNodeList     read getChildNodes;
    property code:            wideString         read getCode;
    property firstChild:      TdomCMNode         read getFirstChild;
    property isReadonly:      boolean            read FIsReadonly;
    property lastChild:       TdomCMNode         read getLastChild;
    property nextSibling:     TdomCMNode         read getNextSibling;
    property nodeName:        wideString         read getNodeName;
    property nodeType:        TdomCMNodeType     read getCMNodeType;
    property nodeValue:       wideString         read getNodeValue write setNodeValue;
    property ownerCMObject:   TdomCustomCMObject read getCMObject;
    property parentNode:      TdomCMNode         read getParentNode;
    property previousSibling: TdomCMNode         read getPreviousSibling;
  end;

  TdomCMComment = class (TdomCMNode)
  private
    function getData: wideString; virtual;
    procedure setData(const value: wideString); virtual;
    function getLength: integer; virtual;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject); virtual;
    function substringData(const offset,
                                 count: integer):wideString; virtual;
    procedure appendData(const arg: wideString); virtual;
    procedure insertData(const offset: integer;
                         const arg: wideString); virtual;
    procedure deleteData(const offset,
                               count: integer); virtual;
    procedure replaceData(const offset,
                                count: integer;
                          const arg: wideString); virtual;
    procedure writeCode(stream: TStream); override;
    property data: wideString read getData write setData;
    property length: integer read getLength;
  end;

  TdomCMProcessingInstruction = class (TdomCMNode)
  private
    function getTarget: wideString; virtual;
    function getData: wideString; virtual;
    procedure setData(const value: wideString); virtual;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const targ: wideString); virtual;
    procedure writeCode(stream: TStream); override;
    property target: wideString read getTarget;
    property data: wideString read getData write setData;
  end;

  TdomCustomCMObject = class (TdomCMNode)
  private
    FCreatedNodes: TList;
    FDomImpl: TDomImplementation;
    procedure setNodeValue(const value: wideString); override;
  protected
    function duplicateCMNode(const node: TdomCMNode): TdomCMNode; virtual;
  public
    constructor create(const aOwner: TdomImplementation);
    destructor destroy; override;
    function createCMAttributeDefinition(const name,
                                               attType,
                                               defaultDecl,
                                               attValue: wideString) : TdomCMAttrDefinition; virtual;
    function createCMAttributeList(const name: wideString): TdomCMAttrList; virtual;
    function createCMChoiceParticle(const freq: wideString): TdomCMChoiceParticle; virtual;
    function createCMComment(const data: wideString): TdomCMComment; virtual;
    function createCMElementParticle(const name,
                                           freq: wideString): TdomCMElementParticle; virtual;
    function createCMElementTypeDeclaration(const name: wideString;
                                            const ContspecType: TdomContentspecType): TdomCMElementTypeDeclaration; virtual;
    function createCMEntityDeclaration(const name,
                                             entityValue,
                                             pubId,
                                             sysId,
                                             notaName: wideString): TdomCMEntityDeclaration; virtual;
    function createCMFragment: TdomCMFragment; virtual;
    function createCMNameParticle(const name: wideString): TdomCMNameParticle; virtual;
    function createCMNmtokenParticle(const name: wideString): TdomCMNmtokenParticle; virtual;
    function createCMNotationDeclaration(const name,
                                               pubId,
                                               sysId: wideString): TdomCMNotationDeclaration; virtual;
    function createCMParameterEntityDeclaration(const name,
                                                      entityValue,
                                                      pubId,
                                                      sysId: wideString): TdomCMParameterEntityDeclaration; virtual;
    function createCMParameterEntityReference(const name: wideString): TdomCMParameterEntityReference; virtual;
    function createCMPcdataChoiceParticle: TdomCMPcdataChoiceParticle; virtual;
    function createCMProcessingInstruction(const targ,
                                                 data : wideString): TdomCMProcessingInstruction; virtual;
    function createCMSequenceParticle(const freq: wideString): TdomCMSequenceParticle; virtual;
    procedure freeAllCMNodes(var CMNode: TdomCMNode); virtual;
    property domImplementation: TdomImplementation read FDomImpl;
  end;

  TdomCMObject = class (TdomCustomCMObject)
  private
    FAssociatedDocument: TdomDocument;
    FAttributesList: TdomNamedCMAttributeMap;
    FCMExternal: TdomCMExternalObject;
    FCMInternal: TdomCMInternalObject;
    FEntitiesList: TdomNamedCMEntityMap;
    FParameterEntitiesList: TdomNamedCMNodeMap;
    FParameterEntitiesListing: TList;
    FNotationsList: TdomNamedCMNodeMap;
    FNotationsListing: TList;
    FElementTypesList: TdomNamedCMNodeMap;
    FElementTypesListing: TList;
    procedure clearAttributes;
    procedure clearElementTypes;
    procedure clearEntities;
    procedure clearNotations;
    procedure clearParameterEntities;
  protected
    procedure prepareCM(const errorHandler: TdomCustomErrorHandler); virtual;
    function duplicateCMNode(const node: TdomCMNode): TdomCMNode; override;
    function createCMAttribute(const elementName,
                                     attributeName,
                                     attType,
                                     defaultDecl,
                                     attValue: wideString): TdomCMAttribute; virtual;
    function createCMEntity(const name,
                                  literalValue,
                                  pubId,
                                  sysId,
                                  versionNumber,
                                  notaName: wideString): TdomCMEntity; virtual;
    function createCMNotation(const name,
                                    pubId,
                                    sysId: wideString): TdomCMNotation; virtual;
    function createCMParameterEntity(const name,
                                           value,
                                           pubId,
                                           sysId,
                                           versionNumber: wideString): TdomCMParameterEntity;
    function setPredefinedEntities(const errorHandler: TdomCustomErrorHandler): boolean; virtual;
  public
    constructor create(const aOwner: TdomImplementation); virtual;
    destructor destroy; override;
    procedure clear; override;
    procedure prepare; virtual;
    function removeExternalCM: TdomCMExternalObject; virtual;
    function removeInternalCM: TdomCMInternalObject; virtual;
    function setExternalCM(const arg: TdomCMExternalObject): TdomCMExternalObject; virtual;
    function setInternalCM(const arg: TdomCMInternalObject): TdomCMInternalObject; virtual;
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
    property associatedDocument: TdomDocument read FAssociatedDocument;
    property attributes: TdomNamedCMAttributeMap read FAttributesList;
    property elementTypes: TdomNamedCMNodeMap read FElementTypesList;
    property entities: TdomNamedCMEntityMap read FEntitiesList;
    property notations: TdomNamedCMNodeMap read FNotationsList;
    property parameterEntities: TdomNamedCMNodeMap read FParameterEntitiesList;
    property externalCM: TdomCMExternalObject read FCMExternal;
    property internalCM: TdomCMInternalObject read FCMInternal;
  end;

  TdomCustomCMIEObject = class (TdomCustomCMObject)
  protected
    FAssociatedContentModel: TdomCMObject;
    FPublicId: wideString;
    FSystemId: wideString;
    FParameterEntitiesList: TdomNameValueList;
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomImplementation;
                       const pubId,
                             sysId: wideString);
    destructor destroy; override;
    property associatedContentModel: TdomCMObject read FAssociatedContentModel;
    property publicId: wideString read FPublicId;
    property systemId: wideString read FSystemId;
  end;

  TdomCMInternalObject = class (TdomCustomCMIEObject)
  public
    constructor create(const aOwner: TdomImplementation;
                       const pubId,
                             sysId: wideString);
  end;

  TdomCMExternalObject = class (TdomCustomCMIEObject)
  protected
    FEncoding: wideString;
    FVersion: wideString;
  public
    constructor create(const aOwner: TdomImplementation;
                       const pubId,
                             sysId: wideString);
    property encoding: wideString read FEncoding write FEncoding;
    property version: wideString read FVersion write FVersion;
  end;

  TdomCMNotationDeclaration = class (TdomCMNode)
  private
    FPublicId: wideString;
    FSystemId: wideString;
    function getPublicId: wideString; virtual;
    function getSystemId: wideString; virtual;
    procedure setNodeValue(const value: wideString); override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             pubId,
                             sysId: wideString); virtual;
    procedure writeCode(stream: TStream); override;
    property publicId: wideString read getPublicId;
    property systemId: wideString read getSystemId;
  end;

  TdomCMElementTypeDeclaration = class (TdomCMNode)
  private
    FContentspec: TdomContentspecType;
    function getContentspec: wideString; virtual;
    function getContentspecType: TdomContentspecType; virtual;
    procedure setNodeValue(const value: wideString); override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
    procedure writeContentspec(stream: TStream); virtual;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name: wideString;
                       const contspecType: TdomContentspecType); virtual;
    function appendChild(const newChild: TdomCMNode): TdomCMNode; override;
    function insertBefore(const newChild,
                                refChild: TdomCMNode): TdomCMNode; override;
    procedure writeCode(stream: TStream); override;
    property contentspec: wideString read getContentspec;
    property contentspecType: TdomContentspecType read getContentspecType;
  end;

  TdomCMAttrList = class(TdomCMNode)
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name: wideString); virtual;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMAttrDefinition = class(TdomCMNode)
  private
    FAttributeType: wideString;
    FDefaultDeclaration: wideString;
    FParentAttributeList: TdomCMAttrList;
    function getAttributeType: wideString; virtual;
    function getDefaultDeclaration: wideString; virtual;
    procedure setNodeValue(const value: wideString); override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             attType,
                             defaultDecl,
                             attValue: wideString); virtual;
    procedure writeCode(stream: TStream); override;
    property attributeType: wideString read getAttributeType;
    property defaultDeclaration: wideString read getDefaultDeclaration;
  end;

  TdomCMParticle = class (TdomCMNode)
  private
    FFrequency: wideString;
    function contentModelTest2(const source,
                                     rest: TStringList;
                               const freq: wideString): boolean; virtual;
    function contentModelTest(const source,
                                    rest: TStringList): boolean; virtual;
    function  getFrequency: wideString; virtual;
    procedure setFrequency(const freq: wideString); virtual;
    procedure setNodeValue(const value: wideString); override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const freq: wideString);
    property frequency: wideString read getFrequency;
  end;

  TdomCMSequenceParticle = class (TdomCMParticle)
  private
    function contentModelTest2(const source,
                                     rest: TStringList;
                               const freq: wideString): boolean; override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const freq: wideString); virtual;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMChoiceParticle = class (TdomCMParticle)
  private
    function contentModelTest2(const source,
                                     rest: TStringList;
                               const freq: wideString): boolean; override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const freq: wideString); virtual;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMPcdataChoiceParticle = class (TdomCMParticle)
  private
    function contentModelTest(const source,
                                    rest: TStringList): boolean; override;
    procedure setFrequency(const freq: wideString); override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const freq: wideString); virtual;
    function elementDefined(const elementName: wideString): boolean;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMElementParticle = class (TdomCMParticle)
  private
    function contentModelTest2(const source,
                                     rest: TStringList;
                               const freq: wideString): boolean; override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             freq: wideString); virtual;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMNameParticle = class (TdomCMNode)
  private
    procedure setNodeValue(const value: wideString); override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name: wideString); virtual;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMNmtokenParticle = class (TdomCMNode)
  private
    procedure setNodeValue(const value: wideString); override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name: wideString); virtual;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMAttribute = class (TdomCMNode)
  private
    FAttributeName: wideString;
    FAttributeType: wideString;
    FDefaultDeclaration: wideString;
    FElementName: wideString;
    procedure setNodeValue(const value: wideString); override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const elementName,
                             attributeName,
                             attType,
                             defaultDecl,
                             attValue: wideString); virtual;
    property attributeName: wideString read FAttributeName;
    property attributeType: wideString read FAttributeType;
    property defaultDeclaration: wideString read FDefaultDeclaration;
    property elementName: wideString read FElementName;
  end;

  TdomCMNotation = class (TdomCMNode)
  private
    FPublicId: wideString;
    FSystemId: wideString;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             pubId,
                             sysId: wideString); virtual;
    property publicId: wideString read FPublicId;
    property systemId: wideString read FSystemId;
  end;

  TdomCMEntity = class (TdomCMNode)
  private
    FEncoding: wideString;
    FIsInternalEntity: boolean;
    FIsParsedEntity: boolean;
    FIsUnusable: boolean;
    FLiteralValue: wideString;
    FNotationName: wideString;
    FPublicId: wideString;
    FReplacementText: wideString;
    FSystemId: wideString;
    FVersion: wideString;
    function calculateReplacementText(S: wideString): wideString; virtual;
    function getIsUnusable: boolean; virtual;
    function getNormalizedValue: wideString; virtual;
    function getResolvedValue: wideString; virtual;
    function refersToXyz(const allowUnresolvableEntities: boolean;
                         const previousEntities: TStringList;
                         const whatToTest: integer): boolean;
    procedure setIsUnusable(const value: boolean); virtual;
    procedure setNodeValue(const value: wideString); override;
  protected
    function refersToExternalEntity(const allowUnresolvableEntities: boolean): boolean; virtual;
    function refersToUnparsedEntity(const allowUnresolvableEntities: boolean): boolean; virtual;
    function refersToUnusableEntity(const allowUnresolvableEntities: boolean): boolean; virtual;
    procedure testForCircularReference(const allowUnresolvableEntities: boolean); virtual;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             literalValue,
                             pubId,
                             sysId,
                             versionNumber,
                             notaName: wideString); virtual;
    property encoding: wideString read FEncoding write FEncoding;
    property isInternalEntity: boolean read FIsInternalEntity;
    property isParsedEntity: boolean read FIsParsedEntity;
    property isUnusable: boolean read getIsUnusable write setIsUnusable default false;  // xxx default?
    property literalValue: wideString read FLiteralValue;
    property normalizedValue: wideString read getNormalizedValue;
    property notationName: wideString read FNotationName;
    property publicId: wideString read FPublicId;
    property replacementText: wideString read FReplacementText;
    property resolvedValue: wideString read getResolvedValue;
    property systemId: wideString read FSystemId;
    property version: wideString read FVersion;
  end;

  TdomCMParameterEntity = class (TdomCMNode)
  private
    FEncoding: wideString;
    FIsInternalEntity: boolean;
    FIsUnusable: boolean;
    FPublicId: wideString;
    FSystemId: wideString;
    FVersion: wideString;
  protected
    function  getIsUnusable: boolean; virtual;
    procedure setIsUnusable(const value: boolean); virtual;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             entityValue,
                             pubId,
                             sysId,
                             versionNumber: wideString); virtual;
    property encoding: wideString read FEncoding write FEncoding;
    property isInternalEntity: boolean read FIsInternalEntity;
    property isUnusable: boolean read getIsUnusable default false;
    property publicId: wideString read FPublicId;
    property systemId: wideString read FSystemId;
    property version: wideString read FVersion;
  end;

  TdomCustomCMEntDecl = class (TdomCMNode)
  private
    FPublicId: wideString;
    FSystemId: wideString;
    FIsInternalEntity: boolean;
    function getIsInternalEntity: boolean; virtual;
    function getPublicId: wideString; virtual;
    function getSystemId: wideString; virtual;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             pubId,
                             sysId: wideString);
    function insertBefore(const newChild,
                                refChild: TdomCMNode): TdomCMNode; override;
    function replaceChild(const newChild,
                                oldChild: TdomCMNode): TdomCMNode; override;
    function appendChild(const newChild: TdomCMNode): TdomCMNode; override;
    property publicId: wideString read getPublicId;
    property systemId: wideString read getSystemId;
    property isInternalEntity: boolean read getIsInternalEntity;
  end;

  TdomCMEntityDeclaration = class (TdomCustomCMEntDecl)
  private
    FIsParsedEntity: boolean;
    FNotationName: wideString;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             entityValue,
                             pubId,
                             sysId,
                             notaName: wideString); virtual;
    procedure writeCode(stream: TStream); override;
    property isParsedEntity: boolean read FIsParsedEntity;
    property notationName: wideString read FNotationName;
  end;

  TdomCMParameterEntityDeclaration = class (TdomCustomCMEntDecl)
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name,
                             entityValue,
                             pubId,
                             sysId: wideString); virtual;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMParameterEntityReference = class (TdomCMNode)
  private
    procedure setNodeValue(const value: wideString); override;
  protected
    function validate(const errorHandler: TdomCustomErrorHandler): boolean; override;
  public
    constructor create(const aOwner: TdomCustomCMObject;
                       const name: wideString); virtual;
    procedure writeCode(stream: TStream); override;
  end;

  TdomCMFragment = class (TdomCMNode)
  private
    procedure setNodeValue(const value: wideString); override;
  public
    constructor create(const aOwner: TdomCustomCMObject); virtual;
  end;


// Views

  TdomAbstractView = class
  private
    FDocument: TdomDocument;
  public
    property document: TdomDocument read FDocument;
  end;

  TdomStyleSheet = class
  private
    function getStyleSheetType: wideString; virtual; abstract;
    function getDisabled: boolean; virtual; abstract;
    procedure setDisabled(const value: boolean); virtual; abstract;
    function getOwnerNode: TdomNode; virtual; abstract;
    function getParentStyleSheet: TdomStyleSheet; virtual; abstract;
    function getHref: wideString; virtual; abstract;
    function getTitle: wideString; virtual; abstract;
    function getMedia: TdomMediaList; virtual; abstract;
  public
    property styleSheetType: wideString read getStyleSheetType;
    property disabled: boolean read getDisabled write setDisabled;
    property ownerNode: TdomNode read getOwnerNode;
    property parentStyleSheet: TdomStyleSheet read getParentStyleSheet;
    property href: wideString read getHref;
    property title: wideString read getTitle;
    property media: TdomMediaList read getMedia;
  end;

  TdomMediaList = class
  private
    function getCssText: wideString; virtual; abstract;
    procedure setCssText(const value: wideString); virtual; abstract;
    function getLength: integer; virtual; abstract;
  public
    function item(const index: integer): TdomStyleSheet; virtual; abstract;
    procedure Delete(const oldMedium: wideString); virtual; abstract;
    procedure append(const newMedium: wideString); virtual; abstract;
    property length: integer read getLength;
    property cssText: wideString read getCssText write setCssText;
  end;

  TdomStyleSheetList = class
  private
    function getLength: integer; virtual; abstract;
  public
    function item(const index: integer): TdomStyleSheet; virtual; abstract;
    property length: integer read getLength;
  end;

  TdomDocumentStyle = class
  private
    function getStyleSheets: TdomStyleSheetList; virtual; abstract;
  public
    property styleSheets: TdomStyleSheetList read getStyleSheets;
  end;

  TXmlSourceCode = class (TList)
  private
    procedure calculatePieceOffset(const startItem: integer); virtual;
    function  getNameOfFirstTag: wideString; virtual;
  public
    function  add(Item: Pointer): integer;
    procedure clear;  override; 
      // ifdef... is necessary because TList.clear is static in Delphi 3
      // (=ver100), but dynamic in later versions.
    procedure clearAndFree; virtual;
    procedure Delete(index: integer);
    procedure exchange(index1, index2: integer);
    function  getPieceAtPos(pos: integer): TXmlSourceCodePiece;
    procedure insert(index: integer; item: pointer);
    procedure move(curIndex, newIndex: integer);
    procedure pack;
    function  remove(Item: Pointer): integer;
    procedure sort(Compare: TListSortCompare);
    property  nameOfFirstTag: wideString read getNameOfFirstTag;
  end;

  TXmlSourceCodePiece = class
  private
    FPieceType: TdomPieceType;
    FText: wideString;
    FOffset: integer;
    FOwner: TXmlSourceCode;
  public
    constructor create(const pt: TdomPieceType); virtual;
    property pieceType: TdomPieceType read FPieceType;
    property text: wideString read FText write FText;
    property offset: integer read FOffset;
    property ownerSourceCode: TXmlSourceCode read FOwner;
  end;


{Parser}

  TXmlParserLanguage = (iso639_de,
                        iso639_en,
                        iso639_es,
                        iso639_fr,
                        iso639_it,
                        iso639_nl,
                        iso639_pl);

  TXmlMemoryStream = class(TMemoryStream)
  public
    procedure setPointer(Ptr: Pointer; Size: Longint);
  end;

  TdomStandardLocator = class;
  
  TXmlInputSource = class
  private
    FStream: TStream;
    FEncoding: TdomEncodingType;
    // October 16, 2001 - Borland Change - Added FIConv data member 
{$IFDEF LINUX}
    FIConv: iconv_t;
{$ENDIF}
    FLastUcs4: integer;      // Buffer storage for UTF-8 surrogates
    FLastCharWasCR: boolean;
    FLocator: TdomStandardLocator;
    FPublicId: wideString;
    FSystemId: wideString;
    FRootName:  wideString;
  protected
    function getEncodingType: TdomEncodingType; virtual;
    function getRootName: wideString; virtual;
    function getStreamAsWideString: wideString; virtual;
    procedure skipTextDecl(const locator: TdomStandardLocator); virtual;
    function getNextWideChar2(var dest: wideChar;
                              const locator: TdomStandardLocator): boolean; virtual;
    procedure reset2(const locator: TdomStandardLocator); virtual;
  public
    constructor create(const stream: TStream;
                       const publicId,
                             systemId: wideString); virtual;
    destructor destroy; override;
    function getNextWideChar(var dest: wideChar): boolean; virtual;
    procedure reset; virtual;
    property encoding: TdomEncodingType read FEncoding;
    property locator: TdomStandardLocator read FLocator;
    property publicId: wideString read FPublicId;
    property rootName: wideString read FRootName;
    property stream: TStream read FStream;
    property streamAsWideString: wideString read getStreamAsWideString;
    property systemId: wideString read FSystemId;
  end;

  TXmlErrorType = (xetFatalError,xetError,xetWarning);

  TXmlParserError = class
  private
    FCode:        wideString;
    FEndColumn:   integer;
    FEndLine:     integer;
    FErrorClass:  string;
    FErrorType:   TXmlErrorType;
    FPubId:       wideString;
    FStartColumn: integer;
    FStartLine:   integer;
    FSysId:       wideString;
  protected
    function getDutchErrorStr: wideString;
    function getEnglishErrorStr: wideString;
    function getFrenchErrorStr: wideString;
    function getGermanErrorStr: wideString;
    function getItalianErrorStr: wideString;
    function getPolishErrorStr: wideString;
    function getSpanishErrorStr: wideString;
  public
    constructor create(const e: EParserException;
                       const startLine,
                             startColumn,
                             endLine,
                             endColumn: integer;
                       const pubId,
                             sysId,
                             code: wideString); virtual;
    function getErrorStr(const lang: TXmlParserLanguage): wideString; virtual;
    property code: wideString read FCode;
    property endColumn: integer read FEndColumn;
    property endLine: integer read FEndLine;
    property errorClass: string read FErrorClass;
    property errorType: TXmlErrorType read FErrorType;
    property publicId: wideString read FPubId;
    property startColumn: integer read FStartColumn;
    property startLine: integer read FStartLine;
    property systemId: wideString read FSysId;
  end;

  TdomStandardLocator = class
  protected
    FColumnNumber:      integer;
    FInputSource:       TXmlInputSource;
    FStartColumnNumber: integer;
    FStartLineNumber:   integer;
    FLastWCharWasLF:    boolean;
    FLineNumber:        integer;
    FPieceEndSet:       boolean;
    function getPublicId: wideString; virtual;
    function getSystemId: wideString; virtual;
    procedure evaluate(const s: WideChar); virtual;
  public
    constructor create(const inputSource: TXmlInputSource); virtual;
    procedure pieceEnd; virtual;
    procedure pieceStart; virtual;
    procedure reset; virtual;
    property columnNumber: integer read FColumnNumber;
    property lineNumber: integer read FLineNumber;
    property publicId: wideString read getPublicId;
    property startColumnNumber: integer read FStartColumnNumber;
    property startLineNumber: integer read FStartLineNumber;
    property systemId: wideString  read getSystemId;
  end;

  TdomCustomParser = class;
  TXmlStandardDocReader = class;

  TXmlCustomProcessorAgent = class(TComponent);

  TXmlProcessorErrorEvent = procedure(processorAgent: TXmlCustomProcessorAgent;
                                      e: TXmlParserError) of object;

  TXmlProcessorEvent1 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator) of object;

  TXmlProcessorEvent2 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator;
                                  var data: wideString) of object;

  TXmlProcessorEvent3 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator;
                                  var targ,
                                      data : wideString) of object;

  TXmlProcessorEvent4 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator;
                                  var namespaceURI,
                                      tagName: wideString) of object;

  TXmlProcessorEvent5 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator;
                                  var namespaceURI,
                                      tagName: wideString;
                                  attributes: TdomNameValueList) of object;

  TXmlProcessorEvent6 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator;
                                  var name,
                                      pubId,
                                      sysId,
                                      data: wideString) of object;

  TXmlProcessorEvent7 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator;
                                  var prefix,
                                      uri: wideString) of object;

  TXmlProcessorEvent8 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator;
                                  var version,
                                      encDl,
                                      sdDl: wideString) of object;

  TXmlProcessorEvent9 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                  locator: TdomStandardLocator;
                                  var name,
                                      attType,
                                      bracket,
                                      defaultDecl,
                                      attValue: wideString) of object;

  TXmlProcessorEvent10 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                   locator: TdomStandardLocator;
                                   var includeStmt,
                                       data: wideString) of object;

  TXmlProcessorEvent11 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                   locator: TdomStandardLocator;
                                   var name,
                                       data: wideString) of object;

  TXmlProcessorEvent12 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                   locator: TdomStandardLocator;
                                   var name,
                                       entityValue,
                                       pubId,
                                       sysId,
                                       notaName: wideString) of object;

  TXmlProcessorEvent13 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                   locator: TdomStandardLocator;
                                   var name,
                                       pubId,
                                       sysId: wideString) of object;

  TXmlProcessorEvent14 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                   locator: TdomStandardLocator;
                                   var name,
                                       entityValue,
                                       pubId,
                                       sysId: wideString) of object;

  TXmlProcessorEvent15 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                   var pubId,
                                       sysId: wideString) of object;

  TXmlProcessorEvent16 = procedure(processorAgent: TXmlCustomProcessorAgent;
                                   locator: TdomStandardLocator;
                                   var version,
                                       encDl: wideString) of object;

  TXmlStandardProcessorAgent = class(TXmlCustomProcessorAgent)
  protected
    FReader: TXmlStandardDocReader;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function processFile(const pubId,
                               sysId: wideString): boolean; virtual;
    function processMemory(const ptr: pointer;
                           const size: longint;
                           const pubId,
                                 sysId: wideString): boolean; virtual;
    function processSourceCode(const intDtdSourceCode: TXmlSourceCode;
                               const pubId,
                                     sysId: wideString): boolean; virtual;
    function processStream(const stream: TStream;
                           const pubId,
                                 sysId: wideString): boolean; virtual;
    function processString(const str: String;
                           const pubId,
                                 sysId: wideString): boolean; virtual;
    function processWideString(str: wideString;
                               const pubId,
                                     sysId: wideString): boolean; virtual;
  published
    property Reader: TXmlStandardDocReader read FReader write FReader;
  end;

  TXmlCustomHandler = class(TComponent)
  protected
    FOnError: TXmlProcessorErrorEvent;
    FOnFatalError: TXmlProcessorErrorEvent;
    FOnWarning: TXmlProcessorErrorEvent;
    FOnComment: TXmlProcessorEvent2;
    FOnCDATA: TXmlProcessorEvent2;
    FOnCharRef: TXmlProcessorEvent2;
    FOnDoctype: TXmlProcessorEvent6;
    FOnEndDocument: TXmlProcessorEvent1;
    FOnEndElement: TXmlProcessorEvent4;
    FOnEndPrefixMapping: TXmlProcessorEvent2;
    FOnEntityRef: TXmlProcessorEvent2;
    FOnPCDATA: TXmlProcessorEvent2;
    FOnProcessingInstruction: TXmlProcessorEvent3;
    FOnSkippedEntity: TXmlProcessorEvent2;
    FOnStartDocument: TXmlProcessorEvent2;
    FOnStartElement: TXmlProcessorEvent5;
    FOnStartPrefixMapping: TXmlProcessorEvent7;
    FOnXmlDeclaration: TXmlProcessorEvent8;
    FOnAttributeDefinition: TXmlProcessorEvent9;
    FOnConditionalSection: TXmlProcessorEvent10;
    FOnDtdComment: TXmlProcessorEvent2;
    FOnDtdProcessingInstruction: TXmlProcessorEvent3;
    FOnElementTypeDeclaration: TXmlProcessorEvent11;
    FOnEndAttListDeclaration: TXmlProcessorEvent1;
    FOnEndDtd: TXmlProcessorEvent1;
    FOnEntityDeclaration: TXmlProcessorEvent12;
    FOnNotationDeclaration: TXmlProcessorEvent13;
    FOnParameterEntityDeclaration: TXmlProcessorEvent14;
    FOnParameterEntityRef: TXmlProcessorEvent2;
    FOnStartAttListDeclaration: TXmlProcessorEvent2;
    FOnStartDtd: TXmlProcessorEvent15;
    FOnTextDeclaration: TXmlProcessorEvent16;
    procedure sendErrorNotification(const sender: TXmlCustomProcessorAgent;
                                      var e: TXmlParserError); virtual;
    procedure error(const sender: TXmlCustomProcessorAgent;
                      var e: TXmlParserError); virtual;
    procedure fatalError(const sender: TXmlCustomProcessorAgent;
                           var e: TXmlParserError); virtual;
    procedure warning(const sender: TXmlCustomProcessorAgent;
                        var e: TXmlParserError); virtual;
  public
    function CDATA(const sender: TXmlCustomProcessorAgent;
                   const locator: TdomStandardLocator;
                         data: wideString): TXmlParserError; virtual; abstract;
    function charRef(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; virtual; abstract;
    function comment(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; virtual; abstract;
    function doctype(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           name,
                           pubId,
                           sysId,
                           data: wideString): TXmlParserError; virtual; abstract;
    function endDocument(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator): TXmlParserError; virtual; abstract;
    function endElement(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              namespaceURI,
                              tagName: wideString): TXmlParserError; virtual; abstract;
    function endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                              const locator: TdomStandardLocator;
                                    prefix: wideString): TXmlParserError; virtual; abstract;
    function entityRef(const sender: TXmlCustomProcessorAgent;
                       const locator: TdomStandardLocator;
                             name: wideString): TXmlParserError; virtual; abstract;
    function PCDATA(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator;
                          data: wideString): TXmlParserError; virtual; abstract;
    function processingInstruction(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         targ,
                                         data : wideString): TXmlParserError; virtual; abstract;
    function skippedEntity(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 name: wideString): TXmlParserError; virtual; abstract;
    function startDocument(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 defaultRoot: wideString): TXmlParserError; virtual; abstract;
    function startElement(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                                namespaceURI,
                                tagName: wideString;
                                attributes: TdomNameValueList): TXmlParserError; virtual; abstract;
    function startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      prefix,
                                      uri: wideString): TXmlParserError; virtual; abstract;
    function xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                            const locator: TdomStandardLocator;
                                  version,
                                  encDl,
                                  sdDl: wideString): TXmlParserError; virtual; abstract;
    function attributeDefinition(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       attType,
                                       bracket,
                                       defaultDecl,
                                       attValue: wideString): TXmlParserError; virtual; abstract;
    function conditionalSection(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      includeStmt,
                                      data: wideString): TXmlParserError; virtual; abstract;
    function DTDcomment(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              data: wideString): TXmlParserError; virtual; abstract;
    function DTDprocessingInstruction(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            targ,
                                            data : wideString): TXmlParserError; virtual; abstract;
    function elementTypeDeclaration(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator;
                                          name,
                                          data: wideString): TXmlParserError; virtual; abstract;
    function endAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator): TXmlParserError; virtual; abstract;
    function endDtd(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator): TXmlParserError; virtual; abstract;
    function entityDeclaration(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                                     name,
                                     entityValue,
                                     pubId,
                                     sysId,
                                     notaName: wideString): TXmlParserError; virtual; abstract;
    function notationDeclaration(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       pubId,
                                       sysId: wideString): TXmlParserError; virtual; abstract;
    function parameterEntityDeclaration(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              name,
                                              entityValue,
                                              pubId,
                                              sysId: wideString): TXmlParserError; virtual; abstract;
    function parameterEntityRef(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      name: wideString): TXmlParserError; virtual; abstract;
    function startAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           name: wideString): TXmlParserError; virtual; abstract;
    function startDtd(const sender: TXmlCustomProcessorAgent;
                      const locator: TdomStandardLocator;
                            pubId,
                            sysId: wideString): TXmlParserError; virtual; abstract;
    function textDeclaration(const sender: TXmlCustomProcessorAgent;
                             const locator: TdomStandardLocator;
                                   version,
                                   encDl: wideString): TXmlParserError; virtual; abstract;
  published
    property OnAttributeDefinition: TXmlProcessorEvent9 read FOnAttributeDefinition write FOnAttributeDefinition;
    property OnCDATA: TXmlProcessorEvent2 read FOnCDATA write FOnCDATA;
    property OnCharRef: TXmlProcessorEvent2 read FOnCharRef write FOnCharRef;
    property OnComment: TXmlProcessorEvent2 read FOnComment write FOnComment;
    property OnConditionalSection: TXmlProcessorEvent10 read FOnConditionalSection write FOnConditionalSection;
    property OnDoctype: TXmlProcessorEvent6 read FOndoctype write FOndoctype;
    property OnDtdComment: TXmlProcessorEvent2 read FOnDtdComment write FOnDtdComment;
    property OnDtdProcessingInstruction: TXmlProcessorEvent3 read FOnDtdProcessingInstruction write FOnDtdProcessingInstruction;
    property OnElementTypeDeclaration: TXmlProcessorEvent11 read FOnElementTypeDeclaration write FOnElementTypeDeclaration;
    property OnEndAttListDeclaration: TXmlProcessorEvent1 read FOnEndAttListDeclaration write FOnEndAttListDeclaration;
    property OnEndDtd: TXmlProcessorEvent1 read FOnEndDtd write FOnEndDtd;
    property OnEndDocument: TXmlProcessorEvent1 read FOnEndDocument write FOnEndDocument;
    property OnEndElement: TXmlProcessorEvent4 read FOnEndElement write FOnEndElement;
    property OnEndPrefixMapping: TXmlProcessorEvent2 read FOnEndPrefixMapping write FOnEndPrefixMapping;
    property OnEntityDeclaration: TXmlProcessorEvent12 read FOnEntityDeclaration write FOnEntityDeclaration;
    property OnEntityRef: TXmlProcessorEvent2 read FOnEntityRef write FOnEntityRef;
    property OnError: TXmlProcessorErrorEvent read FOnError write FOnError;
    property OnFatalError: TXmlProcessorErrorEvent read FOnFatalError write FOnFatalError;
    property OnNotationDeclaration: TXmlProcessorEvent13 read FOnNotationDeclaration write FOnNotationDeclaration;
    property OnParameterEntityDeclaration: TXmlProcessorEvent14 read FOnParameterEntityDeclaration write FOnParameterEntityDeclaration;
    property OnParameterEntityRef: TXmlProcessorEvent2 read FOnParameterEntityRef write FOnParameterEntityRef;
    property OnPCDATA: TXmlProcessorEvent2 read FOnPCDATA write FOnPCDATA;
    property OnProcessingInstruction: TXmlProcessorEvent3 read FOnProcessingInstruction write FOnProcessingInstruction;
    property OnSkippedEntity: TXmlProcessorEvent2 read FOnSkippedEntity write FOnSkippedEntity;
    property OnStartAttListDeclaration: TXmlProcessorEvent2 read FOnStartAttListDeclaration write FOnStartAttListDeclaration;
    property OnStartDocument: TXmlProcessorEvent2 read FOnStartDocument write FOnStartDocument;
    property OnStartDtd: TXmlProcessorEvent15 read FOnStartDtd write FOnStartDtd;
    property OnStartElement: TXmlProcessorEvent5 read FOnStartElement write FOnStartElement;
    property OnStartPrefixMapping: TXmlProcessorEvent7 read FOnStartPrefixMapping write FOnStartPrefixMapping;
    property OnTextDeclaration: TXmlProcessorEvent16 read FOnTextDeclaration write FOnTextDeclaration;
    property OnWarning: TXmlProcessorErrorEvent read FOnWarning write FOnWarning;
    property OnXmlDeclaration: TXmlProcessorEvent8 read FOnXmlDeclaration write FOnXmlDeclaration;
  end;

  TXmlStandardHandler = class(TXmlCustomHandler)
  protected
    FNextHandler: TXmlCustomHandler;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function CDATA(const sender: TXmlCustomProcessorAgent;
                   const locator: TdomStandardLocator;
                         data: wideString): TXmlParserError; override;
    function charRef(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function comment(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function doctype(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           name,
                           pubId,
                           sysId,
                           data: wideString): TXmlParserError; override;
    function endDocument(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator): TXmlParserError; override;
    function endElement(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              namespaceURI,
                              tagName: wideString): TXmlParserError; override;
    function endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                              const locator: TdomStandardLocator;
                                    prefix: wideString): TXmlParserError; override;
    function entityRef(const sender: TXmlCustomProcessorAgent;
                       const locator: TdomStandardLocator;
                             name: wideString): TXmlParserError; override;
    function PCDATA(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator;
                          data: wideString): TXmlParserError; override;
    function processingInstruction(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         targ,
                                         data : wideString): TXmlParserError; override;
    function skippedEntity(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 name: wideString): TXmlParserError; override;
    function startDocument(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 defaultRoot: wideString): TXmlParserError; override;
    function startElement(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                                namespaceURI,
                                tagName: wideString;
                                attributes: TdomNameValueList): TXmlParserError; override;
    function startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      prefix,
                                      uri: wideString): TXmlParserError; override;
    function xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                            const locator: TdomStandardLocator;
                                  version,
                                  encDl,
                                  sdDl: wideString): TXmlParserError; override;
    function attributeDefinition(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       attType,
                                       bracket,
                                       defaultDecl,
                                       attValue: wideString): TXmlParserError; override;
    function conditionalSection(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      includeStmt,
                                      data: wideString): TXmlParserError; override;
    function DTDcomment(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              data: wideString): TXmlParserError; override;
    function DTDprocessingInstruction(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            targ,
                                            data : wideString): TXmlParserError; override;
    function elementTypeDeclaration(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator;
                                          name,
                                          data: wideString): TXmlParserError; override;
    function endAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator): TXmlParserError; override;
    function endDtd(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator): TXmlParserError; override;
    function entityDeclaration(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                                     name,
                                     entityValue,
                                     pubId,
                                     sysId,
                                     notaName: wideString): TXmlParserError; override;
    function notationDeclaration(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       pubId,
                                       sysId: wideString): TXmlParserError; override;
    function parameterEntityDeclaration(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              name,
                                              entityValue,
                                              pubId,
                                              sysId: wideString): TXmlParserError; override;
    function parameterEntityRef(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      name: wideString): TXmlParserError; override;
    function startAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           name: wideString): TXmlParserError; override;
    function startDtd(const sender: TXmlCustomProcessorAgent;
                      const locator: TdomStandardLocator;
                            pubId,
                            sysId: wideString): TXmlParserError; override;
    function textDeclaration(const sender: TXmlCustomProcessorAgent;
                             const locator: TdomStandardLocator;
                                   version,
                                   encDl: wideString): TXmlParserError; override;
  published
    property NextHandler: TXmlCustomHandler read FNextHandler write FNextHandler;
  end;

  TXmlDistributor = class;

  TXmlHandlerItem = class(TCollectionItem)
  protected
    FXmlHandler: TXmlCustomHandler;
    function getXmlHandler: TXmlCustomHandler;
    procedure setXmlHandler(Value: TXmlCustomHandler);
  public
    procedure Assign(Source: TPersistent); override;
  published
    property XmlHandler: TXmlCustomHandler read getXmlHandler write setXmlHandler;
  end;

  TXmlHandlers = class(TCollection)
  private
    FDistributor: TXmlDistributor;
  protected
    function GetItem(Index: Integer): TXmlHandlerItem; virtual;
    procedure SetItem(Index: Integer; Value: TXmlHandlerItem); virtual;
    function GetOwner: TPersistent; override;
  public
    constructor Create(Distributor: TXmlDistributor);
    function Add: TXmlHandlerItem;
    procedure Assign(Source: TPersistent); override;
    function FindHandlerItem(AHandler: TXmlCustomHandler): TXmlHandlerItem;
    property Distributor: TXmlDistributor read FDistributor;
    property Items[Index: Integer]: TXmlHandlerItem read GetItem write SetItem; default;
  end;

  TXmlDistributor = class(TXmlCustomHandler)
  private
    procedure readData(Reader: TReader);
    procedure writeData(Writer: TWriter);
  protected
    FNextHandlers: TXmlHandlers;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure setNextHandlers(const value: TXmlHandlers);
  public
    constructor create(AOwner: TComponent); override;
    destructor destroy; override;
    function CDATA(const sender: TXmlCustomProcessorAgent;
                   const locator: TdomStandardLocator;
                         data: wideString): TXmlParserError; override;
    function charRef(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function comment(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function doctype(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           name,
                           pubId,
                           sysId,
                           data: wideString): TXmlParserError; override;
    function endDocument(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator): TXmlParserError; override;
    function endElement(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              namespaceURI,
                              tagName: wideString): TXmlParserError; override;
    function endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                              const locator: TdomStandardLocator;
                                    prefix: wideString): TXmlParserError; override;
    function entityRef(const sender: TXmlCustomProcessorAgent;
                       const locator: TdomStandardLocator;
                             name: wideString): TXmlParserError; override;
    function PCDATA(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator;
                          data: wideString): TXmlParserError; override;
    function processingInstruction(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         targ,
                                         data : wideString): TXmlParserError; override;
    function skippedEntity(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 name: wideString): TXmlParserError; override;
    function startDocument(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 defaultRoot: wideString): TXmlParserError; override;
    function startElement(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                                namespaceURI,
                                tagName: wideString;
                                attributes: TdomNameValueList): TXmlParserError; override;
    function startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      prefix,
                                      uri: wideString): TXmlParserError; override;
    function xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                            const locator: TdomStandardLocator;
                                  version,
                                  encDl,
                                  sdDl: wideString): TXmlParserError; override;
    function attributeDefinition(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       attType,
                                       bracket,
                                       defaultDecl,
                                       attValue: wideString): TXmlParserError; override;
    function conditionalSection(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      includeStmt,
                                      data: wideString): TXmlParserError; override;
    function DTDcomment(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              data: wideString): TXmlParserError; override;
    function DTDprocessingInstruction(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            targ,
                                            data : wideString): TXmlParserError; override;
    function elementTypeDeclaration(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator;
                                          name,
                                          data: wideString): TXmlParserError; override;
    function endAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator): TXmlParserError; override;
    function endDtd(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator): TXmlParserError; override;
    function entityDeclaration(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                                     name,
                                     entityValue,
                                     pubId,
                                     sysId,
                                     notaName: wideString): TXmlParserError; override;
    function notationDeclaration(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       pubId,
                                       sysId: wideString): TXmlParserError; override;
    function parameterEntityDeclaration(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              name,
                                              entityValue,
                                              pubId,
                                              sysId: wideString): TXmlParserError; override;
    function parameterEntityRef(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      name: wideString): TXmlParserError; override;
    function startAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           name: wideString): TXmlParserError; override;
    function startDtd(const sender: TXmlCustomProcessorAgent;
                      const locator: TdomStandardLocator;
                            pubId,
                            sysId: wideString): TXmlParserError; override;
    function textDeclaration(const sender: TXmlCustomProcessorAgent;
                             const locator: TdomStandardLocator;
                                   version,
                                   encDl: wideString): TXmlParserError; override;
  published
    property NextHandlers: TXmlHandlers read FNextHandlers write setNextHandlers;
  end;

  TXmlCustomDTDHandler = class(TXmlStandardHandler)
  protected
    function parserErrorFactory(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                const e: EParserException;
                                const code: wideString): TXmlParserError; virtual;
  public
    function CDATA(const sender: TXmlCustomProcessorAgent;
                   const locator: TdomStandardLocator;
                         data: wideString): TXmlParserError; override;
    function charRef(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function comment(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function doctype(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           name,
                           pubId,
                           sysId,
                           data: wideString): TXmlParserError; override;
    function endDocument(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator): TXmlParserError; override;
    function endElement(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              namespaceURI,
                              tagName: wideString): TXmlParserError; override;
    function endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                              const locator: TdomStandardLocator;
                                    prefix: wideString): TXmlParserError; override;
    function entityRef(const sender: TXmlCustomProcessorAgent;
                       const locator: TdomStandardLocator;
                             name: wideString): TXmlParserError; override;
    function PCDATA(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator;
                          data: wideString): TXmlParserError; override;
    function processingInstruction(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         targ,
                                         data : wideString): TXmlParserError; override;
    function skippedEntity(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 name: wideString): TXmlParserError; override;
    function startDocument(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 defaultRoot: wideString): TXmlParserError; override;
    function startElement(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                                namespaceURI,
                                tagName: wideString;
                                attributes: TdomNameValueList): TXmlParserError; override;
    function startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      prefix,
                                      uri: wideString): TXmlParserError; override;
    function xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                            const locator: TdomStandardLocator;
                                  version,
                                  encDl,
                                  sdDl: wideString): TXmlParserError; override;
  end;

  TXmlCustomContentHandler = class(TXmlStandardHandler)
  protected
    function parserErrorFactory(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                const e: EParserException;
                                const code: wideString): TXmlParserError; virtual;
  public
    function attributeDefinition(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       attType,
                                       bracket,
                                       defaultDecl,
                                       attValue: wideString): TXmlParserError; override;
    function conditionalSection(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      includeStmt,
                                      data: wideString): TXmlParserError; override;
    function DTDcomment(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              data: wideString): TXmlParserError; override;
    function DTDprocessingInstruction(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            targ,
                                            data : wideString): TXmlParserError; override;
    function elementTypeDeclaration(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator;
                                          name,
                                          data: wideString): TXmlParserError; override;
    function endAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator): TXmlParserError; override;
    function endDtd(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator): TXmlParserError; override;
    function entityDeclaration(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                                     name,
                                     entityValue,
                                     pubId,
                                     sysId,
                                     notaName: wideString): TXmlParserError; override;
    function notationDeclaration(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       pubId,
                                       sysId: wideString): TXmlParserError; override;
    function parameterEntityDeclaration(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              name,
                                              entityValue,
                                              pubId,
                                              sysId: wideString): TXmlParserError; override;
    function parameterEntityRef(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      name: wideString): TXmlParserError; override;
    function startAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           name: wideString): TXmlParserError; override;
    function startDtd(const sender: TXmlCustomProcessorAgent;
                      const locator: TdomStandardLocator;
                            pubId,
                            sysId: wideString): TXmlParserError; override;
    function textDeclaration(const sender: TXmlCustomProcessorAgent;
                             const locator: TdomStandardLocator;
                                   version,
                                   encDl: wideString): TXmlParserError; override;
  end;

  TXmlCustomReader = class(TComponent)
  protected
    FNextHandler: TXmlStandardHandler;
    FOnError: TXmlProcessorErrorEvent;
    FOnFatalError: TXmlProcessorErrorEvent;
    FOnWarning: TXmlProcessorErrorEvent;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure sendErrorNotification(const sender: TXmlCustomProcessorAgent;
                                      var e: TXmlParserError); virtual;
    function parserErrorFactory(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                const e: EParserException;
                                const code: wideString): TXmlParserError; virtual;
    procedure error(const sender: TXmlCustomProcessorAgent;
                      var e: TXmlParserError); virtual;
    procedure fatalError(const sender: TXmlCustomProcessorAgent;
                           var e: TXmlParserError); virtual;
    procedure warning(const sender: TXmlCustomProcessorAgent;
                        var e: TXmlParserError); virtual;
  published
    property NextHandler: TXmlStandardHandler read FNextHandler write FNextHandler;
    property OnError: TXmlProcessorErrorEvent read FOnError write FOnError;
    property OnFatalError: TXmlProcessorErrorEvent read FOnFatalError write FOnFatalError;
    property OnWarning: TXmlProcessorErrorEvent read FOnWarning write FOnWarning;
  end;

  TXmlWFTestContentHandler = class(TXmlCustomContentHandler)
  protected
    FIsActive: boolean;
    FDoctypeFound: boolean;
    FRootFound: boolean;
    FXMLDeclarationAllowed: boolean;
    FTagStack: TStringList;
  public
    constructor create(AOwner: TComponent); override;
    destructor destroy; override;
    function CDATA(const sender: TXmlCustomProcessorAgent;
                   const locator: TdomStandardLocator;
                         data: wideString): TXmlParserError; override;
    function charRef(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function comment(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function doctype(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           name,
                           pubId,
                           sysId,
                           data: wideString): TXmlParserError; override;
    function endDocument(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator): TXmlParserError; override;
    function endElement(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              namespaceURI,
                              tagName: wideString): TXmlParserError; override;
    function endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                              const locator: TdomStandardLocator;
                                    prefix: wideString): TXmlParserError; override;
    function entityRef(const sender: TXmlCustomProcessorAgent;
                       const locator: TdomStandardLocator;
                             name: wideString): TXmlParserError; override;
    function PCDATA(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator;
                          data: wideString): TXmlParserError; override;
    function processingInstruction(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         targ,
                                         data : wideString): TXmlParserError; override;
    function skippedEntity(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 name: wideString): TXmlParserError; override;
    function startDocument(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 defaultRoot: wideString): TXmlParserError; override;
    function startElement(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                                namespaceURI,
                                tagName: wideString;
                                attributes: TdomNameValueList): TXmlParserError; override;
    function startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      prefix,
                                      uri: wideString): TXmlParserError; override;
    function xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                            const locator: TdomStandardLocator;
                                  version,
                                  encDl,
                                  sdDl: wideString): TXmlParserError; override;
    property isActive: boolean read FIsActive;
  end;

  TXmlDocBuilder = class(TXmlCustomContentHandler)
  private
    FBuildNamespaceTree: boolean;
    FPreserveWhitespace: boolean;
  protected
    FRefNode: TdomNode;
    FPrefixUriList: TdomNameValueList;
  public
    constructor create(AOwner: TComponent); override;
    destructor destroy; override;
    function CDATA(const sender: TXmlCustomProcessorAgent;
                   const locator: TdomStandardLocator;
                         data: wideString): TXmlParserError; override;
    function charRef(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function comment(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           data: wideString): TXmlParserError; override;
    function doctype(const sender: TXmlCustomProcessorAgent;
                     const locator: TdomStandardLocator;
                           name,
                           pubId,
                           sysId,
                           data: wideString): TXmlParserError; override;
    function endDocument(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator): TXmlParserError; override;
    function endElement(const sender: TXmlCustomProcessorAgent;
                        const locator: TdomStandardLocator;
                              namespaceURI,
                              tagName: wideString): TXmlParserError; override;
    function endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                                     prefix: wideString): TXmlParserError; override;
    function entityRef(const sender: TXmlCustomProcessorAgent;
                       const locator: TdomStandardLocator;
                             name: wideString): TXmlParserError; override;
    function PCDATA(const sender: TXmlCustomProcessorAgent;
                    const locator: TdomStandardLocator;
                          data: wideString): TXmlParserError; override;
    function processingInstruction(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         targ,
                                         data : wideString): TXmlParserError; override;
    function skippedEntity(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 name: wideString): TXmlParserError; override;
    function startDocument(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                                 defaultRoot: wideString): TXmlParserError; override;
    function startElement(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                                namespaceURI,
                                tagName: wideString;
                                attributes: TdomNameValueList): TXmlParserError; override;
    function startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      prefix,
                                      uri: wideString): TXmlParserError; override;
    function xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                            const locator: TdomStandardLocator;
                                  version,
                                  encDl,
                                  sdDl: wideString): TXmlParserError; override;
    property referenceNode: TdomNode read FRefNode write FRefNode;
    // September 21, 2001 - Borland Change - Added property to automatically strip formatting whitespace
    property preserveWhitespace: boolean read FPreserveWhitespace write FPreserveWhitespace;
  published
    property BuildNamespaceTree: boolean read FBuildNamespaceTree write FBuildNamespaceTree default false;
  end;

  TXmlStandardDocReader = class (TXmlCustomReader)
  protected
    function writeXmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                  const locator: TdomStandardLocator;
                                  const content: wideString): TXmlParserError; virtual;
    function writeProcessingInstruction(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator;
                                         const content: wideString): TXmlParserError; virtual;
    function writeComment(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                           const content: wideString): TXmlParserError; virtual;
    function writeCDATA(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator;
                         const content: wideString): TXmlParserError; virtual;
    function writePCDATA(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                          const content: wideString): TXmlParserError; virtual;
    function writeStartElement(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                const content: wideString): TXmlParserError; virtual;
    function writeEndElement(const sender: TXmlCustomProcessorAgent;
                              const locator: TdomStandardLocator;
                              const content: wideString): TXmlParserError; virtual;
    function writeEmptyElement(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                const content: wideString): TXmlParserError; virtual;
    function writeCharRef(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                           const content: wideString): TXmlParserError; virtual;
    function writeEntityRef(const sender: TXmlCustomProcessorAgent;
                             const locator: TdomStandardLocator;
                             const content: wideString): TXmlParserError; virtual;
    function writeDoctype(const sender: TXmlCustomProcessorAgent;
                           const locator: TdomStandardLocator;
                           const content: wideString): TXmlParserError; virtual;
  public
    function  parse(const sender: TXmlCustomProcessorAgent;
                    const inputSource: TXmlInputSource):boolean; virtual;
  end;

  TXmlStandardDomReader = class (TXmlCustomReader)
  private
    FPrefixMapping: boolean;
    FSuppressXmlns: boolean;
  protected
    function writeXmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                 const version,
                                       encDl,
                                       sdDl: wideString): TXmlParserError; virtual;
    function writeProcessingInstruction(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                        const targ,
                                              attribSequence : wideString): TXmlParserError; virtual;
    function writeComment(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                          const content: wideString): TXmlParserError; virtual;
    function writeCDATA(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator;
                         const content: wideString): TXmlParserError; virtual;
    function writePCDATA(const sender: TXmlCustomProcessorAgent;
                         const locator: TdomStandardLocator;
                         const content: wideString): TXmlParserError; virtual;
    function writeStartElement(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                               const tagName: wideString;
                               const attributeList: TdomNameValueList): TXmlParserError; virtual;
    function writeEndElement(const sender: TXmlCustomProcessorAgent;
                              const locator: TdomStandardLocator;
                              const tagName: wideString): TXmlParserError; virtual;
    function writeEmptyElement(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                               const tagName: wideString;
                               const attributeList: TdomNameValueList): TXmlParserError; virtual;
    function writeStartPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           prefix,
                                           uri: wideString): TXmlParserError; virtual;
    function writeEndPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         prefix: wideString): TXmlParserError; virtual;
    function writeCharRef(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                          const content: wideString): TXmlParserError; virtual;
    function writeEntityRef(const sender: TXmlCustomProcessorAgent;
                            const locator: TdomStandardLocator;
                            const entityName: wideString): TXmlParserError; virtual;
    function writeDoctype(const sender: TXmlCustomProcessorAgent;
                          const locator: TdomStandardLocator;
                          const name,
                                publicId,
                                systemId,
                                intSubset: WideString): TXmlParserError; virtual;
    function parseloop(const sender: TXmlCustomProcessorAgent;
                       const sourceNode: TdomNode): TXmlParserError; virtual;
  public
    constructor create(AOwner: TComponent); override;
    function  parse(const sender: TXmlCustomProcessorAgent;
                    const sourceNode: TdomNode): boolean; virtual;
  published
   property PrefixMapping: boolean read FPrefixMapping write FPrefixMapping default false;
   property SuppressXmlns: boolean read FSuppressXmlns write FSuppressXmlns default false;
  end;

  TdomCustomXMLReader = class;

  TdomCustomContentHandler = class
  public
    procedure CDATA(const sender: TdomCustomParser;
                    const locator: TdomStandardLocator;
                    const data: wideString); virtual;
    procedure charRef(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const data: wideString); virtual;
    procedure comment(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const data: wideString); virtual;
    procedure doctype(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const name,
                            pubId,
                            sysId,
                            data: wideString); virtual;
    procedure endDocument(const sender: TdomCustomParser); virtual;
    procedure endElement(const sender: TdomCustomParser;
                         const locator: TdomStandardLocator;
                         const namespaceURI,
                               localName,
                               tagName: wideString); virtual;
    procedure endPrefixMapping(const sender: TdomCustomParser;
                               const locator: TdomStandardLocator;
                               const prefix: wideString); virtual;
    procedure entityRef(const sender: TdomCustomParser;
                        const locator: TdomStandardLocator;
                        const name: wideString); virtual;
    procedure PCDATA(const sender: TdomCustomParser;
                     const locator: TdomStandardLocator;
                     const data: wideString); virtual;
    procedure processingInstruction(const sender: TdomCustomParser;
                                    const locator: TdomStandardLocator;
                                    const targ,
                                          data : wideString); virtual;
    procedure skippedEntity(const sender: TdomCustomParser;
                            const locator: TdomStandardLocator;
                            const name: wideString); virtual;
    procedure startDocument(const sender: TdomCustomParser;
                            const locator: TdomStandardLocator;
                                  defaultRoot: wideString); virtual;
    procedure startElement(const sender: TdomCustomParser;
                           const locator: TdomStandardLocator;
                           const namespaceURI,
                                 localName,
                                 tagName: wideString;
                                 attributes: TdomNameValueList); virtual;
    procedure startPrefixMapping(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const prefix,
                                       uri: wideString); virtual;
    procedure xmlDeclaration(const sender: TdomCustomParser;
                             const locator: TdomStandardLocator;
                             const version,
                                   encDl,
                                   sdDl: wideString); virtual;
  end;

  TdomCustomDTDHandler = class
  protected
    function getPEFromCurrentCMObject(const PEReferenceName: wideString): wideString; virtual;
  public
    procedure attributeDefinition(const sender: TdomCustomParser;
                                  const locator: TdomStandardLocator;
                                  const name,
                                        attType,
                                        bracket,
                                        defaultDecl,
                                        attValue: wideString); virtual;
    procedure comment(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const data: wideString); virtual;
    procedure conditionalSection(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const includeStmt,
                                       data: wideString); virtual;
    procedure elementTypeDeclaration(const sender: TdomCustomParser;
                                     const locator: TdomStandardLocator;
                                     const name,
                                           data: wideString); virtual;
    procedure endAttListDeclaration(const sender: TdomCustomParser;
                                    const locator: TdomStandardLocator); virtual;
    procedure endDtd(const sender: TdomCustomParser); virtual;
    procedure entityDeclaration(const sender: TdomCustomParser;
                                const locator: TdomStandardLocator;
                                const name,
                                      entityValue,
                                      pubId,
                                      sysId,
                                      notaName: wideString); virtual;
    procedure notationDeclaration(const sender: TdomCustomParser;
                                  const locator: TdomStandardLocator;
                                  const name,
                                        pubId,
                                        sysId: wideString); virtual;
    procedure parameterEntityDeclaration(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const name,
                                               entityValue,
                                               pubId,
                                               sysId: wideString); virtual;
    procedure parameterEntityRef(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const name: wideString); virtual;
    procedure processingInstruction(const sender: TdomCustomParser;
                                    const locator: TdomStandardLocator;
                                    const targ,
                                          data : wideString); virtual;
    procedure startAttListDeclaration(const sender: TdomCustomParser;
                                      const locator: TdomStandardLocator;
                                      const name: wideString); virtual;
    procedure startDtd(const sender: TdomCustomParser;
                       const pubId,
                             sysId: wideString); virtual;
    procedure textDeclaration(const sender: TdomCustomParser;
                              const locator: TdomStandardLocator;
                              const version,
                                    encDl: wideString); virtual;
  end;

  TdomCustomErrorHandler = class
  public
    procedure error(const sender: TdomCustomParser;
                    const locator: TdomStandardLocator;
                    const e: EParserException;
                    const code: wideString); virtual;
    procedure fatalError(const sender: TdomCustomParser;
                         const locator: TdomStandardLocator;
                         const e: EParserException;
                         const code: wideString); virtual;
    procedure warning(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const e: EParserException;
                      const code: wideString); virtual;
  end;

  TdomStandardContentModelReader = class
  private
    FErrorHandler:   TdomCustomErrorHandler;
  public
    function parse(const sender: TdomCustomParser;
                   const source: TdomCustomCMIEObject):boolean; virtual;
    property errorHandler: TdomCustomErrorHandler read FErrorHandler write FErrorHandler;
  end;

  TdomCustomXMLReader = class
  private
    FContentHandler: TdomCustomContentHandler;
    FDTDHandler:     TdomCustomDTDHandler;
    FErrorHandler:   TdomCustomErrorHandler;
    FLocator:        TdomStandardLocator;
  public
    function parse(const sender: TdomCustomParser;
                   const inputSource: TXmlInputSource):boolean; virtual;
    property contentHandler: TdomCustomContentHandler read FContentHandler write FContentHandler;
    property dtdHandler: TdomCustomDTDHandler read FDTDHandler write FDTDHandler;
    property errorHandler: TdomCustomErrorHandler read FErrorHandler write FErrorHandler;
    property locator: TdomStandardLocator read FLocator;
  end;

  TdomStandardDocXMLReader = class (TdomCustomXMLReader)
  protected
    procedure writeXmlDeclaration(const sender: TdomCustomParser;
                                  const locator: TdomStandardLocator;
                                  const content: wideString); virtual;
    procedure writeProcessingInstruction(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const content: wideString); virtual;
    procedure writeComment(const sender: TdomCustomParser;
                           const locator: TdomStandardLocator;
                           const content: wideString); virtual;
    procedure writeCDATA(const sender: TdomCustomParser;
                         const locator: TdomStandardLocator;
                         const content: wideString); virtual;
    procedure writePCDATA(const sender: TdomCustomParser;
                          const locator: TdomStandardLocator;
                          const content: wideString); virtual;
    procedure writeStartElement(const sender: TdomCustomParser;
                                const locator: TdomStandardLocator;
                                const content: wideString); virtual;
    procedure writeEndElement(const sender: TdomCustomParser;
                              const locator: TdomStandardLocator;
                              const content: wideString); virtual;
    procedure writeEmptyElement(const sender: TdomCustomParser;
                                const locator: TdomStandardLocator;
                                const content: wideString); virtual;
    procedure writeCharRef(const sender: TdomCustomParser;
                           const locator: TdomStandardLocator;
                           const content: wideString); virtual;
    procedure writeEntityRef(const sender: TdomCustomParser;
                             const locator: TdomStandardLocator;
                             const content: wideString); virtual;
    procedure writeDoctype(const sender: TdomCustomParser;
                           const locator: TdomStandardLocator;
                           const content: wideString); virtual;
  public
    function  parse(const sender: TdomCustomParser;
                    const inputSource: TXmlInputSource):boolean; override;
  end;

  TdomStandardIntSubsetXMLReader = class (TdomCustomXMLReader)
  private
    procedure FindNextAttDef(const Decl: wideString;
                               var name,
                                   attType,
                                   Bracket,
                                   defaultDecl,
                                   attValue,
                                   Rest: wideString);
  protected
    procedure writeProcessingInstruction(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const content: wideString); virtual;
    procedure writeComment(const sender: TdomCustomParser;
                           const locator: TdomStandardLocator;
                           const content: wideString); virtual;
    procedure writeParameterEntityRef(const sender: TdomCustomParser;
                                      const locator: TdomStandardLocator;
                                      const content: wideString); virtual;
    procedure writeEntityDeclaration(const sender: TdomCustomParser;
                                     const locator: TdomStandardLocator;
                                     const content: wideString); virtual;
    procedure writeElementDeclaration(const sender: TdomCustomParser;
                                      const locator: TdomStandardLocator;
                                      const content: wideString); virtual;
    procedure writeAttributeDeclaration(const sender: TdomCustomParser;
                                        const locator: TdomStandardLocator;
                                        const content: wideString); virtual;
    procedure writeNotationDeclaration(const sender: TdomCustomParser;
                                       const locator: TdomStandardLocator;
                                       const content: wideString); virtual;
  public
    function  parse(const sender: TdomCustomParser;
                    const inputSource: TXmlInputSource):boolean; override;
  end;

  TdomStandardExtSubsetXMLReader = class (TdomStandardIntSubsetXMLReader)
  protected
    function includeAsPE(const sender: TdomCustomParser;
                         const locator: TdomStandardLocator;
                         const inputSource: TXmlInputSource): wideString; virtual;
    function includeInLiteral(const sender: TdomCustomParser;
                              const locator: TdomStandardLocator;
                              const inputSource: TXmlInputSource): wideString; virtual;
    procedure writeTextDeclaration(const sender: TdomCustomParser;
                                   const locator: TdomStandardLocator;
                                   const content: wideString); virtual;
    procedure writeConditionalSection(const sender: TdomCustomParser;
                                      const locator: TdomStandardLocator;
                                      const content: wideString); virtual;
  public
    function  parse(const sender: TdomCustomParser;
                    const inputSource: TXmlInputSource):boolean; override;
  end;

  TdomStandardErrorHandler = class(TdomCustomErrorHandler)
  protected
    FErrorList: TList;
  public
    constructor create;
    destructor destroy; override;
    procedure clearErrorList; virtual;
    procedure error(const sender: TdomCustomParser;
                    const locator: TdomStandardLocator;
                    const e: EParserException;
                    const code: wideString); override;
    procedure fatalError(const sender: TdomCustomParser;
                         const locator: TdomStandardLocator;
                         const e: EParserException;
                         const code: wideString); override;
    procedure warning(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const e: EParserException;
                      const code: wideString); override;
    property errorList: TList read FErrorList;
  end;

  TdomStandardDocBuilder = class(TdomCustomContentHandler)
  protected
    FReferenceNode: TdomNode;
    FRefNode: TdomNode;
    FRefDocument: TdomDocument;
    FXMLDeclarationAllowed: boolean;
  public
    constructor create;
    procedure comment(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const data: wideString); override;
    procedure CDATA(const sender: TdomCustomParser;
                    const locator: TdomStandardLocator;
                    const data: wideString); override;
    procedure charRef(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const data: wideString); override;
    procedure doctype(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const name,
                            pubId,
                            sysId,
                            data: wideString); override;
    procedure endDocument(const sender: TdomCustomParser); override;
    procedure endElement(const sender: TdomCustomParser;
                         const locator: TdomStandardLocator;
                         const namespaceURI,
                               localName,
                               tagName: wideString); override;
    procedure endPrefixMapping(const sender: TdomCustomParser;
                               const locator: TdomStandardLocator;
                               const prefix: wideString); override;
    procedure entityRef(const sender: TdomCustomParser;
                        const locator: TdomStandardLocator;
                        const name: wideString); override;
    procedure PCDATA(const sender: TdomCustomParser;
                     const locator: TdomStandardLocator;
                     const data: wideString); override;
    procedure processingInstruction(const sender: TdomCustomParser;
                                    const locator: TdomStandardLocator;
                                    const targ,
                                          data : wideString); override;
    procedure skippedEntity(const sender: TdomCustomParser;
                            const locator: TdomStandardLocator;
                            const name: wideString); override;
    procedure startDocument(const sender: TdomCustomParser;
                            const locator: TdomStandardLocator;
                                  defaultRoot: wideString); override;
    procedure startElement(const sender: TdomCustomParser;
                           const locator: TdomStandardLocator;
                           const namespaceURI,
                                 localName,
                                 tagName: wideString;
                                 attributes: TdomNameValueList); override;
    procedure startPrefixMapping(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const prefix,
                                       uri: wideString); override;
    procedure xmlDeclaration(const sender: TdomCustomParser;
                             const locator: TdomStandardLocator;
                             const version,
                                   encDl,
                                   sdDl: wideString); override;
    property ReferenceDocument: TdomDocument read FRefDocument;
    property ReferenceNode: TdomNode read FReferenceNode write FReferenceNode;
  end;

  TdomDTDContentModelHandler = class(TdomCustomDTDHandler)
  protected
    FCurrentAttListName: wideString;
    procedure insertMixedContent(const sender: TdomCustomParser;
                                 const refNode: TdomCMNode;
                                 const contSpec: wideString); virtual;
    procedure insertChildrenContent(const sender: TdomCustomParser;
                                    const refNode: TdomCMNode;
                                    const contSpec: wideString); virtual;
    procedure insertNotationOrEnumerationContent(const sender: TdomCustomParser;
                                                 const refCMAttribute: TdomCMAttribute;
                                                 const contSpec: wideString); virtual;
  protected
    FContentModel: TdomCMObject;
    procedure ResolveCharRefsAndPERefs(const s: wideString;
                                         var result: wideString;
                                         var error: boolean); virtual;
    procedure CDataNormalization(const s: wideString;
                                   var result: wideString;
                                   var error: boolean); virtual;
  public
    procedure attributeDefinition(const sender: TdomCustomParser;
                                  const locator: TdomStandardLocator;
                                  const name,
                                        attType,
                                        bracket,
                                        defaultDecl,
                                        attValue: wideString); override;
    procedure comment(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const data: wideString); override;
    procedure conditionalSection(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const includeStmt,
                                       data: wideString); override;
    procedure elementTypeDeclaration(const sender: TdomCustomParser;
                                     const locator: TdomStandardLocator;
                                     const name,
                                           data: wideString); override;
    procedure endAttListDeclaration(const sender: TdomCustomParser;
                                    const locator: TdomStandardLocator); override;
    procedure endDtd(const sender: TdomCustomParser); override;
    procedure entityDeclaration(const sender: TdomCustomParser;
                                const locator: TdomStandardLocator;
                                const name,
                                      entityValue,
                                      pubId,
                                      sysId,
                                      notaName: wideString); override;
    procedure notationDeclaration(const sender: TdomCustomParser;
                                  const locator: TdomStandardLocator;
                                  const name,
                                        pubId,
                                        sysId: wideString); override;
    procedure parameterEntityDeclaration(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const name,
                                               entityValue,
                                               pubId,
                                               sysId: wideString); override;
    procedure parameterEntityRef(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const name: wideString); override;
    procedure processingInstruction(const sender: TdomCustomParser;
                                    const locator: TdomStandardLocator;
                                    const targ,
                                          data : wideString); override;
    procedure startAttListDeclaration(const sender: TdomCustomParser;
                                      const locator: TdomStandardLocator;
                                      const name: wideString); override;
    procedure startDtd(const sender: TdomCustomParser;
                       const pubId,
                             sysId: wideString); override;
    procedure textDeclaration(const sender: TdomCustomParser;
                              const locator: TdomStandardLocator;
                              const version,
                                    encDl: wideString); override;
    property contentModel: TdomCMObject read FContentModel;
  end;

  TdomStandardIntSubsetBuilder = class(TdomCustomDtdHandler)
  private
    FReferenceNode: TdomCMNode;
  protected
    FRefNode: TdomCMNode;
    function getPEFromCurrentCMObject(const PEReferenceName: wideString): wideString; override;
    procedure resolveCharRefsAndPERefs(const s: wideString;
                                         var result: wideString;
                                         var error: boolean); virtual;
    procedure insertMixedContent(const sender: TdomCustomParser;
                                 const refNode: TdomCMNode;
                                 const contSpec: wideString); virtual;
    procedure insertChildrenContent(const sender: TdomCustomParser;
                                    const refNode: TdomCMNode;
                                    const contSpec: wideString); virtual;
    procedure insertNotationOrEnumerationContent(const sender: TdomCustomParser;
                                                 const refCMAttrDefinition: TdomCMAttrDefinition;
                                                 const contSpec: wideString); virtual;
    procedure setReferenceNode(const node: TdomCMNode); virtual;
  public
    constructor create; virtual;
    procedure attributeDefinition(const sender: TdomCustomParser;
                                  const locator: TdomStandardLocator;
                                  const name,
                                        attType,
                                        bracket,
                                        defaultDecl,
                                        attValue: wideString); override;
    procedure comment(const sender: TdomCustomParser;
                      const locator: TdomStandardLocator;
                      const data: wideString); override;
    procedure conditionalSection(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const includeStmt,
                                       data: wideString); override;
    procedure elementTypeDeclaration(const sender: TdomCustomParser;
                                     const locator: TdomStandardLocator;
                                     const name,
                                           data: wideString); override;
    procedure endAttListDeclaration(const sender: TdomCustomParser;
                                    const locator: TdomStandardLocator); override;
    procedure endDtd(const sender: TdomCustomParser); override;
    procedure entityDeclaration(const sender: TdomCustomParser;
                                const locator: TdomStandardLocator;
                                const name,
                                      entityValue,
                                      pubId,
                                      sysId,
                                      notaName: wideString); override;
    procedure notationDeclaration(const sender: TdomCustomParser;
                                  const locator: TdomStandardLocator;
                                  const name,
                                        pubId,
                                        sysId: wideString); override;
    procedure parameterEntityDeclaration(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const name,
                                               entityValue,
                                               pubId,
                                               sysId: wideString); override;
    procedure parameterEntityRef(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const name: wideString); override;
    procedure processingInstruction(const sender: TdomCustomParser;
                                    const locator: TdomStandardLocator;
                                    const targ,
                                          data : wideString); override;
    procedure startAttListDeclaration(const sender: TdomCustomParser;
                                      const locator: TdomStandardLocator;
                                      const name: wideString); override;
    procedure startDtd(const sender: TdomCustomParser;
                       const pubId,
                             sysId: wideString); override;
    procedure textDeclaration(const sender: TdomCustomParser;
                              const locator: TdomStandardLocator;
                              const version,
                                    encDl: wideString); override;
    property referenceNode: TdomCMNode read FReferenceNode write setReferenceNode;
  end;

  TdomStandardExtSubsetBuilder = class(TdomStandardIntSubsetBuilder)
  protected
    FTextDeclarationAllowed: boolean;
    function getPEFromCurrentCMObject(const PEReferenceName: wideString): wideString; override;
    procedure setReferenceNode(const node: TdomCMNode); override;
  public
    constructor create; override;
    procedure conditionalSection(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const includeStmt,
                                       data: wideString); override;
    procedure parameterEntityRef(const sender: TdomCustomParser;
                                 const locator: TdomStandardLocator;
                                 const name: wideString); override;
    procedure startDtd(const sender: TdomCustomParser;
                       const pubId,
                             sysId: wideString); override;
    procedure textDeclaration(const sender: TdomCustomParser;
                              const locator: TdomStandardLocator;
                              const version,
                                    encDl: wideString); override;
  end;

  TdomCustomParser = class (TComponent);

  TdomDtdAnalyzer = class (TdomCustomParser)
  private
    FErrorHandler: TdomCustomErrorHandler;
    FDtdHandler: TdomDTDContentModelHandler;
    FDtdReader: TdomStandardContentModelReader;
    FIntDtdReader: TdomStandardIntSubsetXMLReader;
  public
    constructor create(aOwner: TComponent); override;
    destructor destroy; override;
    procedure analyzeCM(const source: TdomCustomCMIEObject;
                        const contentModel: TdomCMObject); virtual;
    procedure analyzeIntDTDStr(      str: wideString;
                               const contentModel: TdomCMObject); virtual;
    property dtdHandler: TdomDTDContentModelHandler read FDtdHandler;
    property dtdReader: TdomStandardContentModelReader read FDtdReader;
    property errorHandler: TdomCustomErrorHandler read FErrorHandler write FErrorHandler;
    property intDtdReader: TdomStandardIntSubsetXMLReader read FIntDtdReader;
  end;

  TXmlToDomParser = class (TdomCustomParser)
  private
    FDOMImpl: TDomImplementation;
    FOnExternalSubset: TXmlParserEvent;
    procedure setDomImpl(const impl: TDomImplementation); virtual;
    function  getDomImpl: TDomImplementation; virtual;
  protected
    FDocBuilder: TdomStandardDocBuilder;
    FDocXMLReader: TdomStandardDocXMLReader;
    FErrorHandler: TdomStandardErrorHandler;
    FExtDtdBuilder: TdomStandardExtSubsetBuilder;
    FExtDtdReader: TdomStandardExtSubsetXMLReader;
    FIntDtdBuilder: TdomStandardIntSubsetBuilder;
    FIntDtdReader: TdomStandardIntSubsetXMLReader;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure parseDtd(const locator: TdomStandardLocator;
                       const name,
                             pubId,
                             sysId,
                             data: wideString;
                       const standalone: boolean); virtual;
  public
    constructor create(aOwner: TComponent); override;
    destructor destroy; override;
    procedure docMemoryToDom(const ptr: pointer;
                             const size: longint;
                             const pubId,
                                   sysId: wideString;
                             const refNode: TdomNode); virtual;
    procedure docSourceCodeToDom(const docSourceCode: TXmlSourceCode;
                                 const pubId,
                                       sysId: wideString;
                                 const refNode: TdomNode); virtual;
    procedure docStreamToDom(const stream: TStream;
                             const pubId,
                                   sysId: wideString;
                             const refNode: TdomNode); virtual;
    procedure docStringToDom(const Str: string;
                             const pubId,
                                   sysId: wideString;
                             const refNode: TdomNode); virtual;
    procedure docWideStringToDom(      str: wideString;
                                 const pubId,
                                       sysId: wideString;
                                 const refNode: TdomNode); virtual;
    procedure extDtdMemoryToDom(const ptr: pointer;
                                const size: longint;
                                const pubId,
                                      sysId: wideString;
                                const refNode: TdomCMNode); virtual;
    procedure extDtdSourceCodeToDom(const ExtDtdSourceCode: TXmlSourceCode;
                                    const pubId,
                                          sysId: wideString;
                                    const refNode: TdomCMNode); virtual;
    procedure extDtdStreamToDom(const stream: TStream;
                                const pubId,
                                      sysId: wideString;
                                const refNode: TdomCMNode); virtual;
    procedure extDtdStringToDom(const str: string;
                                const pubId,
                                      sysId: wideString;
                                const refNode: TdomCMNode); virtual;
    procedure extDtdWideStringToDom(      str: wideString;
                                    const pubId,
                                          sysId: wideString;
                                    const refNode: TdomCMNode); virtual;
    procedure intDtdMemoryToDom(const ptr: pointer;
                                const size: longint;
                                const pubId,
                                      sysId: wideString;
                                const refNode: TdomCMNode); virtual;
    procedure intDtdSourceCodeToDom(const IntDtdSourceCode: TXmlSourceCode;
                                    const pubId,
                                          sysId: wideString;
                                    const refNode: TdomCMNode); virtual;
    procedure intDtdStreamToDom(const stream: TStream;
                                const pubId,
                                      sysId: wideString;
                                const refNode: TdomCMNode); virtual;
    procedure intDtdStringToDom(const str: string;
                                const pubId,
                                      sysId: wideString;
                                const refNode: TdomCMNode); virtual;
    procedure intDtdWideStringToDom(      str: wideString;
                                    const pubId,
                                          sysId: wideString;
                                    const refNode: TdomCMNode); virtual;
    function fileToDom(const filename: TFileName): TdomDocument; virtual;
    function memoryToDom(const ptr: pointer;
                         const size: longint): TdomDocument; virtual;
    function sourceCodeToDom(const intDtdSourceCode: TXmlSourceCode): TdomDocument; virtual;
    function streamToDom(const stream: TStream): TdomDocument; virtual;
    function stringToDom(const str: String): TdomDocument; virtual;
    function wideStringToDom(str: wideString): TdomDocument; virtual;
    property docBuilder: TdomStandardDocBuilder read FDocBuilder;
    property docXMLReader: TdomStandardDocXMLReader read FDocXMLReader;
    property errorHandler: TdomStandardErrorHandler read FErrorHandler;
    property extDtdBuilder: TdomStandardExtSubsetBuilder read FExtDtdBuilder;
    property extDtdReader: TdomStandardExtSubsetXMLReader read FExtDtdReader;
    property intDtdBuilder: TdomStandardIntSubsetBuilder read FIntDtdBuilder;
    property intDtdReader: TdomStandardIntSubsetXMLReader read FIntDtdReader;
  published
    property DOMImpl: TDomImplementation read getDomImpl write setDomImpl;
    property onExternalSubset: TXmlParserEvent read FOnExternalSubset write FOnExternalSubset;
  end;

function xmlExtractPrefix(const qualifiedName: wideString): wideString;
function xmlExtractLocalName(const qualifiedName: wideString): wideString;

function isXmlChar(const S: WideChar): boolean;
function isXmlWhiteSpace(const S: WideChar): boolean;
function isXmlLetter(const S: WideChar): boolean;
function isXmlBaseChar(const S: WideChar): boolean;
function isXmlIdeographic(const S: WideChar): boolean;
function isXmlCombiningChar(const S: WideChar): boolean;
function isXmlDigit(const S: WideChar): boolean;
function isXmlExtender(const S: WideChar): boolean;
function isXmlNameChar(const S: WideChar): boolean;
function isXmlPubidChar(const S: WideChar): boolean;

function isXmlChars(const S: wideString): boolean;
function isXmlS(const S: wideString): boolean;
function isXmlName(const S: wideString): boolean;
function isXmlNames(const S: wideString): boolean;
function isXmlNmtoken(const S: wideString): boolean;
function isXmlNmtokens(const S: wideString): boolean;
function isXmlCharRef(const S: wideString): boolean;
function isXmlEntityRef(const S: wideString): boolean;
function isXmlPEReference(const S: wideString): boolean;
function isXmlReference(const S: wideString): boolean;
function isXmlEntityValue(const S: wideString): boolean;
function isXmlAttValue(const S: wideString): boolean;
function isXmlSystemLiteral(const S: wideString): boolean;
function isXmlPubidLiteral(const S: wideString): boolean;
function isXmlComment(const S: wideString): boolean;
function isXmlCData(const S: wideString): boolean;
function isXmlCharData(const S: wideString): boolean;
function isXmlPITarget(const S: wideString): boolean;
function isXmlVersionNum(const S: wideString): boolean;
function isXmlEncName(const S: wideString): boolean;
function isXmlStringType(const S: wideString): boolean;
function isXmlTokenizedType(const S: wideString): boolean;

function isXmlNCNameChar(const s: WideChar): boolean;
function isXmlNCName(const S: wideString): boolean;
function isXmlDefaultAttName(const S: wideString): boolean;
function isXmlPrefixedAttName(const S: wideString): boolean;
function isXmlNSAttName(const S: wideString): boolean;
function isXmlLocalPart(const S: wideString): boolean;
function isXmlPrefix(const S: wideString): boolean;
function isXmlQName(const S: wideString): boolean;

function resolveCharRefs(const S: wideString): wideString;
function xmlIntToCharRef(const value: integer): wideString;
function xmlCharRefToInt(const S: wideString): integer;
function xmlCharRefToStr(const S: wideString): wideString;
function xmlStrToCharRef(const S: wideString): wideString;
function Iso8859_1ToUTF16Char(const P: Char):WideChar;
function Iso8859_2ToUTF16Char(const P: Char):WideChar;
function Iso8859_3ToUTF16Char(const P: Char):WideChar;
function Iso8859_4ToUTF16Char(const P: Char):WideChar;
function Iso8859_5ToUTF16Char(const P: Char):WideChar;
function Iso8859_6ToUTF16Char(const P: Char):WideChar;
function Iso8859_7ToUTF16Char(const P: Char):WideChar;
function Iso8859_8ToUTF16Char(const P: Char):WideChar;
function Iso8859_9ToUTF16Char(const P: Char):WideChar;
function Iso8859_10ToUTF16Char(const P: Char):WideChar;
function Iso8859_13ToUTF16Char(const P: Char):WideChar;
function Iso8859_14ToUTF16Char(const P: Char):WideChar;
function Iso8859_15ToUTF16Char(const P: Char):WideChar;
function KOI8_RToUTF16Char(const P: Char):WideChar;
function cp10000_MacRomanToUTF16Char(const P: Char):WideChar;
function cp1250ToUTF16Char(const P: Char):WideChar;
function cp1251ToUTF16Char(const P: Char):WideChar;
function cp1252ToUTF16Char(const P: Char):WideChar;
function Iso8859_1ToUTF16Str(const S: string):wideString;
function Iso8859_2ToUTF16Str(const S: string):wideString;
function Iso8859_3ToUTF16Str(const S: string):wideString;
function Iso8859_4ToUTF16Str(const S: string):wideString;
function Iso8859_5ToUTF16Str(const S: string):wideString;
function Iso8859_6ToUTF16Str(const S: string):wideString;
function Iso8859_7ToUTF16Str(const S: string):wideString;
function Iso8859_8ToUTF16Str(const S: string):wideString;
function Iso8859_9ToUTF16Str(const S: string):wideString;
function Iso8859_10ToUTF16Str(const S: string):wideString;
function Iso8859_13ToUTF16Str(const S: string):wideString;
function Iso8859_14ToUTF16Str(const S: string):wideString;
function Iso8859_15ToUTF16Str(const S: string):wideString;
function KOI8_RToUTF16Str(const S: string):wideString;
function cp10000_MacRomanToUTF16Str(const S: string):wideString;
function cp1250ToUTF16Str(const S: string):wideString;
function cp1251ToUTF16Str(const S: string):wideString;
function cp1252ToUTF16Str(const S: string):wideString;
function UTF8ToUTF16BEStr(const S: string): wideString;
function UTF16BEToUTF8Str(const ws: wideString;
                          const expandLF: boolean): string;
function UTF16HighSurrogate(const value: integer): WideChar;
function UTF16LowSurrogate(const value: integer): WideChar;
function UTF16SurrogateToInt(const highSurrogate, lowSurrogate: WideChar): integer;
function IsUTF16HighSurrogate(const S: WideChar): boolean;
function IsUTF16LowSurrogate(const S: WideChar): boolean;

procedure Register;

procedure xmlAnalyseElement(const source: wideString;
                              var tagName: wideString;
                                  attributes: TdomNameValueList);

procedure xmlAnalyseEntityDef(    source: wideString;
                              var entityValue,
                                  systemLiteral,
                                  pubidLiteral,
                                  nDataName: wideString;
                              var error: boolean);

procedure xmlAnalyseNotationDecl(const decl: wideString;
                                   var systemLiteral,
                                       pubidLiteral: wideString;
                                   var error: boolean);

procedure xmlAnalysePCDATA(source: wideString;
                           var lines: TStringList);

function xmlAnalysePubSysId(const publicId,
                                  systemId,
                                  notaName: wideString): wideString;

procedure xmlAnalyseTag(const source: wideString;
                          var tagName,
                              attribSequence: wideString);

procedure xmlIsolateQuote(    source: wideString;
                          var content,
                              rest: wideString;
                          var quoteType: WideChar;
                          var error: boolean);

function xmlNormalizeLineBreaks(const source :wideString): wideString;

function xmlReplaceQuotes(const source: wideString): wideString;

function xmlTrunc(const source: wideString): wideString;

procedure xmlTruncAngularBrackets(const source: wideString;
                                    var content: wideString;
                                    var error: boolean);

procedure xmlTruncRoundBrackets(const source: wideString;
                                  var content: wideString;
                                  var error: boolean);

procedure writeWideString(stream: TStream; const xmlStrg: wideString);

procedure writeWideStrings(stream: TStream; const xmlStrgs: array of wideString);

procedure writeWideChars(stream: TStream; const xmlChars: array of wideChar);

var
  domDocumentFormatList: PdomDocumentFormat = nil;


implementation

type
  PLongint = ^longint;  // is declared in Windows.pas - but did not want to link it in

procedure Register;
begin
  RegisterComponents('XML',[TDomImplementation,TXmlToDomParser,TXmlStandardProcessorAgent,TXmlStandardDocReader,TXmlStandardDomReader,TXmlStandardHandler,TXmlDistributor,TXmlWFTestContentHandler,TXmlDocBuilder]);
//  RegisterPropertyEditor(TypeInfo(TXmlHandlers),TXmlDistributor,'',THandlerListProperty);
end;

function xmlNormalizeLineBreaks(const source :wideString): wideString;
const
  CR: WideChar  = #13;
  LF: WideChar  = #10;
  CRLF: wideString = #13#10;
var
  nPos: integer;
begin
  Result:= source;

  // CR+LF --> LF
  repeat
    nPos := Pos(CRLF, Result);
    if nPos > 0 then
      Delete(Result, nPos, 1);
  until nPos = 0;

  // CR --> LF
  repeat
    nPos := Pos(CR, Result);
    if nPos > 0 then
      Result[nPos] := LF;
  until nPos = 0;
end;


procedure XMLAnalysePCDATA(Source: wideString;
                           var Lines: TStringList);
// 'Source': The PCDATA-Sequence to be analyzed.
// 'Lines':  Returns the content of PCDATA in singles lines containing
//           only whitespace or only characters without whitespace.
var
  i: integer;
  Line: string;
begin
  i:= 0;
  Lines.clear;
  while (i<length(Source)) do
  begin

    // No White-space?
    Line:= '';
    while (i<length(Source)) do
    begin
      inc(i);
      if IsXmlWhiteSpace(Source[i]) then begin dec(i); break; end;
      Line:= concat(Line,Source[i]);
    end;
    if Line <> '' then Lines.Add(Line);

    // White-space?
    Line:= '';
    while (i<length(Source)) do
    begin
      inc(i);
      if not IsXmlWhiteSpace(Source[i]) then begin dec(i); break; end;
      Line:= concat(Line,Source[i]);
    end;
    if Line <> '' then Lines.Add(Line);

  end;
end;

procedure xmlAnalyseElement(const source: wideString;
                              var tagName: wideString;
                                  attributes: TdomNameValueList);
// 'Source': The element, to be analyzed.
// 'tagName': Returns the namen of the element.
// 'attributes': Returns a list of attributes, if existing.
const
  SQ: WideChar = #39; // code of '
  DQ: WideChar = #34; // code of "
var
  i,j,sourceLength : integer;
  AttribSequence: wideString;
  name,value: wideString;
  QuoteType: WideChar;
  EqualSign,WhiteSpace: boolean;
begin
  attributes.clear;

  sourceLength:= length(Source);  // buffer storage to increase performance

  // Evaluate tagName:
  i:= 1;
  while i <= sourceLength do begin
    if IsXmlWhiteSpace(Source[i]) then break;
    inc(i);
  end;

  tagName:= copy(Source,1,i-1);

  // Evaluate Attributes:
  while i < sourceLength do begin  // xxx �berfl�ssig?
    inc(i);
    if not IsXmlWhiteSpace(Source[i]) then break;
  end;
  j:= length(Source);
  while j >= i do begin // xxx �berfl�ssig?
    if not IsXmlWhiteSpace(Source[j]) then break;
    dec(j);
  end;

  AttribSequence:= copy(Source,i,j-i+1);
  WhiteSpace:= true;
  QuoteType:= 'x';

  i:= 0;
  while (i<length(attribSequence)) do
  begin

    if not WhiteSpace  // xxx �berfl�ssig?
      then raise EParserMissingWhiteSpace_Err.create('Missing white-space error.');

    if i < length(attribSequence) then begin
      name:= '';
      while (i<length(attribSequence)) do
      begin
        if IsXmlWhiteSpace(attribSequence[i+1]) or (attribSequence[i+1] = '=') then break;
        inc(i);
        name:= concat(name,wideString(attribSequence[i]));
      end;

      EqualSign:= false;
      while (i<length(attribSequence)) do
      begin
        inc(i);
        if not (IsXmlWhiteSpace(attribSequence[i]) or (attribSequence[i] = '=')) then
        begin
          if ((attribSequence[i] = SQ) or (attribSequence[i] = DQ)) then begin
            if not EqualSign
              then raise EParserMissingEqualitySign_Err.create('Missing equality sign error.');
            QuoteType:= attribSequence[i];
            break;
          end else raise EParserMissingQuotationMark_Err.create('Missing quotation mark error.');
        end else
          if attribSequence[i] = '=' then
            if EqualSign
              then raise EParserDoubleEqualitySign_Err.create('Double equality sign error.')
              else EqualSign:= true;
      end;

      value:='';
      while (i<length(attribSequence)) do
      begin
        inc(i);
        if attribSequence[i] = QuoteType then break;
        value:= concat(value,wideString(attribSequence[i]));
      end;

      // invalid attribute name?
      if not IsXmlName(name)
        then raise EParserInvalidAttributeName_Err.create('Invalid attribute name error.');

      // missing closing quotation mark?
      if attribSequence[i] <> QuoteType
        then raise EParserMissingQuotationMark_Err.create('Missing quotation mark error.');

      // double attribute names?
      if attributes.indexOfName(name) > -1
        then raise EParserDoubleAttributeName_Err.create('Double attribute name error.');

      Attributes.add(name,value);

    end; {if i < length(attribSequence)}

    // white-space?
    WhiteSpace:= false;
    while (i<length(attribSequence)) do
    begin
      inc(i);
      if not IsXmlWhiteSpace(attribSequence[i])
        then begin dec(i); break; end
        else WhiteSpace:= true;
    end;

  end; {while (i<length(attribSequence))}
end;

procedure xmlAnalyseTag(const source: wideString;
                        var tagName,
                            AttribSequence: wideString);
// 'Source': The tag, to be analyzed.
// 'tagName': Returns the namen of the tag.
// 'AttribSequence': Returns the Attributes, if existing.
var
  i,j,sourceLength : integer;
begin
  sourceLength:= length(Source);  // buffer storage to increase performance

  // Evaluate tagName:
  i:= 1;
  while i <= sourceLength do begin
    if IsXmlWhiteSpace(Source[i]) then break;
    inc(i);
  end;

  tagName:= copy(Source,1,i-1);

  // Evaluate Attributes:
  while i < sourceLength do begin
    inc(i);
    if not IsXmlWhiteSpace(Source[i]) then break;
  end;
  j:= length(Source);
  while j >= i do begin
    if not IsXmlWhiteSpace(Source[j]) then break;
    dec(j);
  end;

  AttribSequence:= copy(Source,i,j-i+1);
end;

procedure XMLAnalyseAttrSequence(const Source: wideString;
                                 const Element: TdomElement);
// 'Source':  The attribute sequence to be analyzed.
// 'Element': The TdomElement node to which the attributes as
//            TdomAttr nodes will be added.
const
  SingleQuote: WideChar = #39; // code of '
  DoubleQuote: WideChar = #34; // code of "
var
  i,j : integer;
  name,value,v,text,CharacRef: wideString;
  QuoteType: WideChar;
  IsEntity,EqualSign,WhiteSpace: boolean;
  Attri: TdomAttr;
begin
  WhiteSpace:= true;
  QuoteType:= 'x';

  i:= 0;
  while (i<length(Source)) do
  begin

    if not WhiteSpace
      then raise EParserMissingWhiteSpace_Err.create('Missing white-space error.');

    if i < length(Source) then begin
      name:= '';
      while (i<length(Source)) do
      begin
        if IsXmlWhiteSpace(Source[i+1]) or (Source[i+1] = '=') then break;
        inc(i);
        name:= concat(name,wideString(Source[i]));
      end;

      EqualSign:= false;
      while (i<length(Source)) do
      begin
        inc(i);
        if not (IsXmlWhiteSpace(Source[i]) or (Source[i] = '=')) then
        begin
          if ((Source[i] = SingleQuote) or (Source[i] = DoubleQuote)) then begin
            if not EqualSign
              then raise EParserMissingEqualitySign_Err.create('Missing equality sign error.');
            QuoteType:= Source[i];
            break;
          end else raise EParserMissingQuotationMark_Err.create('Missing quotation mark error.');
        end else
          if Source[i] = '=' then
            if EqualSign
              then raise EParserDoubleEqualitySign_Err.create('Double equality sign error.')
              else EqualSign:= true;
      end;

      value:='';
      while (i<length(Source)) do
      begin
        inc(i);
        if Source[i] = QuoteType then break;
        value:= concat(value,wideString(Source[i]));
      end;

      // invalid attribute name?
      if not IsXmlName(name)
        then raise EParserInvalidAttributeName_Err.create('Invalid attribute name error.');

      // missing closing quotation mark?
      if Source[i] <> QuoteType
        then raise EParserMissingQuotationMark_Err.create('Missing quotation mark error.');

      // double attribute names?
      if assigned(Element.Attributes.GetNamedItem(name))
        then raise EParserDoubleAttributeName_Err.create('Double attribute name error.');

      if pos('&',value) = 0 then begin
        // invalid attribute value?
        if not IsXmlCharData(value)
          then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
        Element.SetAttribute(name,value);
      end else begin
        Attri:= Element.OwnerDocument.CreateAttribute(name);
        Element.SetAttributeNode(Attri);
        IsEntity:= false;
        text:= '';
        for j:= 1 to Length(value) do begin
          if IsEntity then begin
            if value[j] = ';' then begin
              if text[1] = '#' then begin {CharRef}
              try
                CharacRef:= concat(wideString('&'),text,wideString(';'));
                v:= XmlCharRefToStr(CharacRef);
                if assigned(Attri.LastChild) and (Attri.LastChild.NodeType = ntText_Node)
                  then (Attri.LastChild as TdomText).appendData(v)
                  else Attri.appendChild(Element.OwnerDocument.CreateTextNode(v));
              except
                on EConvertError do
                  raise EParserInvalidCharRef_Err.create('Invalid character reference error.');
              end; {try}
              end else begin
                if not IsXmlName(text)
                  then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
                Attri.appendChild(Element.OwnerDocument.CreateEntityReference(text));
              end;
              text:= '';
              IsEntity:= false;
            end else Text:= concat(text,wideString(value[j]));
          end else begin
            if value[j] = '&' then begin
              if text <> '' then begin
                // invalid attribute value?
                if not IsXmlCharData(text)
                  then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
                Attri.appendChild(Element.OwnerDocument.CreateTextNode(text));
              end;
              text:= '';
              IsEntity:= true;
            end else Text:= concat(text,wideString(value[j]));
          end; {if ...}
        end; {for ...}
        // invalid attribute value?
        if IsEntity
          then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
        if text <> '' then Attri.appendChild(Element.OwnerDocument.CreateTextNode(text));
      end; {if ...}

    end; {if i < length(Source)}

    // white-space?
    WhiteSpace:= false;
    while (i<length(Source)) do
    begin
      inc(i);
      if not IsXmlWhiteSpace(Source[i])
        then begin dec(i); break; end
        else WhiteSpace:= true;
    end;

  end; {while (i<length(Source))}
end;

procedure XMLAnalyseEntityDef(    Source: wideString;
                              var entityValue,
                                  SystemLiteral,
                                  PubidLiteral,
                                  NDataName: wideString;
                              var Error: boolean);
// 'Source': The entity definition to be analyzed.
// 'entityValue','SystemLiteral','PubidLiteral','NDataName':
//    Return the respective values, if declared.
// 'Error': Returns 'true', if the entity definition is not well-formed.
var
  i : integer;
  SingleQuote,DoubleQuote,QuoteType: WideChar;
  rest, intro, SystemLit, PubidLit, dummy: wideString;
begin
  entityValue:= '';
  SystemLiteral:= '';
  SystemLit:= '';
  PubidLiteral:= '';
  PubidLit:= '';
  NDataName:= '';
  intro:= '';
  Error:= false;
  if Length(Source) < 2 then begin Error:= true; exit; end;
  SingleQuote:= chr(39); // Code of '.
  DoubleQuote:= chr(34); // Code of ".

  // Remove leading white space:
  i:= 1;
  while (i<=length(Source)) do begin
    if not IsXmlWhiteSpace(Source[i]) then break;
    inc(i);
  end;
  if i >= Length(Source) then begin Error:= true; exit; end;
  dummy:= copy(Source,i,Length(Source)-i+1);
  Source:= dummy; // Necessary, because of Delphi's problem when copying WideStrings.
  if (Source[1] = SingleQuote) or (Source[1] = DoubleQuote) then begin
    XMLIsolateQuote(Source,entityValue,rest,QuoteType,Error);
    if Error then exit;
    if rest <> '' then begin Error:= true; exit; end;
    if not IsXmlEntityValue(concat(wideString(QuoteType),entityValue,wideString(QuoteType)))
      then begin Error:= true; exit; end;
  end else begin
    intro:= copy(Source,1,6);
    if (intro = 'SYSTEM') or (intro = 'PUBLIC') then begin
      Dummy:= copy(Source,7,Length(Source)-6);
      Source:= dummy; // Necessary, because of Delphi's problem when copying WideStrings.
      if Source = '' then begin Error:= true; exit; end;
      if not IsXmlWhiteSpace(Source[1]) then begin Error:= true; exit; end;

      if (intro = 'SYSTEM') then begin
        XMLIsolateQuote(Source,SystemLit,Source,QuoteType,Error);
        if Error then exit;
        if not IsXmlSystemLiteral(concat(wideString(QuoteType),SystemLit,wideString(QuoteType)))
          then begin Error:= true; exit; end;
      end else begin
        XMLIsolateQuote(Source,PubidLit,Source,QuoteType,Error);
        if Error then exit;
        if not IsXmlPubidLiteral(concat(wideString(QuoteType),PubidLit,wideString(QuoteType)))
          then begin Error:= true; exit; end;
        XMLIsolateQuote(Source,SystemLit,Source,QuoteType,Error);
        if Error then exit;
        if not IsXmlSystemLiteral(concat(wideString(QuoteType),SystemLit,wideString(QuoteType)))
          then begin Error:= true; exit; end;
      end;

      if Source <> '' then begin
        if copy(Source,1,5) = 'NDATA' then begin
          dummy:= copy(Source,6,Length(Source)-5);
          Source:= XmlTrunc(dummy); // Necessary, because of Delphi's problem when copying WideStrings.
          if IsXmlName(Source)
            then NDataName:= Source
            else begin Error:= true; exit; end;
        end else begin Error:= true; exit; end;
      end;

    end else begin Error:= true; exit; end;
    SystemLiteral:= SystemLit;
    PubidLiteral:= PubidLit;
  end; {if (Source[1] ... }
end;


procedure XMLAnalyseNotationDecl(const Decl: wideString;
                                   var SystemLiteral,
                                       PubidLiteral: wideString;
                                   var Error: boolean);
// 'Source': The notation declaration to be analyzed.
// 'SystemLiteral','PubidLiteral','NDataName':
//    Return the respective values, if declared.
// 'Error': Returns 'true', if the notation declaration is not well-formed.
var
  QuoteType: WideChar;
  intro, SystemLit, PubidLit, dummy, Source: wideString;
begin
  SystemLiteral:= '';
  SystemLit:= '';
  PubidLiteral:= '';
  PubidLit:= '';
  intro:= '';
  Error:= false;
  if Length(Decl) < 2 then begin Error:= true; exit; end;

  Source:= XMLTrunc(Decl);
  intro:= copy(Source,1,6);

  if (intro<>'SYSTEM') and (intro<>'PUBLIC') then begin Error:= true; exit; end;

  Dummy:= copy(Source,7,Length(Source)-6);
  Source:= dummy; // Necessary, because of Delphi's problem when copying WideStrings.
  if Source = '' then begin Error:= true; exit; end;
  if not IsXmlWhiteSpace(Source[1]) then begin Error:= true; exit; end;

  if (intro = 'SYSTEM') then begin
    XMLIsolateQuote(Source,SystemLit,dummy,QuoteType,Error);
    if Error then exit;
    if dummy <> '' then begin Error:= true; exit; end;
    if not IsXmlSystemLiteral(concat(wideString(QuoteType),SystemLit,wideString(QuoteType)))
      then begin Error:= true; exit; end;
  end else begin
    XMLIsolateQuote(Source,PubidLit,dummy,QuoteType,Error);
    Source:= dummy;
    if Error then exit;
    if not IsXmlPubidLiteral(concat(wideString(QuoteType),PubidLit,wideString(QuoteType)))
      then begin Error:= true; exit; end;
    if Source <> '' then begin
      if not IsXmlSystemLiteral(Source) then begin Error:= true; exit; end;
      SystemLit:= copy(Source,2,length(Source)-2);
    end;
  end;

  SystemLiteral:= SystemLit;
  PubidLiteral:= PubidLit;
end;

function xmlReplaceQuotes(const source: wideString): wideString;
// This function replaces all single and double quotes
// with their respective character references.
var
  i: integer;
  content: TdomCustomStr;
begin
  result:= '';
  content:= TdomCustomStr.create;
  try
    for i:= 1 to length(source) do begin
      case ord(source[i]) of
        39: content.addWideString('&#39;'); // Single quote
        34: content.addWideString('&#34;'); // Double quote
      else
        content.addWideChar(source[i]);
      end;
    end;
    Result:= content.value;
  finally
    content.free;
  end;
end;

function xmlReplaceSpecialCharacters(const source: wideString): wideString;
// This function replaces the following characters
// with their respective character references:
//              <     &#60;
//              >     &#62;
//              &     &#38;
//              '     &#39;
//              "     &#34;
var
  i: integer;
  content: TdomCustomStr;
begin
  result:= '';
  content:= TdomCustomStr.create;
  try
    for i:= 1 to length(source) do begin
      case ord(source[i]) of
        60: content.addWideString('&#60;'); // Less than
        62: content.addWideString('&#62;'); // Greater than
        38: content.addWideString('&#38;'); // Ampersand
        39: content.addWideString('&#39;'); // Single quote
        34: content.addWideString('&#34;'); // Double quote
      else
        content.addWideChar(source[i]);
      end;
    end;
    Result:= content.value;
  finally
    content.free;
  end;
end;

function xmlTrunc(const source: wideString): wideString;
// This function removes all white space at the beginning
// or end of 'Source'.
var
  i: integer;
begin
  Result:= '';
  i:= 1;
  while (i <= length(Source)) do begin
    if not IsXmlWhiteSpace(Source[i]) then break;
    inc(i);
  end;
  if i > Length(Source) then exit;
  Result:= copy(Source,i,Length(Source)-i+1);
  i:= length(Result);
  while i > 0 do begin
    if not IsXmlWhiteSpace(Result[i]) then break;
    dec(i);
  end;
  if i = 0
    then Result:= ''
    else Result:= copy(Result,1,i);
end;

function XMLTruncSpace(const Source: wideString): wideString;
// This function removes all spaces (#$20) at the beginning
// or end of 'Source'.
const
  SPACE: WideChar  = #$20;
var
  i,startIndex,endIndex: integer;
begin
  startIndex:= length(source)+1;
  endIndex:= 0;
  for i:= 1 to length(source) do begin
    if not (Source[i] = SPACE) then begin
      startIndex:= i;
      break;
    end;
  end;
  for i:= length(source) downto startIndex do begin
    if not (Source[i] = SPACE) then begin
      endIndex:= i;
      break;
    end;
  end;
  Result:= copy(Source,startIndex,endIndex-startIndex+1);
end;

procedure XMLTruncAngularBrackets(const Source: wideString;
                                    var content: wideString;
                                    var Error: boolean);
{Die Prozedur entfernt evtl. vorhandenen White-Space am Anfang und
 Ende von 'Source', pr�ft dann, ob der verbleibende wideString durch
 eckige KLammern -- '[' und ']' -- eingerahmt wird. Ist dies der Fall,
 wird der Klammer-Inhalt in 'content' zur�ckgegeben und 'Error' wird
 auf 'false' gesetzt. Ist dies nicht der Fall, gibt 'content' einen leeren
 wideString ('') zur�ck und 'Error' wird auf 'true' gesetzt.}
var
  BracketStr: wideString;
begin
  content:= '';
  BracketStr:= XMLTrunc(Source);
  if length(BracketStr) < 2 then begin Error:= true; exit; end;
  if (BracketStr[1] <> '[') or (BracketStr[length(BracketStr)] <> ']')
    then Error:= true
    else begin
      content:= copy(BracketStr,2,Length(BracketStr)-2);
      Error:= false;
    end;
end;

procedure XMLTruncRoundBrackets(const Source: wideString;
                                  var content: wideString;
                                  var Error: boolean);
{Die Prozedur entfernt evtl. vorhandenen White-Space am Anfang und Ende
 von 'Source', pr�ft dann, ob der verbleibende wideString durch runde
 KLammern -- '(' und ')' -- eingerahmt wird. Ist dies der Fall, wird vom
 Klammer-Inhalt erneut evtl. vorhandener Leerraum am Anfang und Ende
 entfernt und das Ergebnis in 'content' zur�ckgegeben sowie 'Error' auf
 'false' gesetzt. Ist dies nicht der Fall, gibt 'content' einen leeren
 wideString ('') zur�ck und 'Error' wird auf 'true' gesetzt.}
var
  BracketStr: wideString;
begin
  content:= '';
  BracketStr:= XMLTrunc(Source);
  if length(BracketStr) < 2 then begin Error:= true; exit; end;
  if (BracketStr[1] <> '(') or (BracketStr[length(BracketStr)] <> ')')
    then Error:= true
    else begin
      content:= XMLTrunc(copy(BracketStr,2,Length(BracketStr)-2));
      Error:= false;
    end;
end;

procedure XMLIsolateQuote(    Source: wideString;
                          var content,
                              rest: wideString;
                          var QuoteType: WideChar;
                          var Error: boolean);
{Analysiert einen wideString ('Source'):  F�hrender White-Space wird
 abgeschnitten, danach wird ein in einfache oder doppelte Anf�hrungs-
 zeichen gesetzter Text (der auch leer sein kann) erwartet, dessen Inhalt
 in 'content' zur�ckgegeben wird.  'QuoteType' gibt den Wert der
 Anf�hrungszeichen zur�ck (#39; f�r einfache und #34; f�r doppelte
 Anf�hrungszeichen).  Wird nach dem Entfernen des f�hrenden White-Spaces
 kein Anf�hrungszeichen gefunden oder fehlt das korrespondierende
 Schlu�zeichen, wird die Routine abgebrochen und 'Error = true' zur�ck-
 gegeben. Anschlie�end wird �berpr�ft, ob dirket nach dem Schlu�zeichen
 etwas anderes als White-Space folgt (bzw. der wideString zuende ist).
 Falls etwas anderes folgt, wird 'Error = true' zur�ckgegeben. Falls
 nicht, wird bis zum n�chsten Nicht-White-Space-Zeichen gesucht und der
 Rest des WideStrings in 'rest' zur�ckgegeben. F�r alle F�lle, in denen
 'Error = true' zur�ckgegebn wird, werden 'content' und 'rest' als leer
 ('') und 'QuoteType' als #0; zur�ckgegeben.}
var
  i,quotepos: integer;
  SingleQuote,DoubleQuote: WideChar;
  dummy: wideString;
begin
  content:= '';
  rest:= '';
  QuoteType:= #0;
  if Length(Source) < 2 then begin Error:= true; exit; end;
  SingleQuote:= #39; {Code f�r ein einfaches Anf�hrungszeichen (').}
  DoubleQuote:= #34; {Code f�r ein doppeltes Anf�hrungszeichen (").}
  Error:= false;

  {White-space am Anfang entfernen:}
  i:= 1;
  while (i <= length(Source)) do begin
    if not IsXmlWhiteSpace(Source[i]) then break;
    inc(i);
  end;
  if i >= Length(Source) then begin Error:= true; exit; end;
  Dummy:= copy(Source,i,Length(Source)-i+1);
  Source:= dummy; {Diese umst�ndliche Zuweisung ist wegen Delphi-Problem von WideStrings bei copy n�tig}
  if (Source[1] <> SingleQuote) and (Source[1] <> DoubleQuote)
    then begin Error:= true; exit; end;
  QuoteType:= Source[1];
  Dummy:= Copy(Source,2,Length(Source)-1);
  Source:= dummy; {Diese umst�ndliche Zuweisung ist wegen Delphi-Problem von WideStrings bei copy n�tig}
  QuotePos:= Pos(wideString(QuoteType),Source);
  if QuotePos = 0 then begin Error:= true; exit; end;
  if Length(Source) > QuotePos then
    if not IsXmlWhiteSpace(Source[QuotePos+1])
      then begin QuoteType:= #0; Error:= true; exit; end;
  content:= Copy(Source,1,QuotePos-1);
  {White-Space nach dem Anf�hrungszeichen-Abschnitt entfernen:}
  i:= QuotePos + 1;
  while (i <= length(Source)) do begin
    if not IsXmlWhiteSpace(Source[i]) then break;
    inc(i);
  end;
  if i <= Length(Source) then rest:= copy(Source,i,Length(Source)-i+1);
end;

function XMLAnalysePubSysId(const publicId,
                                  systemId,
                                  notaName: wideString): wideString;
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
var
  SystemIdContent,PublicIdContent: wideString;
begin
  Result:= '';
  if not IsXmlName(notaName)
    then EConvertError.CreateFmt('%S is not a valid notaName value.',[notaName]);;
  if IsXMLSystemLiteral(concat(dQuote,systemId,dQuote))
    then SystemIdContent:= concat(dQuote,systemId,dQuote)
    else if IsXMLSystemLiteral(concat(sQuote,systemId,sQuote))
      then SystemIdContent:= concat(sQuote,systemId,sQuote)
      else EConvertError.CreateFmt('%S is not a valid systemId value.',[systemId]);;
  if IsXMLPubidLiteral(concat(dQuote,publicId,dQuote))
    then PublicIdContent:= concat(dQuote,publicId,dQuote)
    else if IsXMLPubidLiteral(concat(sQuote,publicId,sQuote))
      then PublicIdContent:= concat(sQuote,publicId,sQuote)
      else EConvertError.CreateFmt('%S is not a valid publicId value.',[publicId]);;
  if publicId = '' then begin
    if systemId = '' then begin
      Result:= concat(Result,wideString(' SYSTEM "" '));
    end else begin
      Result:= concat(Result,wideString(' SYSTEM '),SystemIdContent,wideString(' '));
    end;
  end else begin
    if systemId = '' then begin
      Result:= concat(Result,wideString(' PUBLIC '),PublicIdContent,wideString(' '));
    end else begin
      Result:= concat(Result,wideString(' PUBLIC '),PublicIdContent,wideString(' '),SystemIdContent,wideString(' '));
    end;
  end; {if ...}
  if notaName <> ''
   then Result:= concat(Result,wideString('NDATA '),notaName,wideString(' '));
end;

function XMLExtractPrefix(const qualifiedName: wideString): wideString;
var
  colonpos: integer;
  prefix,localpart: wideString;
begin
  prefix:= '';
  colonpos:= pos(':',qualifiedName);
  if colonpos = 0
    then localpart:= qualifiedName
    else begin
      prefix:= copy(qualifiedName,1,colonpos-1);
      localpart:= copy(qualifiedName,colonpos+1,length(qualifiedName)-colonpos);
      if not IsXmlPrefix(prefix)
        then raise EInvalid_Character_Err.create('Invalid character error.');
    end;
  if not IsXmlLocalPart(localpart)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  result:= prefix;
end;

function XMLExtractLocalName(const qualifiedName: wideString): wideString;
var
  colonpos: integer;
  prefix,localpart: wideString;
begin
  colonpos:= pos(':',qualifiedName);
  if colonpos = 0
    then localpart:= qualifiedName
    else begin
      prefix:= copy(qualifiedName,1,colonpos-1);
      localpart:= copy(qualifiedName,colonpos+1,length(qualifiedName)-colonpos);
      if not IsXmlPrefix(prefix)
        then raise EInvalid_Character_Err.create('Invalid character error.');
  end;
  if not IsXmlLocalPart(localpart)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  result:= localpart;
end;

function IsXmlChar(const S: WideChar): boolean;
begin
  Case Word(S) of
    $0009,$000A,$000D,$0020..$D7FF,$E000..$FFFD, // Unicode below $FFFF
    $D800..$DBFF, // High surrogate of Unicode character [$10000..$10FFFF]
    $DC00..$DFFF: // Low surrogate of Unicode character [$10000..$10FFFF]
    result:= true;
  else
    result:= false;
  end;
end;

function IsXmlWhiteSpace(const S: WideChar): boolean;
begin
  Case Word(S) of
    $0009,$000A,$000D,$0020:
    result:= true;
  else
    result:= false;
  end;
end;

function IsXmlLetter(const S: WideChar): boolean;
begin
  Result:= IsXmlIdeographic(S) or IsXmlBaseChar(S);
end;

function IsXmlBaseChar(const S: WideChar): boolean;
begin
  Case Word(S) of
    $0041..$005a,$0061..$007a,$00c0..$00d6,$00d8..$00f6,$00f8..$00ff,
    $0100..$0131,$0134..$013E,$0141..$0148,$014a..$017e,$0180..$01c3,
    $01cd..$01f0,$01f4..$01f5,$01fa..$0217,$0250..$02a8,$02bb..$02c1,
    $0386,$0388..$038a,$038c,$038e..$03a1,$03a3..$03ce,$03D0..$03D6,
    $03DA,$03DC,$03DE,$03E0,$03E2..$03F3,$0401..$040C,$040E..$044F,
    $0451..$045C,$045E..$0481,$0490..$04C4,$04C7..$04C8,$04CB..$04CC,
    $04D0..$04EB,$04EE..$04F5,$04F8..$04F9,$0531..$0556,$0559,
    $0561..$0586,$05D0..$05EA,$05F0..$05F2,$0621..$063A,$0641..$064A,
    $0671..$06B7,$06BA..$06BE,$06C0..$06CE,$06D0..$06D3,$06D5,
    $06E5..$06E6,$0905..$0939,$093D,$0958..$0961,$0985..$098C,
    $098F..$0990,$0993..$09A8,$09AA..$09B0,$09B2,$09B6..$09B9,
    $09DC..$09DD,$09DF..$09E1,$09F0..$09F1,$0A05..$0A0A,$0A0F..$0A10,
    $0A13..$0A28,$0A2A..$0A30,$0A32..$0A33,$0A35..$0A36,$0A38..$0A39,
    $0A59..$0A5C,$0A5E,$0A72..$0A74,$0A85..$0A8B,$0A8D,$0A8F..$0A91,
    $0A93..$0AA8,$0AAA..$0AB0,$0AB2..$0AB3,$0AB5..$0AB9,$0ABD,$0AE0,
    $0B05..$0B0C,$0B0F..$0B10,$0B13..$0B28,$0B2A..$0B30,$0B32..$0B33,
    $0B36..$0B39,$0B3D,$0B5C..$0B5D,$0B5F..$0B61,$0B85..$0B8A,
    $0B8E..$0B90,$0B92..$0B95,$0B99..$0B9A,$0B9C,$0B9E..$0B9F,
    $0BA3..$0BA4,$0BA8..$0BAA,$0BAE..$0BB5,$0BB7..$0BB9,$0C05..$0C0C,
    $0C0E..$0C10,$0C12..$0C28,$0C2A..$0C33,$0C35..$0C39,$0C60..$0C61,
    $0C85..$0C8C,$0C8E..$0C90,$0C92..$0CA8,$0CAA..$0CB3,$0CB5..$0CB9,
    $0CDE,$0CE0..$0CE1,$0D05..$0D0C,$0D0E..$0D10,$0D12..$0D28,
    $0D2A..$0D39,$0D60..$0D61,$0E01..$0E2E,$0E30,$0E32..$0E33,
    $0E40..$0E45,$0E81..$0E82,$0E84,$0E87..$0E88,$0E8A,$0E8D,
    $0E94..$0E97,$0E99..$0E9F,$0EA1..$0EA3,$0EA5,$0EA7,$0EAA..$0EAB,
    $0EAD..$0EAE,$0EB0,$0EB2..$0EB3,$0EBD,$0EC0..$0EC4,$0F40..$0F47,
    $0F49..$0F69,$10A0..$10C5,$10D0..$10F6,$1100,$1102..$1103,
    $1105..$1107,$1109,$110B..$110C,$110E..$1112,$113C,$113E,$1140,
    $114C,$114E,$1150,$1154..$1155,$1159,$115F..$1161,$1163,$1165,
    $1167,$1169,$116D..$116E,$1172..$1173,$1175,$119E,$11A8,$11AB,
    $11AE..$11AF,$11B7..$11B8,$11BA,$11BC..$11C2,$11EB,$11F0,$11F9,
    $1E00..$1E9B,$1EA0..$1EF9,$1F00..$1F15,$1F18..$1F1D,$1F20..$1F45,
    $1F48..$1F4D,$1F50..$1F57,$1F59,$1F5B,$1F5D,$1F5F..$1F7D,
    $1F80..$1FB4,$1FB6..$1FBC,$1FBE,$1FC2..$1FC4,$1FC6..$1FCC,
    $1FD0..$1FD3,$1FD6..$1FDB,$1FE0..$1FEC,$1FF2..$1FF4,$1FF6..$1FFC,
    $2126,$212A..$212B,$212E,$2180..$2182,$3041..$3094,$30A1..$30FA,
    $3105..$312C,$AC00..$d7a3:
    result:= true;
  else
    result:= false;
  end;
end;

function IsXmlIdeographic(const S: WideChar): boolean;
begin
  Case Word(S) of
    $4E00..$9FA5,$3007,$3021..$3029:
    result:= true;
  else
    result:= false;
  end;
end;

function IsXmlCombiningChar(const S: WideChar): boolean;
begin
  Case Word(S) of
    $0300..$0345,$0360..$0361,$0483..$0486,$0591..$05A1,$05A3..$05B9,
    $05BB..$05BD,$05BF,$05C1..$05C2,$05C4,$064B..$0652,$0670,
    $06D6..$06DC,$06DD..$06DF,$06E0..$06E4,$06E7..$06E8,$06EA..$06ED,
    $0901..$0903,$093C,$093E..$094C,$094D,$0951..$0954,$0962..$0963,
    $0981..$0983,$09BC,$09BE,$09BF,$09C0..$09C4,$09C7..$09C8,
    $09CB..$09CD,$09D7,$09E2..$09E3,$0A02,$0A3C,$0A3E,$0A3F,
    $0A40..$0A42,$0A47..$0A48,$0A4B..$0A4D,$0A70..$0A71,$0A81..$0A83,
    $0ABC,$0ABE..$0AC5,$0AC7..$0AC9,$0ACB..$0ACD,$0B01..$0B03,$0B3C,
    $0B3E..$0B43,$0B47..$0B48,$0B4B..$0B4D,$0B56..$0B57,$0B82..$0B83,
    $0BBE..$0BC2,$0BC6..$0BC8,$0BCA..$0BCD,$0BD7,$0C01..$0C03,
    $0C3E..$0C44,$0C46..$0C48,$0C4A..$0C4D,$0C55..$0C56,$0C82..$0C83,
    $0CBE..$0CC4,$0CC6..$0CC8,$0CCA..$0CCD,$0CD5..$0CD6,$0D02..$0D03,
    $0D3E..$0D43,$0D46..$0D48,$0D4A..$0D4D,$0D57,$0E31,$0E34..$0E3A,
    $0E47..$0E4E,$0EB1,$0EB4..$0EB9,$0EBB..$0EBC,$0EC8..$0ECD,
    $0F18..$0F19,$0F35,$0F37,$0F39,$0F3E,$0F3F,$0F71..$0F84,
    $0F86..$0F8B,$0F90..$0F95,$0F97,$0F99..$0FAD,$0FB1..$0FB7,$0FB9,
    $20D0..$20DC,$20E1,$302A..$302F,$3099,$309A:
    result:= true;
  else
    result:= false;
  end;
end;

function IsXmlDigit(const S: WideChar): boolean;
begin
  Case Word(S) of
    $0030..$0039,$0660..$0669,$06F0..$06F9,$0966..$096F,$09E6..$09EF,
    $0A66..$0A6F,$0AE6..$0AEF,$0B66..$0B6F,$0BE7..$0BEF,$0C66..$0C6F,
    $0CE6..$0CEF,$0D66..$0D6F,$0E50..$0E59,$0ED0..$0ED9,$0F20..$0F29:
    result:= true;
  else
    result:= false;
  end;
end;

function IsXmlExtender(const S: WideChar): boolean;
begin
  Case Word(S) of
    $00B7,$02D0,$02D1,$0387,$0640,$0E46,$0EC6,$3005,$3031..$3035,
    $309D..$309E,$30FC..$30FE:
    result:= true;
  else
    result:= false;
  end;
end;

function IsXmlNameChar(const S: WideChar): boolean;
begin
  if IsXmlLetter(S) or IsXmlDigit(S) or IsXmlCombiningChar(S)
    or IsXmlExtender(S) or (S='.') or (S='-') or (S='_') or (S=':')
    then Result:= true
    else Result:= false;
end;

function IsXmlPubidChar(const S: WideChar): boolean;
begin
  if (S=#$20) or (S=#$D) or (S=#$A) or
     ((S>='a') and (S<='z')) or
     ((S>='A') and (S<='Z')) or
     ((S>='0') and (S<='9')) or
     (S='-') or (S=#$27) or (S='(') or (S=')') or (S='+') or (S=',') or
     (S='.') or (S='/') or (S=':') or (S='=') or (S=WideChar('?')) or (S=';') or
     (S='!') or (S='*') or (S='#') or (S='@') or (S='$') or (S='_') or
     (S='%')
    then Result:= true
    else Result:= false;
end;

function IsXmlChars(const S: wideString): boolean;
var
  i,l,pl: integer;
  SChar: wideChar;
begin
  result:= true;
  i:= 0;
  l:= length(S);
  pl:= pred(l);
  while i < pl do begin
    inc(i);
    SChar:= S[i];
    if IsUtf16LowSurrogate(sChar) then begin
      result:= false;
      break;
    end;
    if IsUtf16HighSurrogate(SChar) then begin
      if i = l then begin
        result:= false;
        break;
      end;
      inc(i);
      SChar:= S[i];
      if not IsUtf16LowSurrogate(SChar) then begin
        result:= false;
        break;
      end;
    end;
    if not IsXmlChar(sChar) then begin
      result:= false;
      break;
    end;
  end; {while ...}
end;

function IsXmlS(const S: wideString): boolean;
var
  i: integer;
begin
  if Length(S) = 0 then begin Result:= false; exit; end;
  Result:= true;
  for i:= 1 to length(S) do
    if not IsXmlWhiteSpace((PWideChar(S)+i-1)^)
      then begin Result:= false; exit; end;
end;

function IsXmlName(const S: wideString): boolean;
var
  i: integer;
begin
  Result:= true;
  if Length(S) = 0 then begin Result:= false; exit; end;
  if not ( IsXmlLetter(PWideChar(S)^)
           or (PWideChar(S)^ = '_')
           or (PWideChar(S)^ = ':')   )
    then begin Result:= false; exit; end;
  for i:= 2 to length(S) do
    if not IsXmlNameChar((PWideChar(S)+i-1)^)
      then begin Result:= false; exit; end;
end;

function IsXmlNames(const S: wideString): boolean;
var
  i,j: integer;
  piece: wideString;
begin
  Result:= true;
  if Length(S) = 0 then begin Result:= false; exit; end;
  if IsXmlWhiteSpace(S[length(S)]) then begin Result:= false; exit; end;
  i:= 0;
  j:= 1;
  while i < length(S) do begin
    inc(i);
    if IsXmlWhiteSpace(S[i]) or (i = length(S)) then begin
      if i = length(S)
        then piece:= XmlTrunc(copy(S,j,i+1-j))
        else begin
          piece:= XmlTrunc(copy(S,j,i-j));
          j:= i+1;
          while IsXmlWhiteSpace(S[j]) do inc(j);
          i:= j;
        end;
      if not IsXmlName(piece) then begin Result:= false; exit; end;
    end; {if ...}
  end; {while ...}
end;

function IsXmlNmtoken(const S: wideString): boolean;
var
  i: integer;
begin
  Result:= true;
  if Length(S) = 0 then begin Result:= false; exit; end;
  for i:= 1 to length(S) do
    if not IsXmlNameChar((PWideChar(S)+i-1)^)
      then begin Result:= false; exit; end;
end;

function IsXmlNmtokens(const S: wideString): boolean;
var
  i,j: integer;
  piece: wideString;
begin
  Result:= true;
  if Length(S) = 0 then begin Result:= false; exit; end;
  if IsXmlWhiteSpace(S[length(S)]) then begin Result:= false; exit; end;
  i:= 0;
  j:= 1;
  while i < length(S) do begin
    inc(i);
    if IsXmlWhiteSpace(S[i]) or (i = length(S)) then begin
      if i = length(S)
        then piece:= XmlTrunc(copy(S,j,i+1-j))
        else begin
          piece:= XmlTrunc(copy(S,j,i-j));
          j:= i+1;
          while IsXmlWhiteSpace(S[j]) do inc(j);
          i:= j;
        end;
      if not IsXmlNmtoken(piece) then begin Result:= false; exit; end;
    end; {if ...}
  end; {while ...}
end;

function IsXmlCharRef(const S: wideString): boolean;
var
  i: integer;
  SChar: widechar;
begin
  Result:= true;
  if copy(S,length(S),1) <> ';' then begin result:= false; exit; end;
  if copy(S,1,3) = '&#x' then begin
    if Length(S) < 5 then begin Result:= false; exit; end;
    for i:= 4 to length(S)-1 do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if not ( (SChar >= '0') and (SChar <= '9') )
         and not ( (SChar >= 'a') and (SChar <= 'f') )
         and not ( (SChar >= 'A') and (SChar <= 'F') )
        then begin Result:= false; exit; end;
    end;
  end else begin
    if Length(S) < 4 then begin Result:= false; exit; end;
    if copy(S,1,2) <> '&#' then begin Result:= false; exit; end;
    for i:= 3 to length(S)-1 do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if not ( (SChar >= '0') and (SChar <= '9') )
        then begin Result:= false; exit; end;
    end;
  end;
end;

function IsXmlEntityRef(const S: wideString): boolean;
begin
  if pos('&',S) <> 1 then begin result:= false; exit; end;
  if copy(S,length(S),1) <> ';' then begin result:= false; exit; end;
  Result:= IsXmlName(copy(S,2,length(S)-2));
end;

function IsXmlPEReference(const S: wideString): boolean;
begin
  if pos('%',S) <> 1 then begin result:= false; exit; end;
  if copy(S,length(S),1) <> ';' then begin result:= false; exit; end;
  Result:= IsXmlName(copy(S,2,length(S)-2));
end;

function IsXmlReference(const S: wideString): boolean;
begin
  if IsXmlEntityRef(s) or IsXmlCharRef(s)
    then result:= true
    else result:= false;
end;

function IsXmlEntityValue(const S: wideString): boolean;
const
  sQuote: widechar  = #$0027;
  dQuote: widechar  = '"';
var
  i,j,indexpos: integer;
  SChar, SChar2, ForbittenQuote: widechar;
begin
  Result:= true;
  if Length(S) < 2 then begin Result:= false; exit; end;
  if (S[length(S)] = sQuote) and (S[1] = sQuote) {single quotes}
    then ForbittenQuote:= sQuote
    else if (S[length(S)] = dQuote) and (S[1] = dQuote) {double quotes}
      then ForbittenQuote:= dQuote
      else begin Result:= false; exit; end;

  i:= 2;
  while i < length(S) do begin
    SChar:= WideChar((PWideChar(S)+i-1)^);
    if IsUtf16LowSurrogate(sChar) then begin Result:= false; exit; end;
    if IsUtf16HighSurrogate(SChar) then begin
      if i+1 = length(s) then begin Result:= false; exit; end;
      inc(i);
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if not IsUtf16LowSurrogate(SChar) then begin Result:= false; exit; end;
    end;
    if not IsXmlChar(sChar) then begin Result:= false; exit; end;
    if SChar = ForbittenQuote then begin Result:= false; exit; end;
    if SChar = '%' then begin {PEReference?}
      indexpos:= -1;
      for j:= i+1 to length(S)-1 do begin
        SChar2:= WideChar((PWideChar(S)+j-1)^);
        if SChar2 = ';' then begin indexpos:= j; break; end;
      end;
      if indexpos = -1 then begin Result:= false; exit; end;
      if not IsXmlPEReference(copy(S,i,j-i+1)) then begin Result:= false; exit; end;
      i:= j;
    end;
    if SChar = '&' then begin {Reference?}
      indexpos:= -1;
      for j:= i+1 to length(S)-1 do begin
        SChar2:= WideChar((PWideChar(S)+j-1)^);
        if SChar2 = ';' then begin indexpos:= j; break; end;
      end;
      if indexpos = -1 then begin Result:= false; exit; end;
      if not IsXmlReference(copy(S,i,j-i+1)) then begin Result:= false; exit; end;
      i:= j;
    end;
    inc(i);
  end;
end;

function IsXmlAttValue(const S: wideString): boolean;
const
  sQuote: widechar  = #$0027;
  dQuote: widechar  = '"';
var
  i,j,indexpos: integer;
  SChar, SChar2, ForbittenQuote: widechar;
begin
  Result:= true;
  if Length(S) < 2 then begin Result:= false; exit; end;
  if (S[length(S)] = sQuote) and (S[1] = sQuote) {single quotes}
    then ForbittenQuote:= sQuote
    else if (S[length(S)] = dQuote) and (S[1] = dQuote) {double quotes}
      then ForbittenQuote:= dQuote
      else begin Result:= false; exit; end;

  i:= 2;
  while i < length(S) do begin
    SChar:= WideChar((PWideChar(S)+i-1)^);
    if IsUtf16LowSurrogate(sChar) then begin Result:= false; exit; end;
    if IsUtf16HighSurrogate(SChar) then begin
      if i+1 = length(s) then begin Result:= false; exit; end;
      inc(i);
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if not IsUtf16LowSurrogate(SChar) then begin Result:= false; exit; end;
    end;
    if not IsXmlChar(sChar) then begin Result:= false; exit; end;
    if SChar = ForbittenQuote then begin Result:= false; exit; end;
    if SChar = '<' then begin Result:= false; exit; end;
    if SChar = '&' then begin {Reference?}
      indexpos:= -1;
      for j:= i+1 to length(S)-1 do begin
        SChar2:= WideChar((PWideChar(S)+j-1)^);
        if SChar2 = ';' then begin indexpos:= j; break; end;
      end;
      if indexpos = -1 then begin Result:= false; exit; end;
      if not IsXmlReference(copy(S,i,j-i+1)) then begin Result:= false; exit; end;
      i:= j;
    end;
    inc(i);
  end;
end;

function IsXmlSystemLiteral(const S: wideString): boolean;
const
  sQuote: widechar  = #$0027;
  dQuote: widechar  = '"';
var
  i: integer;
  SChar, ForbittenQuote: widechar;
begin
  Result:= true;
  if Length(S) < 2 then begin Result:= false; exit; end;
  if (S[length(S)] = sQuote) and (S[1] = sQuote) {single quotes}
    then ForbittenQuote:= sQuote
    else if (S[length(S)] = dQuote) and (S[1] = dQuote) {double quotes}
      then ForbittenQuote:= dQuote
      else begin Result:= false; exit; end;

  i:= 1;
  while i < length(S)-1 do begin
    inc(i);
    SChar:= WideChar((PWideChar(S)+i-1)^);
    if IsUtf16LowSurrogate(sChar) then begin Result:= false; exit; end;
    if IsUtf16HighSurrogate(SChar) then begin
      if i+1 = length(s) then begin Result:= false; exit; end;
      inc(i);
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if not IsUtf16LowSurrogate(SChar) then begin Result:= false; exit; end;
    end;
    if not IsXmlChar(sChar) then begin Result:= false; exit; end;
    if SChar = ForbittenQuote then begin Result:= false; exit; end;
  end;
end;

function IsXmlPubidLiteral(const S: wideString): boolean;
const
  sQuote: widechar  = #$0027;
  dQuote: widechar  = '"';
var
  i: integer;
  SChar, ForbittenQuote: widechar;
begin
  Result:= true;
  if Length(S) < 2 then begin Result:= false; exit; end;
  if (S[length(S)] = sQuote) and (S[1] = sQuote) {single quotes}
    then ForbittenQuote:= sQuote
    else if (S[length(S)] = dQuote) and (S[1] = dQuote) {double quotes}
      then ForbittenQuote:= dQuote
      else begin Result:= false; exit; end;

  i:= 1;
  while i < length(S)-1 do begin
    inc(i);
    SChar:= WideChar((PWideChar(S)+i-1)^);
    if IsUtf16LowSurrogate(sChar) then begin Result:= false; exit; end;
    if IsUtf16HighSurrogate(SChar) then begin
      if i+1 = length(s) then begin Result:= false; exit; end;
      inc(i);
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if not IsUtf16LowSurrogate(SChar) then begin Result:= false; exit; end;
    end;
    if not IsXmlChar(sChar) then begin Result:= false; exit; end;
    if SChar = ForbittenQuote then begin Result:= false; exit; end;
    if not IsXmlPubidChar(SChar) then begin Result:= false; exit; end;
  end;
end;

function IsXmlComment(const S: wideString): boolean;
var
  i,lengthS: integer;
  SChar: wideChar;
  S2: wideString;
begin
  Result:= true;
  lengthS:= length(S);
  if lengthS < 7 then begin result:= false; exit; end;
  if copy(S,1,4) <> '<!--' then begin result:= false; exit; end;
  if copy(S,lengthS-2,3) <> '-->' then begin result:= false; exit; end;
  if lengthS = 7 then exit;  // Empty comment --> ok.
  SChar:= WideChar((PWideChar(S)+lengthS-4)^);
  if SChar = '-'
    then begin result:= false; exit; end;
  S2:= copy(S,5,lengthS-7);
  if pos('--',S2) > 0 then begin result:= false; exit; end;
  i:= 0;
  while i < pred(length(S2)) do begin
    inc(i);
    SChar:= S2[i];
    if IsUtf16LowSurrogate(sChar) then begin Result:= false; exit; end;
    if IsUtf16HighSurrogate(SChar) then begin
      if i = length(S2) then begin Result:= false; exit; end;
      inc(i);
      SChar:= S2[i];
      if not IsUtf16LowSurrogate(SChar) then begin Result:= false; exit; end;
    end;
    if not IsXmlChar(sChar) then begin Result:= false; exit; end;
  end;
end;

function IsXmlCData(const S: wideString): boolean;
var
  i: integer;
  SChar: wideChar;
begin
  Result:= true;
  if pos(']]>',S) > 0 then begin result:= false; exit; end;
  i:= 0;
  while i < length(S)-1 do begin
    inc(i);
    SChar:= S[i];
    if IsUtf16LowSurrogate(sChar) then begin Result:= false; exit; end;
    if IsUtf16HighSurrogate(SChar) then begin
      if i = length(s) then begin Result:= false; exit; end;
      inc(i);
      SChar:= S[i];
      if not IsUtf16LowSurrogate(SChar) then begin Result:= false; exit; end;
    end;
    if not IsXmlChar(sChar) then begin Result:= false; exit; end;
  end;
end;

function IsXmlCharData(const S: wideString): boolean;
var
  i: integer;
  SChar: wideChar;
begin
  Result:= true;
  if pos(']]>',S) > 0 then begin result:= false; exit; end;
  i:= 0;
  while i < length(S)-1 do begin
    inc(i);
    SChar:= S[i];
    if IsUtf16LowSurrogate(sChar) then begin Result:= false; exit; end;
    if IsUtf16HighSurrogate(SChar) then begin
      if i = length(s) then begin Result:= false; exit; end;
      inc(i);
      SChar:= S[i];
      if not IsUtf16LowSurrogate(SChar) then begin Result:= false; exit; end;
    end;
    if not IsXmlChar(sChar) then begin Result:= false; exit; end;
    if SChar = '<' then begin Result:= false; exit; end;
    if SChar = '&' then begin Result:= false; exit; end;
  end;
end;

function IsXmlPITarget(const S: wideString): boolean;
begin
  Result:= IsXmlName(S);
  if length(S) = 3 then
    if ((S[1] = 'X') or (S[1] = 'x')) and
       ((S[2] = 'M') or (S[2] = 'm')) and
       ((S[3] = 'L') or (S[3] = 'l'))
      then Result:= false;
end;

function IsXmlVersionNum(const S: wideString): boolean;
var
  SChar: wideChar;
  i: integer;
begin
  Result:= true;
  if Length(S) = 0 then begin Result:= false; exit; end;
  for i:=1 to length(S) do begin
    SChar:= S[i];
    if not ( ((SChar >= 'a') and (SChar <= 'z')) or
             ((SChar >= 'A') and (SChar <= 'Z')) or
             ((SChar >= '0') and (SChar <= '9')) or
             (SChar = '_') or (SChar = '.') or
             (SChar = ':') or (SChar = '-')  )
      then begin Result:= false; exit; end;
  end;
end;

function IsXmlEncName(const S: wideString): boolean;
var
  SChar: widechar;
  i: integer;
begin
  Result:= true;
  if Length(S) = 0 then begin Result:= false; exit; end;
  SChar:= S[1];
  if not ( ((SChar >= 'a') and (SChar <= 'z')) or
           ((SChar >= 'A') and (SChar <= 'Z')) )
    then Result:= false; exit;

  for i:=2 to length(S) do begin
    SChar:= S[i];
    if not ( ((SChar >= 'a') and (SChar <= 'z')) or
             ((SChar >= 'A') and (SChar <= 'Z')) or
             ((SChar >= '0') and (SChar <= '9')) or
             (SChar = '.') or (SChar = '_') or (SChar = '-')  )
      then Result:= false; exit;
  end;
end;

function IsXmlStringType(const S: wideString): boolean;
begin
  if S = 'CDATA'
    then Result:= true
    else Result:= false;
end;

function IsXmlTokenizedType(const S: wideString): boolean;
begin
  if (S='ID') or (S='IDREF') or (S='IDREFS') or (S='ENTITY') or
     (S='ENTITIES') or (S='NMTOKEN') or (S='NMTOKENS')
    then Result:= true
    else Result:= false;
end;

function IsXmlNCNameChar(const s: WideChar): boolean;
begin
  if IsXmlLetter(S) or IsXmlDigit(S) or IsXmlCombiningChar(S)
    or IsXmlExtender(S) or (S='.') or (S='-') or (S='_')
    then Result:= true
    else Result:= false;
end;

function IsXmlNCName(const S: wideString): boolean;
var
  i: integer;
begin
  Result:= true;
  if Length(S) = 0 then begin Result:= false; exit; end;
  if not ( IsXmlLetter(PWideChar(S)^)
           or (PWideChar(S)^ = '_')   )
    then begin Result:= false; exit; end;
  for i:= 2 to length(S) do
    if not IsXmlNCNameChar(S[i])
      then begin Result:= false; exit; end;
end;

function IsXmlDefaultAttName(const S: wideString): boolean;
begin
  if S = 'xmlns'
    then Result:= true
    else Result:= false;
end;

function IsXmlPrefixedAttName(const S: wideString): boolean;
var
  piece: wideString;
begin
  if copy(S,1,6) = 'xmlns:' then begin
    piece:= copy(S,7,length(S)-6);
    Result:= IsXmlNCName(piece);
  end else Result:= false;
end;

function IsXmlNSAttName(const S: wideString): boolean;
begin
  Result:= (IsXmlPrefixedAttName(S) or IsXmlDefaultAttName(S));
end;

function IsXmlLocalPart(const S: wideString): boolean;
begin
  Result:= IsXmlNCName(S);
end;

function IsXmlPrefix(const S: wideString): boolean;
begin
  Result:= IsXmlNCName(S);
end;

function IsXmlQName(const S: wideString): boolean;
var
  colonpos: integer;
  prefix,localpart: wideString;
begin
  colonpos:= pos(':',S);
  if colonpos = 0
    then result:= IsXmlLocalPart(S)
    else begin
      prefix:= copy(S,1,colonpos-1);
      localpart:= copy(S,colonpos+1,length(S)-colonpos);
      result:= IsXmlPrefix(prefix) and IsXmlLocalPart(localpart);
  end;
end;

function ResolveCharRefs(const S: wideString): wideString;
var
  i,j,indexpos: integer;
  SChar, SChar2: widechar;
  ref: wideString;
  content: TdomCustomStr;
begin
  Result:= '';
  content:= TdomCustomStr.create;
  try
    i:= 1;
    while i <= length(S) do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if IsUtf16LowSurrogate(sChar)
        then raise EConvertError.CreateFmt('%S must not start with a UTF-16 low surrogate.',[S]);
      if IsUtf16HighSurrogate(SChar) then begin
        if i+1 > length(s)
          then raise EConvertError.CreateFmt('%S must not end with a UTF-16 high surrogate.',[S]);
        inc(i);
        content.addWideChar(SChar);
        SChar:= WideChar((PWideChar(S)+i-1)^);
        if not IsUtf16LowSurrogate(SChar)
          then raise EConvertError.CreateFmt('%S contains an UTF-16 high surrogate without its corresponding low surrogate.',[S]);
      end;
      if not IsXmlChar(sChar)
        then raise EConvertError.CreateFmt('%S contains an invalid character.',[S]);
      if SChar = '&' then begin {Reference?}
        indexpos:= -1;
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = ';' then begin indexpos:= j; break; end;
        end;
        if indexpos = -1
          then raise EConvertError.CreateFmt('%S contains an ''&'' without a '';''.',[S]);
        ref:= copy(S,i,j-i+1);
        if IsXmlEntityRef(ref) then begin
          content.addWideString(ref);
        end else if IsXmlCharRef(ref) then begin
          content.addWideString(XmlCharRefToStr(ref));
        end else raise EConvertError.CreateFmt('%S contains an invalid reference.',[S]);
        i:= j;
      end else content.addWideChar(SChar);
      inc(i);
    end; {while ...}
    Result:= content.value;
  finally
    content.free;
  end;
end;

function XmlIntToCharRef(const value: integer): wideString;
begin
  Result:= concat('&#',intToStr(value),';');
end;

function XmlCharRefToInt(const S: wideString): integer;
var
  value: word;
begin
  if not IsXmlCharRef(S)
    then raise EConvertError.CreateFmt('%S is not a valid XmlCharRef value.',[S]);
  if S[3] = 'x'
    then Result:= StrToInt(concat('$',copy(S,4,length(S)-4))) // Hex
    else Result:= StrToInt(copy(S,3,length(S)-3));            // Dec
  if Result > $10FFFF
    then raise EConvertError.CreateFmt('%S is not a valid XmlCharRef value.',[S]);
  if Result < $10000 then begin
    value:= Result;
    if not IsXmlChar(WideChar(value))
      then raise EConvertError.CreateFmt('%S is not a valid XmlCharRef value.',[S]);
    case result of
      $D800..$DBFF, // Reserved for high surrogate of Unicode character [$10000..$10FFFF]
      $DC00..$DFFF: // Reserved for low surrogate of Unicode character [$10000..$10FFFF]
      raise EConvertError.CreateFmt('%S is not a valid XmlCharRef value.',[S]);
    end; {case ...}
  end; {if ...}
end;

function XmlCharRefToStr(const S: wideString): wideString;
var
  value: integer;
  smallValue: word;
begin
  value:= XmlCharRefToInt(S);
  if value < $10000 then begin
    smallValue:= value;
    Result:= wideString(WideChar(smallValue));
  end else
    Result:= concat(wideString(Utf16HighSurrogate(value)),
                    wideString(Utf16LowSurrogate(value)));
end;

function XmlStrToCharRef(const S: wideString): wideString;
var
  SChar,LowSur: widechar;
  i: integer;
begin
  Result:= '';
  i:= 0;
  while i < length(S)-1 do begin
    inc(i);
    SChar:= S[i];
    if not isXmlChar(SChar)
      then raise EConvertError.CreateFmt('String contains invalid character %S.',[S]);
    if isUtf16LowSurrogate(SChar)
      then raise EConvertError.CreateFmt('Low surrogate %S without high surrogate.',[S]);
    if IsUtf16HighSurrogate(SChar) then begin
      if i+1 = length(s)
        then raise EConvertError.CreateFmt('High surrogate %S without low surrogate at end of string.',[S]);
      inc(i);
      lowSur:= S[i];
      if not IsUtf16LowSurrogate(lowSur)
        then raise EConvertError.CreateFmt('High surrogate %S without low surrogate.',[S]);
      Result:= concat(result,XmlIntToCharRef(Utf16SurrogateToInt(SChar,lowSur)));
    end else begin
      Result:= concat(result,XmlIntToCharRef(ord(SChar)));
    end;
  end; {for ...}
end;

function Iso8859_1ToUTF16Char(const P: Char):WideChar;
begin
  result:= WideChar(ord(P));
end;

function Iso8859_2ToUTF16Char(const P: Char):WideChar;
begin
  case ord(p) of
    $a1: result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a2: result:= #$02d8;  // BREVE
    $a3: result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $a5: result:= #$0132;  // LATIN CAPITAL LETTER L WITH CARON
    $a6: result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $a9: result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $aa: result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $ab: result:= #$0164;  // LATIN CAPITAL LETTER T WITH CARON
    $ac: result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $ae: result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $af: result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $b1: result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $b2: result:= #$02db;  // OGONEK
    $b3: result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $b5: result:= #$013e;  // LATIN SMALL LETTER L WITH CARON
    $b6: result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $b7: result:= #$02c7;  // CARON
    $b9: result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $ba: result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $bb: result:= #$0165;  // LATIN SMALL LETTER T WITH CARON
    $bc: result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $bd: result:= #$02dd;  // DOUBLE ACUTE ACCENT
    $be: result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $bf: result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $c0: result:= #$0154;  // LATIN CAPITAL LETTER R WITH ACUTE
    $c3: result:= #$0102;  // LATIN CAPITAL LETTER A WITH BREVE
    $c5: result:= #$0139;  // LATIN CAPITAL LETTER L WITH ACUTE
    $c6: result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $c8: result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ca: result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $cc: result:= #$011a;  // LATIN CAPITAL LETTER E WITH CARON
    $cf: result:= #$010e;  // LATIN CAPITAL LETTER D WITH CARON
    $d0: result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $d1: result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $d2: result:= #$0147;  // LATIN CAPITAL LETTER N WITH CARON
    $d5: result:= #$0150;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $d8: result:= #$0158;  // LATIN CAPITAL LETTER R WITH CARON
    $d9: result:= #$016e;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $db: result:= #$0170;  // LATIN CAPITAL LETTER U WITH WITH DOUBLE ACUTE
    $de: result:= #$0162;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $e0: result:= #$0155;  // LATIN SMALL LETTER R WITH ACUTE
    $e3: result:= #$0103;  // LATIN SMALL LETTER A WITH BREVE
    $e5: result:= #$013a;  // LATIN SMALL LETTER L WITH ACUTE
    $e6: result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $e8: result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $ea: result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $ec: result:= #$011b;  // LATIN SMALL LETTER E WITH CARON
    $ef: result:= #$010f;  // LATIN SMALL LETTER D WITH CARON
    $f0: result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $f1: result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $f2: result:= #$0148;  // LATIN SMALL LETTER N WITH CARON
    $f5: result:= #$0151;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $f8: result:= #$0159;  // LATIN SMALL LETTER R WITH CARON
    $f9: result:= #$016f;  // LATIN SMALL LETTER U WITH RING ABOVE
    $fb: result:= #$0171;  // LATIN SMALL LETTER U WITH WITH DOUBLE ACUTE
    $fe: result:= #$0163;  // LATIN SMALL LETTER T WITH CEDILLA
    $ff: result:= #$02d9;  // DOT ABOVE
  else
    result:= WideChar(ord(P));
  end;
end;

function Iso8859_3ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $a1: result:= #$0126;  // LATIN CAPITAL LETTER H WITH STROKE
    $a2: result:= #$02d8;  // BREVE
    $a5: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence "%s"',[P]);
    $a6: result:= #$0124;  // LATIN CAPITAL LETTER H WITH CIRCUMFLEX
    $a9: result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $aa: result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $ab: result:= #$011e;  // LATIN CAPITAL LETTER G WITH BREVE
    $ac: result:= #$0134;  // LATIN CAPITAL LETTER J WITH CIRCUMFLEX
    $ae: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence "%s"',[P]);
    $af: result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT
    $b1: result:= #$0127;  // LATIN SMALL LETTER H WITH STROKE
    $b6: result:= #$0125;  // LATIN SMALL LETTER H WITH CIRCUMFLEX
    $b9: result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $ba: result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $bb: result:= #$011f;  // LATIN SMALL LETTER G WITH BREVE
    $bc: result:= #$0135;  // LATIN SMALL LETTER J WITH CIRCUMFLEX
    $be: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence "%s"',[P]);
    $bf: result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT
    $c3: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence "%s"',[P]);
    $c5: result:= #$010a;  // LATIN CAPITAL LETTER C WITH DOT ABOVE
    $c6: result:= #$0108;  // LATIN CAPITAL LETTER C WITH CIRCUMFLEX
    $d0: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence "%s"',[P]);
    $d5: result:= #$0120;  // LATIN CAPITAL LETTER G WITH DOT ABOVE
    $d8: result:= #$011c;  // LATIN CAPITAL LETTER G WITH CIRCUMFLEX
    $dd: result:= #$016c;  // LATIN CAPITAL LETTER U WITH BREVE
    $de: result:= #$015c;  // LATIN CAPITAL LETTER S WITH CIRCUMFLEX
    $e3: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence "%s"',[P]);
    $e5: result:= #$010b;  // LATIN SMALL LETTER C WITH DOT ABOVE
    $e6: result:= #$0109;  // LATIN SMALL LETTER C WITH CIRCUMFLEX
    $f0: raise EConvertError.CreateFmt('Invalid ISO-8859-3 sequence "%s"',[P]);
    $f5: result:= #$0121;  // LATIN SMALL LETTER G WITH DOT ABOVE
    $f8: result:= #$011d;  // LATIN SMALL LETTER G WITH CIRCUMFLEX
    $fd: result:= #$016d;  // LATIN SMALL LETTER U WITH BREVE
    $fe: result:= #$015d;  // LATIN SMALL LETTER S WITH CIRCUMFLEX
    $ff: result:= #$02d9;  // DOT ABOVE
  else
    result:= WideChar(ord(P));
  end;
end;

function Iso8859_4ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $a1: result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a2: result:= #$0138;  // LATIN SMALL LETTER KRA
    $a3: result:= #$0156;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $a5: result:= #$0128;  // LATIN CAPITAL LETTER I WITH TILDE
    $a6: result:= #$013b;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $a9: result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $aa: result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $ab: result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $ac: result:= #$0166;  // LATIN CAPITAL LETTER T WITH STROKE
    $ae: result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $b1: result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $b2: result:= #$02db;  // OGONEK
    $b3: result:= #$0157;  // LATIN SMALL LETTER R WITH CEDILLA
    $b5: result:= #$0129;  // LATIN SMALL LETTER I WITH TILDE
    $b6: result:= #$013c;  // LATIN SMALL LETTER L WITH CEDILLA
    $b7: result:= #$02c7;  // CARON
    $b9: result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $ba: result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $bb: result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $bc: result:= #$0167;  // LATIN SMALL LETTER T WITH STROKE
    $bd: result:= #$014a;  // LATIN CAPITAL LETTER ENG
    $be: result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $bf: result:= #$014b;  // LATIN SMALL LETTER ENG
    $c0: result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $c7: result:= #$012e;  // LATIN CAPITAL LETTER I WITH OGONEK
    $c8: result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ca: result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $cc: result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $cf: result:= #$012a;  // LATIN CAPITAL LETTER I WITH MACRON
    $d0: result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $d1: result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $d2: result:= #$014c;  // LATIN CAPITAL LETTER O WITH MACRON
    $d3: result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $d9: result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $dd: result:= #$0168;  // LATIN CAPITAL LETTER U WITH TILDE
    $de: result:= #$016a;  // LATIN CAPITAL LETTER U WITH MACRON
    $e0: result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $e7: result:= #$012f;  // LATIN SMALL LETTER I WITH OGONEK
    $e8: result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $ea: result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $ec: result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $ef: result:= #$012b;  // LATIN SMALL LETTER I WITH MACRON
    $f0: result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $f1: result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $f2: result:= #$014d;  // LATIN SMALL LETTER O WITH MACRON
    $f3: result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $f9: result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $fd: result:= #$0169;  // LATIN SMALL LETTER U WITH TILDE
    $fe: result:= #$016b;  // LATIN SMALL LETTER U WITH MACRON
    $ff: result:= #$02d9;  // DOT ABOVE
  else
    result:= WideChar(ord(P));
  end;
end;

function Iso8859_5ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $00..$a0,$ad:
      result:= WideChar(ord(P));
    $f0: result:= #$2116;  // NUMERO SIGN
    $fd: result:= #$00a7;  // SECTION SIGN
  else
    result:= WideChar(ord(P)+$0360);
  end;
end;

function Iso8859_6ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $00..$a0,$a4,$ad:
      result:= WideChar(ord(P));
    $ac,$bb,$bf,$c1..$da,$e0..$f2:
      result:= WideChar(ord(P)+$0580);
  else
    raise EConvertError.CreateFmt('Invalid ISO-8859-6 sequence "%s"',[P]);
  end;
end;

function Iso8859_7ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $00..$a0,$a6..$a9,$ab..$ad,$b0..$b3,$b7,$bb,$bd:
      result:= WideChar(ord(P));
    $a1: result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $a2: result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $af: result:= #$2015;  // HORIZONTAL BAR
    $d2,$ff: raise EConvertError.CreateFmt('Invalid ISO-8859-7 sequence "%s"',[P]);
  else
    result:= WideChar(ord(P)+$02d0);
  end;
end;

function Iso8859_8ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $00..$a0,$a2..$a9,$ab..$ae,$b0..$b9,$bb..$be:
      result:= WideChar(ord(P));
    $aa: result:= #$00d7;  // MULTIPLICATION SIGN
    $af: result:= #$203e;  // OVERLINE
    $ba: result:= #$00f7;  // DIVISION SIGN
    $df: result:= #$2017;  // DOUBLE LOW LINE
    $e0..$fa:
      result:= WideChar(ord(P)+$04e0);
  else
    raise EConvertError.CreateFmt('Invalid ISO-8859-8 sequence "%s"',[P]);
  end;
end;

function Iso8859_9ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $d0: result:= #$011e;  // LATIN CAPITAL LETTER G WITH BREVE
    $dd: result:= #$0130;  // LATIN CAPITAL LETTER I WITH DOT ABOVE
    $de: result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $f0: result:= #$011f;  // LATIN SMALL LETTER G WITH BREVE
    $fd: result:= #$0131;  // LATIN SMALL LETTER I WITH DOT ABOVE
    $fe: result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
  else
    result:= WideChar(ord(P));
  end;
end;

function Iso8859_10ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $a1: result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a2: result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $a3: result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $a4: result:= #$012a;  // LATIN CAPITAL LETTER I WITH MACRON
    $a5: result:= #$0128;  // LATIN CAPITAL LETTER I WITH TILDE
    $a6: result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $a8: result:= #$013b;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $a9: result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $aa: result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $ab: result:= #$0166;  // LATIN CAPITAL LETTER T WITH STROKE
    $ac: result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $ae: result:= #$016a;  // LATIN CAPITAL LETTER U WITH MACRON
    $af: result:= #$014a;  // LATIN CAPITAL LETTER ENG
    $b1: result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $b2: result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $b3: result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $b4: result:= #$012b;  // LATIN SMALL LETTER I WITH MACRON
    $b5: result:= #$0129;  // LATIN SMALL LETTER I WITH TILDE
    $b6: result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $b8: result:= #$013c;  // LATIN SMALL LETTER L WITH CEDILLA
    $b9: result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $ba: result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $bb: result:= #$0167;  // LATIN SMALL LETTER T WITH STROKE
    $bc: result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $bd: result:= #$2015;  // HORIZONTAL BAR
    $be: result:= #$016b;  // LATIN SMALL LETTER U WITH MACRON
    $bf: result:= #$014b;  // LATIN SMALL LETTER ENG
    $c0: result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $c7: result:= #$012e;  // LATIN CAPITAL LETTER I WITH OGONEK
    $c8: result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ca: result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $cc: result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $d1: result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $d2: result:= #$014c;  // LATIN CAPITAL LETTER O WITH MACRON
    $d7: result:= #$0168;  // LATIN CAPITAL LETTER U WITH TILDE
    $d9: result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $e0: result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $e7: result:= #$012f;  // LATIN SMALL LETTER I WITH OGONEK
    $e8: result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $ea: result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $ec: result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $f1: result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $f2: result:= #$014d;  // LATIN SMALL LETTER O WITH MACRON
    $f7: result:= #$0169;  // LATIN SMALL LETTER U WITH TILDE
    $f9: result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $ff: result:= #$0138;  // LATIN SMALL LETTER KRA
  else
    result:= WideChar(ord(P));
  end;
end;

function Iso8859_13ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $a1: result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $a5: result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $a8: result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $aa: result:= #$0156;  // LATIN CAPITAL LETTER R WITH CEDILLA
    $af: result:= #$00c6;  // LATIN CAPITAL LETTER AE
    $b4: result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $b8: result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $ba: result:= #$0157;  // LATIN SMALL LETTER R WITH CEDILLA
    $bf: result:= #$00e6;  // LATIN SMALL LETTER AE
    $c0: result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $c1: result:= #$012e;  // LATIN CAPITAL LETTER I WITH OGONEK
    $c2: result:= #$0100;  // LATIN CAPITAL LETTER A WITH MACRON
    $c3: result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $c6: result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $c7: result:= #$0112;  // LATIN CAPITAL LETTER E WITH MACRON
    $c8: result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $ca: result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $cb: result:= #$0116;  // LATIN CAPITAL LETTER E WITH DOT ABOVE
    $cc: result:= #$0122;  // LATIN CAPITAL LETTER G WITH CEDILLA
    $cd: result:= #$0136;  // LATIN CAPITAL LETTER K WITH CEDILLA
    $ce: result:= #$012a;  // LATIN CAPITAL LETTER I WITH MACRON
    $cf: result:= #$013b;  // LATIN CAPITAL LETTER L WITH CEDILLA
    $d0: result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $d1: result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $d2: result:= #$0145;  // LATIN CAPITAL LETTER N WITH CEDILLA
    $d4: result:= #$014c;  // LATIN CAPITAL LETTER O WITH MACRON
    $d8: result:= #$0172;  // LATIN CAPITAL LETTER U WITH OGONEK
    $d9: result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $da: result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $db: result:= #$016a;  // LATIN CAPITAL LETTER U WITH MACRON
    $dd: result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $de: result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $e0: result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $e1: result:= #$012f;  // LATIN SMALL LETTER I WITH OGONEK
    $e2: result:= #$0101;  // LATIN SMALL LETTER A WITH MACRON
    $e3: result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $e6: result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $e7: result:= #$0113;  // LATIN SMALL LETTER E WITH MACRON
    $e8: result:= #$010d;  // LATIN SMALL LETTER C WITH CARON
    $ea: result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $eb: result:= #$0117;  // LATIN SMALL LETTER E WITH DOT ABOVE
    $ec: result:= #$0123;  // LATIN SMALL LETTER G WITH CEDILLA
    $ed: result:= #$0137;  // LATIN SMALL LETTER K WITH CEDILLA
    $ee: result:= #$012b;  // LATIN SMALL LETTER I WITH MACRON
    $ef: result:= #$013c;  // LATIN SMALL LETTER L WITH CEDILLA
    $f0: result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $f1: result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $f2: result:= #$0146;  // LATIN SMALL LETTER N WITH CEDILLA
    $f4: result:= #$014d;  // LATIN SMALL LETTER O WITH MACRON
    $f8: result:= #$0173;  // LATIN SMALL LETTER U WITH OGONEK
    $f9: result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $fa: result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $fb: result:= #$016b;  // LATIN SMALL LETTER U WITH MACRON
    $fd: result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $fe: result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $ff: result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
  else
    result:= WideChar(ord(P));
  end;
end;

function Iso8859_14ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $a1: result:= #$1e02;  // LATIN CAPITAL LETTER B WITH DOT ABOVE
    $a2: result:= #$1e03;  // LATIN SMALL LETTER B WITH DOT ABOVE
    $a4: result:= #$010a;  // LATIN CAPITAL LETTER C WITH DOT ABOVE
    $a5: result:= #$010b;  // LATIN SMALL LETTER C WITH DOT ABOVE
    $a6: result:= #$1e0a;  // LATIN CAPITAL LETTER D WITH DOT ABOVE
    $a8: result:= #$1e80;  // LATIN CAPITAL LETTER W WITH GRAVE
    $aa: result:= #$1e82;  // LATIN CAPITAL LETTER W WITH ACUTE
    $ab: result:= #$1e0b;  // LATIN SMALL LETTER D WITH DOT ABOVE
    $ac: result:= #$1ef2;  // LATIN CAPITAL LETTER Y WITH GRAVE
    $af: result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $b0: result:= #$1e1e;  // LATIN CAPITAL LETTER F WITH DOT ABOVE
    $b1: result:= #$1e1f;  // LATIN SMALL LETTER F WITH DOT ABOVE
    $b2: result:= #$0120;  // LATIN CAPITAL LETTER G WITH DOT ABOVE
    $b3: result:= #$0121;  // LATIN SMALL LETTER G WITH DOT ABOVE
    $b4: result:= #$1e40;  // LATIN CAPITAL LETTER M WITH DOT ABOVE
    $b5: result:= #$1e41;  // LATIN SMALL LETTER M WITH DOT ABOVE
    $b7: result:= #$1e56;  // LATIN CAPITAL LETTER P WITH DOT ABOVE
    $b8: result:= #$1e81;  // LATIN SMALL LETTER W WITH GRAVE
    $b9: result:= #$1e57;  // LATIN SMALL LETTER P WITH DOT ABOVE
    $ba: result:= #$1e83;  // LATIN SMALL LETTER W WITH ACUTE
    $bb: result:= #$1e60;  // LATIN CAPITAL LETTER S WITH DOT ABOVE
    $bc: result:= #$1ef3;  // LATIN SMALL LETTER Y WITH GRAVE
    $bd: result:= #$1e84;  // LATIN CAPITAL LETTER W WITH DIAERESIS
    $be: result:= #$1e85;  // LATIN SMALL LETTER W WITH DIAERESIS
    $bf: result:= #$1e61;  // LATIN SMALL LETTER S WITH DOT ABOVE
    $d0: result:= #$0174;  // LATIN CAPITAL LETTER W WITH CIRCUMFLEX
    $d7: result:= #$1e6a;  // LATIN CAPITAL LETTER T WITH DOT ABOVE
    $de: result:= #$0176;  // LATIN CAPITAL LETTER Y WITH CIRCUMFLEX
    $f0: result:= #$0175;  // LATIN SMALL LETTER W WITH CIRCUMFLEX
    $f7: result:= #$1e6b;  // LATIN SMALL LETTER T WITH DOT ABOVE
    $fe: result:= #$0177;  // LATIN SMALL LETTER Y WITH CIRCUMFLEX
  else
    result:= WideChar(ord(P));
  end;
end;

function Iso8859_15ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $a4: result:= #$20ac;  // EURO SIGN
    $a6: result:= #$00a6;  // LATIN CAPITAL LETTER S WITH CARON
    $a8: result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $b4: result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $b8: result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $bc: result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $bd: result:= #$0153;  // LATIN SMALL LIGATURE OE
    $be: result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
  else
    result:= WideChar(ord(P));
  end;
end;

function KOI8_RToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $80: result:= #$2500;  // BOX DRAWINGS LIGHT HORIZONTAL
    $81: result:= #$2502;  // BOX DRAWINGS LIGHT VERTICAL
    $82: result:= #$250c;  // BOX DRAWINGS LIGHT DOWN AND RIGHT
    $83: result:= #$2510;  // BOX DRAWINGS LIGHT DOWN AND LEFT
    $84: result:= #$2514;  // BOX DRAWINGS LIGHT UP AND RIGHT
    $85: result:= #$2518;  // BOX DRAWINGS LIGHT UP AND LEFT
    $86: result:= #$251c;  // BOX DRAWINGS LIGHT VERTICAL AND RIGHT
    $87: result:= #$2524;  // BOX DRAWINGS LIGHT VERTICAL AND LEFT
    $88: result:= #$252c;  // BOX DRAWINGS LIGHT DOWN AND HORIZONTAL
    $89: result:= #$2534;  // BOX DRAWINGS LIGHT UP AND HORIZONTAL
    $8a: result:= #$253c;  // BOX DRAWINGS LIGHT VERTICAL AND HORIZONTAL
    $8b: result:= #$2580;  // UPPER HALF BLOCK
    $8c: result:= #$2584;  // LOWER HALF BLOCK
    $8d: result:= #$2588;  // FULL BLOCK
    $8e: result:= #$258c;  // LEFT HALF BLOCK
    $8f: result:= #$2590;  // RIGHT HALF BLOCK
    $90: result:= #$2591;  // LIGHT SHADE
    $91: result:= #$2592;  // MEDIUM SHADE
    $92: result:= #$2593;  // DARK SHADE
    $93: result:= #$2320;  // TOP HALF INTEGRAL
    $94: result:= #$25a0;  // BLACK SQUARE
    $95: result:= #$2219;  // BULLET OPERATOR
    $96: result:= #$221a;  // SQUARE ROOT
    $97: result:= #$2248;  // ALMOST EQUAL TO
    $98: result:= #$2264;  // LESS-THAN OR EQUAL TO
    $99: result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $9a: result:= #$00a0;  // NO-BREAK SPACE
    $9b: result:= #$2321;  // BOTTOM HALF INTEGRAL
    $9c: result:= #$00b0;  // DEGREE SIGN
    $9d: result:= #$00b2;  // SUPERSCRIPT TWO
    $9e: result:= #$00b7;  // MIDDLE DOT
    $9f: result:= #$00f7;  // DIVISION SIGN
    $a0: result:= #$2550;  // BOX DRAWINGS DOUBLE HORIZONTAL
    $a1: result:= #$2551;  // BOX DRAWINGS DOUBLE VERTICAL
    $a2: result:= #$2552;  // BOX DRAWINGS DOWN SINGLE AND RIGHT DOUBLE
    $a3: result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $a4: result:= #$2553;  // BOX DRAWINGS DOWN DOUBLE AND RIGHT SINGLE
    $a5: result:= #$2554;  // BOX DRAWINGS DOUBLE DOWN AND RIGHT
    $a6: result:= #$2555;  // BOX DRAWINGS DOWN SINGLE AND LEFT DOUBLE
    $a7: result:= #$2556;  // BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE
    $a8: result:= #$2557;  // BOX DRAWINGS DOUBLE DOWN AND LEFT
    $a9: result:= #$2558;  // BOX DRAWINGS UP SINGLE AND RIGHT DOUBLE
    $aa: result:= #$2559;  // BOX DRAWINGS UP DOUBLE AND RIGHT SINGLE
    $ab: result:= #$255a;  // BOX DRAWINGS DOUBLE UP AND RIGHT
    $ac: result:= #$255b;  // BOX DRAWINGS UP SINGLE AND LEFT DOUBLE
    $ad: result:= #$255c;  // BOX DRAWINGS UP DOUBLE AND LEFT SINGLE
    $ae: result:= #$255d;  // BOX DRAWINGS DOUBLE UP AND LEFT
    $af: result:= #$255e;  // BOX DRAWINGS VERTICAL SINGLE AND RIGHT DOUBLE
    $b0: result:= #$255f;  // BOX DRAWINGS VERTICAL DOUBLE AND RIGHT SINGLE
    $b1: result:= #$2560;  // BOX DRAWINGS DOUBLE VERTICAL AND RIGHT
    $b2: result:= #$2561;  // BOX DRAWINGS VERTICAL SINGLE AND LEFT DOUBLE
    $b3: result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $b4: result:= #$2562;  // BOX DRAWINGS VERTICAL DOUBLE AND LEFT SINGLE
    $b5: result:= #$2563;  // BOX DRAWINGS DOUBLE VERTICAL AND LEFT
    $b6: result:= #$2564;  // BOX DRAWINGS DOWN SINGLE AND HORIZONTAL DOUBLE
    $b7: result:= #$2565;  // BOX DRAWINGS DOWN DOUBLE AND HORIZONTAL SINGLE
    $b8: result:= #$2566;  // BOX DRAWINGS DOUBLE DOWN AND HORIZONTAL
    $b9: result:= #$2567;  // BOX DRAWINGS UP SINGLE AND HORIZONTAL DOUBLE
    $ba: result:= #$2568;  // BOX DRAWINGS UP DOUBLE AND HORIZONTAL SINGLE
    $bb: result:= #$2569;  // BOX DRAWINGS DOUBLE UP AND HORIZONTAL
    $bc: result:= #$256a;  // BOX DRAWINGS VERTICAL SINGLE AND HORIZONTAL DOUBLE
    $bd: result:= #$256b;  // BOX DRAWINGS VERTICAL DOUBLE AND HORIZONTAL SINGLE
    $be: result:= #$256c;  // BOX DRAWINGS DOUBLE VERTICAL AND HORIZONTAL
    $bf: result:= #$00a9;  // COPYRIGHT SIGN
    $c0: result:= #$044e;  // CYRILLIC SMALL LETTER YU
    $c1: result:= #$0430;  // CYRILLIC SMALL LETTER A
    $c2: result:= #$0431;  // CYRILLIC SMALL LETTER BE
    $c3: result:= #$0446;  // CYRILLIC SMALL LETTER TSE
    $c4: result:= #$0434;  // CYRILLIC SMALL LETTER DE
    $c5: result:= #$0435;  // CYRILLIC SMALL LETTER IE
    $c6: result:= #$0444;  // CYRILLIC SMALL LETTER EF
    $c7: result:= #$0433;  // CYRILLIC SMALL LETTER GHE
    $c8: result:= #$0445;  // CYRILLIC SMALL LETTER HA
    $c9: result:= #$0438;  // CYRILLIC SMALL LETTER I
    $ca: result:= #$0439;  // CYRILLIC SMALL LETTER SHORT I
    $cb: result:= #$043a;  // CYRILLIC SMALL LETTER KA
    $cc: result:= #$043b;  // CYRILLIC SMALL LETTER EL
    $cd: result:= #$043c;  // CYRILLIC SMALL LETTER EM
    $ce: result:= #$043d;  // CYRILLIC SMALL LETTER EN
    $cf: result:= #$043e;  // CYRILLIC SMALL LETTER O
    $d0: result:= #$043f;  // CYRILLIC SMALL LETTER PE
    $d1: result:= #$044f;  // CYRILLIC SMALL LETTER YA
    $d2: result:= #$0440;  // CYRILLIC SMALL LETTER ER
    $d3: result:= #$0441;  // CYRILLIC SMALL LETTER ES
    $d4: result:= #$0442;  // CYRILLIC SMALL LETTER TE
    $d5: result:= #$0443;  // CYRILLIC SMALL LETTER U
    $d6: result:= #$0436;  // CYRILLIC SMALL LETTER ZHE
    $d7: result:= #$0432;  // CYRILLIC SMALL LETTER VE
    $d8: result:= #$044c;  // CYRILLIC SMALL LETTER SOFT SIGN
    $d9: result:= #$044b;  // CYRILLIC SMALL LETTER YERU
    $da: result:= #$0437;  // CYRILLIC SMALL LETTER ZE
    $db: result:= #$0448;  // CYRILLIC SMALL LETTER SHA
    $dc: result:= #$044d;  // CYRILLIC SMALL LETTER E
    $dd: result:= #$0449;  // CYRILLIC SMALL LETTER SHCHA
    $de: result:= #$0447;  // CYRILLIC SMALL LETTER CHE
    $df: result:= #$044a;  // CYRILLIC SMALL LETTER HARD SIGN
    $e0: result:= #$042e;  // CYRILLIC CAPITAL LETTER YU
    $e1: result:= #$0410;  // CYRILLIC CAPITAL LETTER A
    $e2: result:= #$0411;  // CYRILLIC CAPITAL LETTER BE
    $e3: result:= #$0426;  // CYRILLIC CAPITAL LETTER TSE
    $e4: result:= #$0414;  // CYRILLIC CAPITAL LETTER DE
    $e5: result:= #$0415;  // CYRILLIC CAPITAL LETTER IE
    $e6: result:= #$0424;  // CYRILLIC CAPITAL LETTER EF
    $e7: result:= #$0413;  // CYRILLIC CAPITAL LETTER GHE
    $e8: result:= #$0425;  // CYRILLIC CAPITAL LETTER HA
    $e9: result:= #$0418;  // CYRILLIC CAPITAL LETTER I
    $ea: result:= #$0419;  // CYRILLIC CAPITAL LETTER SHORT I
    $eb: result:= #$041a;  // CYRILLIC CAPITAL LETTER KA
    $ec: result:= #$041b;  // CYRILLIC CAPITAL LETTER EL
    $ed: result:= #$041c;  // CYRILLIC CAPITAL LETTER EM
    $ee: result:= #$041d;  // CYRILLIC CAPITAL LETTER EN
    $ef: result:= #$041e;  // CYRILLIC CAPITAL LETTER O
    $f0: result:= #$041f;  // CYRILLIC CAPITAL LETTER PE
    $f1: result:= #$042f;  // CYRILLIC CAPITAL LETTER YA
    $f2: result:= #$0420;  // CYRILLIC CAPITAL LETTER ER
    $f3: result:= #$0421;  // CYRILLIC CAPITAL LETTER ES
    $f4: result:= #$0422;  // CYRILLIC CAPITAL LETTER TE
    $f5: result:= #$0423;  // CYRILLIC CAPITAL LETTER U
    $f6: result:= #$0416;  // CYRILLIC CAPITAL LETTER ZHE
    $f7: result:= #$0412;  // CYRILLIC CAPITAL LETTER VE
    $f8: result:= #$042c;  // CYRILLIC CAPITAL LETTER SOFT SIGN
    $f9: result:= #$042b;  // CYRILLIC CAPITAL LETTER YERU
    $fa: result:= #$0417;  // CYRILLIC CAPITAL LETTER ZE
    $fb: result:= #$0428;  // CYRILLIC CAPITAL LETTER SHA
    $fc: result:= #$042d;  // CYRILLIC CAPITAL LETTER E
    $fd: result:= #$0429;  // CYRILLIC CAPITAL LETTER SHCHA
    $fe: result:= #$0427;  // CYRILLIC CAPITAL LETTER CHE
    $ff: result:= #$042a;  // CYRILLIC CAPITAL LETTER HARD SIGN
  else
    result:= WideChar(ord(P));
  end;
end;

function cp10000_MacRomanToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $80: result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $81: result:= #$00c5;  // LATIN CAPITAL LETTER A WITH RING ABOVE
    $82: result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $83: result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $84: result:= #$00d1;  // LATIN CAPITAL LETTER N WITH TILDE
    $85: result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $86: result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $87: result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $88: result:= #$00e0;  // LATIN SMALL LETTER A WITH GRAVE
    $89: result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $8a: result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $8b: result:= #$00e3;  // LATIN SMALL LETTER A WITH TILDE
    $8c: result:= #$00e5;  // LATIN SMALL LETTER A WITH RING ABOVE
    $8d: result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $8e: result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $8f: result:= #$00e8;  // LATIN SMALL LETTER E WITH GRAVE
    $90: result:= #$00ea;  // LATIN SMALL LETTER E WITH CIRCUMFLEX
    $91: result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $92: result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $93: result:= #$00ec;  // LATIN SMALL LETTER I WITH GRAVE
    $94: result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $95: result:= #$00ef;  // LATIN SMALL LETTER I WITH DIAERESIS
    $96: result:= #$00f1;  // LATIN SMALL LETTER N WITH TILDE
    $97: result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $98: result:= #$00f2;  // LATIN SMALL LETTER O WITH GRAVE
    $99: result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $9a: result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $9b: result:= #$00f5;  // LATIN SMALL LETTER O WITH TILDE
    $9c: result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $9d: result:= #$00f9;  // LATIN SMALL LETTER U WITH GRAVE
    $9e: result:= #$00fb;  // LATIN SMALL LETTER U WITH CIRCUMFLEX
    $9f: result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $a0: result:= #$2020;  // DAGGER
    $a1: result:= #$00b0;  // DEGREE SIGN
    $a4: result:= #$00a7;  // SECTION SIGN
    $a5: result:= #$2022;  // BULLET
    $a6: result:= #$00b6;  // PILCROW SIGN
    $a7: result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $a8: result:= #$00ae;  // REGISTERED SIGN
    $aa: result:= #$2122;  // TRADE MARK SIGN
    $ab: result:= #$00b4;  // ACUTE ACCENT
    $ac: result:= #$00a8;  // DIAERESIS
    $ad: result:= #$2260;  // NOT EQUAL TO
    $ae: result:= #$00c6;  // LATIN CAPITAL LIGATURE AE
    $af: result:= #$00d8;  // LATIN CAPITAL LETTER O WITH STROKE
    $b0: result:= #$221e;  // INFINITY
    $b2: result:= #$2264;  // LESS-THAN OR EQUAL TO
    $b3: result:= #$2265;  // GREATER-THAN OR EQUAL TO
    $b4: result:= #$00a5;  // YEN SIGN
    $b6: result:= #$2202;  // PARTIAL DIFFERENTIAL
    $b7: result:= #$2211;  // N-ARY SUMMATION
    $b8: result:= #$220f;  // N-ARY PRODUCT
    $b9: result:= #$03c0;  // GREEK SMALL LETTER PI
    $ba: result:= #$222b;  // INTEGRAL
    $bb: result:= #$00aa;  // FEMININE ORDINAL INDICATOR
    $bc: result:= #$00ba;  // MASCULINE ORDINAL INDICATOR
    $bd: result:= #$2126;  // OHM SIGN
    $be: result:= #$00e6;  // LATIN SMALL LIGATURE AE
    $bf: result:= #$00f8;  // LATIN SMALL LETTER O WITH STROKE
    $c0: result:= #$00bf;  // INVERTED QUESTION MARK
    $c1: result:= #$00a1;  // INVERTED EXCLAMATION MARK
    $c2: result:= #$00ac;  // NOT SIGN
    $c3: result:= #$221a;  // SQUARE ROOT
    $c4: result:= #$0192;  // LATIN SMALL LETTER F WITH HOOK
    $c5: result:= #$2248;  // ALMOST EQUAL TO
    $c6: result:= #$2206;  // INCREMENT
    $c7: result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $c8: result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $c9: result:= #$2026;  // HORIZONTAL ELLIPSIS
    $ca: result:= #$00a0;  // NO-BREAK SPACE
    $cb: result:= #$00c0;  // LATIN CAPITAL LETTER A WITH GRAVE
    $cc: result:= #$00c3;  // LATIN CAPITAL LETTER A WITH TILDE
    $cd: result:= #$00d5;  // LATIN CAPITAL LETTER O WITH TILDE
    $ce: result:= #$0152;  // LATIN CAPITAL LIGATURE OE
    $cf: result:= #$0153;  // LATIN SMALL LIGATURE OE
    $d0: result:= #$2013;  // EN DASH
    $d1: result:= #$2014;  // EM DASH
    $d2: result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $d3: result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $d4: result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $d5: result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $d6: result:= #$00f7;  // DIVISION SIGN
    $d7: result:= #$25ca;  // LOZENGE
    $d8: result:= #$00ff;  // LATIN SMALL LETTER Y WITH DIAERESIS
    $d9: result:= #$0178;  // LATIN CAPITAL LETTER Y WITH DIAERESIS
    $da: result:= #$2044;  // FRACTION SLASH
    $db: result:= #$00a4;  // CURRENCY SIGN
    $dc: result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $dd: result:= #$203a;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $de: result:= #$fb01;  // LATIN SMALL LIGATURE FI
    $df: result:= #$fb02;  // LATIN SMALL LIGATURE FL
    $e0: result:= #$2021;  // DOUBLE DAGGER
    $e1: result:= #$00b7;  // MIDDLE DOT
    $e2: result:= #$201a;  // SINGLE LOW-9 QUOTATION MARK
    $e3: result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $e4: result:= #$2030;  // PER MILLE SIGN
    $e5: result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $e6: result:= #$00ca;  // LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    $e7: result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $e8: result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $e9: result:= #$00c8;  // LATIN CAPITAL LETTER E WITH GRAVE
    $ea: result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $eb: result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $ec: result:= #$00cf;  // LATIN CAPITAL LETTER I WITH DIAERESIS
    $ed: result:= #$00cc;  // LATIN CAPITAL LETTER I WITH GRAVE
    $ee: result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $ef: result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $f0: raise EConvertError.CreateFmt('Invalid cp10000_MacRoman sequence "%s"',[P]);
    $f1: result:= #$00d2;  // LATIN CAPITAL LETTER O WITH GRAVE
    $f2: result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $f3: result:= #$00db;  // LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    $f4: result:= #$00d9;  // LATIN CAPITAL LETTER U WITH GRAVE
    $f5: result:= #$0131;  // LATIN SMALL LETTER DOTLESS I
    $f6: result:= #$02c6;  // MODIFIER LETTER CIRCUMFLEX ACCENT
    $f7: result:= #$02dc;  // SMALL TILDE
    $f8: result:= #$00af;  // MACRON
    $f9: result:= #$02d8;  // BREVE
    $fa: result:= #$02d9;  // DOT ABOVE
    $fb: result:= #$02da;  // RING ABOVE
    $fc: result:= #$00b8;  // CEDILLA
    $fd: result:= #$02dd;  // DOUBLE ACUTE ACCENT
    $fe: result:= #$02db;  // OGONEK
    $ff: result:= #$02c7;  // CARON
  else
    result:= WideChar(ord(P));
  end;
end;

function cp1250ToUTF16Char(const P: Char):WideChar;
// This function was provided by Miloslav Sk�cel
const
  sInvalidWindows1250Sequence = 'Invalid Windows-1250 sequence "%s"';
begin
  case ord(p) of
    // NOT USED
    $80,$81,$83,$88,$90,$98:
      raise EConvertError.CreateFmt(sInvalidWindows1250Sequence,[P]);
    $82: Result:= #$201a;  // SINGLE LOW-9 QUOTATION MARK
    $84: Result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $85: Result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: Result:= #$2020;  // DAGGER
    $87: Result:= #$2021;  // DOUBLE DAGGER
    $89: Result:= #$2030;  // PER MILLE SIGN
    $8a: Result:= #$0160;  // LATIN CAPITAL LETTER S WITH CARON
    $8b: Result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8c: Result:= #$015a;  // LATIN CAPITAL LETTER S WITH ACUTE
    $8d: Result:= #$0164;  // LATIN CAPITAL LETTER T WITH CARON
    $8e: Result:= #$017d;  // LATIN CAPITAL LETTER Z WITH CARON
    $8f: Result:= #$0179;  // LATIN CAPITAL LETTER Z WITH ACUTE
    $91: Result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: Result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: Result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $94: Result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $95: Result:= #$2022;  // BULLET
    $96: Result:= #$2013;  // EN-DASH
    $97: Result:= #$2014;  // EM-DASH
    $99: Result:= #$2122;  // TRADE MARK SIGN
    $9a: Result:= #$0161;  // LATIN SMALL LETTER S WITH CARON
    $9b: Result:= #$203a;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9c: Result:= #$015b;  // LATIN SMALL LETTER S WITH ACUTE
    $9d: Result:= #$0165;  // LATIN SMALL LETTER T WITH CARON
    $9e: Result:= #$017e;  // LATIN SMALL LETTER Z WITH CARON
    $9f: Result:= #$017a;  // LATIN SMALL LETTER Z WITH ACUTE
    $a0: Result:= #$00a0;  // NO-BREAK SPACE
    $a1: Result:= #$02c7;  // CARON
    $a2: Result:= #$02d8;  // BREVE
    $a3: Result:= #$0141;  // LATIN CAPITAL LETTER L WITH STROKE
    $a4: Result:= #$00a4;  // CURRENCY SIGN
    $a5: Result:= #$0104;  // LATIN CAPITAL LETTER A WITH OGONEK
    $a6: Result:= #$00a6;  // BROKEN BAR
    $a7: Result:= #$00a7;  // SECTION SIGN
    $a8: Result:= #$00a8;  // DIAERESIS
    $a9: Result:= #$00a9;  // COPYRIGHT SIGN
    $aa: Result:= #$015e;  // LATIN CAPITAL LETTER S WITH CEDILLA
    $ab: Result:= #$00ab;  // LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    $ac: Result:= #$00ac;  // NOT SIGN
    $ad: Result:= #$00ad;  // SOFT HYPHEN
    $ae: Result:= #$00ae;  // REGISTERED SIGN
    $af: Result:= #$017b;  // LATIN CAPITAL LETTER Z WITH DOT ABOVE
    $b0: Result:= #$00b0;  // DEGREE SIGN
    $b1: Result:= #$00b1;  // PLUS-MINUS SIGN
    $b2: Result:= #$02db;  // OGONEK
    $b3: Result:= #$0142;  // LATIN SMALL LETTER L WITH STROKE
    $b4: Result:= #$00b4;  // ACUTE ACCENT
    $b5: Result:= #$00b5;  // MIKRO SIGN
    $b6: Result:= #$00b6;  // PILCROW SIGN
    $b7: Result:= #$00b7;  // MIDDLE DOT
    $b8: Result:= #$00b8;  // CEDILLA
    $b9: Result:= #$0105;  // LATIN SMALL LETTER A WITH OGONEK
    $ba: Result:= #$015f;  // LATIN SMALL LETTER S WITH CEDILLA
    $bb: Result:= #$00bb;  // RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    $bc: Result:= #$013d;  // LATIN CAPITAL LETTER L WITH CARON
    $bd: Result:= #$02dd;  // DOUBLE ACUTE ACCENT
    $be: Result:= #$013e;  // LATIN SMALL LETTER L WITH CARON
    $bf: Result:= #$017c;  // LATIN SMALL LETTER Z WITH DOT ABOVE
    $c0: Result:= #$0154;  // LATIN CAPITAL LETTER R WITH ACUTE
    $c1: Result:= #$00c1;  // LATIN CAPITAL LETTER A WITH ACUTE
    $c2: Result:= #$00c2;  // LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    $c3: Result:= #$0102;  // LATIN CAPITAL LETTER A WITH BREVE
    $c4: Result:= #$00c4;  // LATIN CAPITAL LETTER A WITH DIAERESIS
    $c5: Result:= #$0139;  // LATIN CAPITAL LETTER L WITH ACUTE
    $c6: Result:= #$0106;  // LATIN CAPITAL LETTER C WITH ACUTE
    $c7: Result:= #$00c7;  // LATIN CAPITAL LETTER C WITH CEDILLA
    $c8: Result:= #$010c;  // LATIN CAPITAL LETTER C WITH CARON
    $c9: Result:= #$00c9;  // LATIN CAPITAL LETTER E WITH ACUTE
    $ca: Result:= #$0118;  // LATIN CAPITAL LETTER E WITH OGONEK
    $cb: Result:= #$00cb;  // LATIN CAPITAL LETTER E WITH DIAERESIS
    $cc: Result:= #$011a;  // LATIN CAPITAL LETTER E WITH CARON
    $cd: Result:= #$00cd;  // LATIN CAPITAL LETTER I WITH ACUTE
    $ce: Result:= #$00ce;  // LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    $cf: Result:= #$010e;  // LATIN CAPITAL LETTER D WITH CARON
    $d0: Result:= #$0110;  // LATIN CAPITAL LETTER D WITH STROKE
    $d1: Result:= #$0143;  // LATIN CAPITAL LETTER N WITH ACUTE
    $d2: Result:= #$0147;  // LATIN CAPITAL LETTER N WITH CARON
    $d3: Result:= #$00d3;  // LATIN CAPITAL LETTER O WITH ACUTE
    $d4: Result:= #$00d4;  // LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    $d5: Result:= #$0150;  // LATIN CAPITAL LETTER O WITH DOUBLE ACUTE
    $d6: Result:= #$00d6;  // LATIN CAPITAL LETTER O WITH DIAERESIS
    $d7: Result:= #$00d7;  // MULTIPLICATION SIGN
    $d8: Result:= #$0158;  // LATIN CAPITAL LETTER R WITH CARON
    $d9: Result:= #$016e;  // LATIN CAPITAL LETTER U WITH RING ABOVE
    $da: Result:= #$00da;  // LATIN CAPITAL LETTER U WITH ACUTE
    $db: Result:= #$0170;  // LATIN CAPITAL LETTER U WITH WITH DOUBLE ACUTE
    $dc: Result:= #$00dc;  // LATIN CAPITAL LETTER U WITH DIAERESIS
    $dd: Result:= #$00dd;  // LATIN CAPITAL LETTER Y WITH ACUTE
    $de: Result:= #$0162;  // LATIN CAPITAL LETTER T WITH CEDILLA
    $df: Result:= #$00df;  // LATIN SMALL LETTER SHARP S
    $e0: Result:= #$0155;  // LATIN SMALL LETTER R WITH ACUTE
    $e1: Result:= #$00e1;  // LATIN SMALL LETTER A WITH ACUTE
    $e2: Result:= #$00e2;  // LATIN SMALL LETTER A WITH CIRCUMFLEX
    $e3: Result:= #$0103;  // LATIN SMALL LETTER A WITH BREVE
    $e4: Result:= #$00e4;  // LATIN SMALL LETTER A WITH DIAERESIS
    $e5: Result:= #$013a;  // LATIN SMALL LETTER L WITH ACUTE
    $e6: Result:= #$0107;  // LATIN SMALL LETTER C WITH ACUTE
    $e7: Result:= #$00e7;  // LATIN SMALL LETTER C WITH CEDILLA
    $e8: Result:= #$010d;  // LATIN SMALL LETTER C WITH CARON 100D
    $e9: Result:= #$00e9;  // LATIN SMALL LETTER E WITH ACUTE
    $ea: Result:= #$0119;  // LATIN SMALL LETTER E WITH OGONEK
    $eb: Result:= #$00eb;  // LATIN SMALL LETTER E WITH DIAERESIS
    $ec: Result:= #$011b;  // LATIN SMALL LETTER E WITH CARON
    $ed: Result:= #$00ed;  // LATIN SMALL LETTER I WITH ACUTE
    $ee: Result:= #$00ee;  // LATIN SMALL LETTER I WITH CIRCUMFLEX
    $ef: Result:= #$010f;  // LATIN SMALL LETTER D WITH CARON
    $f0: Result:= #$0111;  // LATIN SMALL LETTER D WITH STROKE
    $f1: Result:= #$0144;  // LATIN SMALL LETTER N WITH ACUTE
    $f2: Result:= #$0148;  // LATIN SMALL LETTER N WITH CARON
    $f3: Result:= #$00f3;  // LATIN SMALL LETTER O WITH ACUTE
    $f4: Result:= #$00f4;  // LATIN SMALL LETTER O WITH CIRCUMFLEX
    $f5: Result:= #$0151;  // LATIN SMALL LETTER O WITH DOUBLE ACUTE
    $f6: Result:= #$00f6;  // LATIN SMALL LETTER O WITH DIAERESIS
    $f7: Result:= #$00f7;  // DIVISION SIGN
    $f8: Result:= #$0159;  // LATIN SMALL LETTER R WITH CARON
    $f9: Result:= #$016f;  // LATIN SMALL LETTER U WITH RING ABOVE
    $fa: Result:= #$00fa;  // LATIN SMALL LETTER U WITH ACUTE
    $fb: Result:= #$0171;  // LATIN SMALL LETTER U WITH WITH DOUBLE ACUTE
    $fc: Result:= #$00fc;  // LATIN SMALL LETTER U WITH DIAERESIS
    $fd: Result:= #$00fd;  // LATIN SMALL LETTER Y WITH ACUTE
    $fe: Result:= #$0163;  // LATIN SMALL LETTER T WITH CEDILLA
    $ff: Result:= #$02d9;  // DOT ABOVE
  else
    Result:= WideChar(ord(P));
  end;
end;

function cp1251ToUTF16Char(const P: Char):WideChar;
begin
  case ord(P) of
    $80: result:= #$0402;  // CYRILLIC CAPITAL LETTER DJE
    $81: result:= #$0403;  // CYRILLIC CAPITAL LETTER GJE
    $82: result:= #$201a;  // SINGLE LOW-9 QUOTATION MARK
    $83: result:= #$0453;  // CYRILLIC SMALL LETTER GJE
    $84: result:= #$201e;  // DOUBLE LOW-9 QUOTATION MARK
    $85: result:= #$2026;  // HORIZONTAL ELLIPSIS
    $86: result:= #$2020;  // DAGGER
    $87: result:= #$2021;  // DOUBLE DAGGER
    $88: result:= #$20ac;  // EURO SIGN
    $89: result:= #$2030;  // PER MILLE SIGN
    $8a: result:= #$0409;  // CYRILLIC CAPITAL LETTER LJE
    $8b: result:= #$2039;  // SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8c: result:= #$040a;  // CYRILLIC CAPITAL LETTER NJE
    $8d: result:= #$040c;  // CYRILLIC CAPITAL LETTER KJE
    $8e: result:= #$040b;  // CYRILLIC CAPITAL LETTER TSHE
    $8f: result:= #$040f;  // CYRILLIC CAPITAL LETTER DZHE
    $90: result:= #$0452;  // CYRILLIC SMALL LETTER DJE
    $91: result:= #$2018;  // LEFT SINGLE QUOTATION MARK
    $92: result:= #$2019;  // RIGHT SINGLE QUOTATION MARK
    $93: result:= #$201c;  // LEFT DOUBLE QUOTATION MARK
    $94: result:= #$201d;  // RIGHT DOUBLE QUOTATION MARK
    $95: result:= #$2022;  // BULLET
    $96: result:= #$2013;  // EN DASH
    $97: result:= #$2014;  // EM DASH
    $98: raise EConvertError.CreateFmt('Invalid cp1251 sequence "%s"',[P]);
    $99: result:= #$2122;  // TRADE MARK SIGN
    $9a: result:= #$0459;  // CYRILLIC SMALL LETTER LJE
    $9b: result:= #$203a;  // SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9c: result:= #$045a;  // CYRILLIC SMALL LETTER NJE
    $9d: result:= #$045c;  // CYRILLIC SMALL LETTER KJE
    $9e: result:= #$045b;  // CYRILLIC SMALL LETTER TSHE
    $9f: result:= #$045f;  // CYRILLIC SMALL LETTER DZHE
    $a0: result:= #$00a0;  // NO-BREAK SPACE
    $a1: result:= #$040e;  // CYRILLIC CAPITAL LETTER SHORT U
    $a2: result:= #$045e;  // CYRILLIC SMALL LETTER SHORT U
    $a3: result:= #$0408;  // CYRILLIC CAPITAL LETTER JE
    $a4: result:= #$00a4;  // CURRENCY SIGN
    $a5: result:= #$0490;  // CYRILLIC CAPITAL LETTER GHE WITH UPTURN
    $a8: result:= #$0401;  // CYRILLIC CAPITAL LETTER IO
    $aa: result:= #$0404;  // CYRILLIC CAPITAL LETTER UKRAINIAN IE
    $af: result:= #$0407;  // CYRILLIC CAPITAL LETTER YI
    $b2: result:= #$0406;  // CYRILLIC CAPITAL LETTER BYELORUSSIAN-UKRAINIAN I
    $b3: result:= #$0456;  // CYRILLIC SMALL LETTER BYELORUSSIAN-UKRAINIAN I
    $b4: result:= #$0491;  // CYRILLIC SMALL LETTER GHE WITH UPTURN
    $b8: result:= #$0451;  // CYRILLIC SMALL LETTER IO
    $b9: result:= #$2116;  // NUMERO SIGN
    $ba: result:= #$0454;  // CYRILLIC SMALL LETTER UKRAINIAN IE
    $bc: result:= #$0458;  // CYRILLIC SMALL LETTER JE
    $bd: result:= #$0405;  // CYRILLIC CAPITAL LETTER DZE
    $be: result:= #$0455;  // CYRILLIC SMALL LETTER DZE
    $bf: result:= #$0457;  // CYRILLIC SMALL LETTER YI
    $c0..$ff:
      result:= WideChar(ord(P)+$350);
  else
    result:= WideChar(ord(P));
  end;
end;

function cp1252ToUTF16Char(const P: Char):WideChar;
// Provided by Olaf L�sken.
// Info taken from
// ftp://ftp.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP1252.TXT
const
  sInvalidWindows1252Sequence = 'Invalid Windows-1252 sequence "%s"';
begin
  case ord(p) of
    $80 : result:= #$20AC; //EUROSIGN
    $81 : raise EConvertError.CreateFmt(sInvalidWindows1252Sequence,[P]);
    $82 : result:= #$201A; //SINGLE LOW-9 QUOTATION MARK
    $83 : result:= #$0192; //ATIN SMALL LETTER F WITH HOOK
    $84 : result:= #$201E; //DOUBLE LOW-9 QUOTATION MARK
    $85 : result:= #$2026; //HORIZONTAL ELLIPSIS
    $86 : result:= #$2020; //DAGGER
    $87 : result:= #$2021; //DOUBLE DAGGER
    $88 : result:= #$02C6; //MODIFIER LETTER CIRCUMFLEX ACCENT
    $89 : result:= #$2030; //PER MILLE SIGN
    $8A : result:= #$0160; //LATIN CAPITAL LETTER S WITH CARON
    $8B : result:= #$2039; //SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    $8C : result:= #$0152; //LATIN CAPITAL LIGATURE OE
    $8D : raise EConvertError.CreateFmt(sInvalidWindows1252Sequence,[P]);
    $8E : result:= #$017D; //LATIN CAPITAL LETTER Z WITH CARON
    $8F : raise EConvertError.CreateFmt(sInvalidWindows1252Sequence,[P]);
    $90 : raise EConvertError.CreateFmt(sInvalidWindows1252Sequence,[P]);
    $91 : result:= #$2018; //LEFT SINGLE QUOTATION MARK
    $92 : result:= #$2019; //RIGHT SINGLE QUOTATION MARK
    $93 : result:= #$201C; //LEFT DOUBLE QUOTATION MARK
    $94 : result:= #$201D; //RIGHT DOUBLE QUOTATION MARK
    $95 : result:= #$2022; //BULLET
    $96 : result:= #$2013; //EN DASH
    $97 : result:= #$2014; //EM DASH
    $98 : result:= #$02DC; //SMALL TILDE
    $99 : result:= #$2122; //TRADE MARK SIGN
    $9A : result:= #$0161; //LATIN SMALL LETTER S WITH CARON
    $9B : result:= #$203A; //SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    $9C : result:= #$0153; //LATIN SMALL LIGATURE OE
    $9D : raise EConvertError.CreateFmt(sInvalidWindows1252Sequence,[P]);
    $9E : result:= #$017E; //LATIN SMALL LETTER Z WITH CARON
    $9F : result:= #$0178; //LATIN CAPITAL LETTER Y WITH D
  else
    Result:= WideChar(ord(P));
  end;
end;

function Iso8859_1ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-1 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_1ToUTF16Char(s[i]);
end;

function Iso8859_2ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-2 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_2ToUTF16Char(s[i]);
end;

function Iso8859_3ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-3 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_3ToUTF16Char(s[i]);
end;

function Iso8859_4ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-4 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_4ToUTF16Char(s[i]);
end;

function Iso8859_5ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-5 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_5ToUTF16Char(s[i]);
end;

function Iso8859_6ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-6 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_6ToUTF16Char(s[i]);
end;

function Iso8859_7ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-7 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_7ToUTF16Char(s[i]);
end;

function Iso8859_8ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-8 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_8ToUTF16Char(s[i]);
end;

function Iso8859_9ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-9 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_9ToUTF16Char(s[i]);
end;

function Iso8859_10ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-10 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_10ToUTF16Char(s[i]);
end;

function Iso8859_13ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-13 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_13ToUTF16Char(s[i]);
end;

function Iso8859_14ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-14 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_14ToUTF16Char(s[i]);
end;

function Iso8859_15ToUTF16Str(const s: string):wideString;
// Converts an ISO-8859-15 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=Iso8859_15ToUTF16Char(s[i]);
end;

function KOI8_RToUTF16Str(const s: string):wideString;
// Converts an KOI8-R string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=KOI8_RToUTF16Char(s[i]);
end;

function cp10000_MacRomanToUTF16Str(const s: string):wideString;
// Converts an cp10000_MacRoman string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=cp10000_MacRomanToUTF16Char(s[i]);
end;

function cp1250ToUTF16Str(const s: string):wideString;
// Converts an cp1250 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=cp1250ToUTF16Char(s[i]);
end;

function cp1251ToUTF16Str(const s: string):wideString;
// Converts an cp1251 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=cp1251ToUTF16Char(s[i]);
end;

function cp1252ToUTF16Str(const s: string):wideString;
// Converts an cp1252 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) are done.
var
  i,j: integer;
begin
  j:= length(s);
  setLength(Result,j);
  for i:= 1 to j do
    Result[i]:=cp1252ToUTF16Char(s[i]);
end;

function UTF8ToUTF16BEStr(const s: string): wideString;
// Converts an UTF-8 string into an UTF-16 wideString.
// No special conversions (e.g. on line breaks) and
// no XML-char checking are done.
// - This function was provided by Ernst van der Pols -
// - and slightly modified by Dieter K�hler -
const
  MaxCode: array[1..6] of integer = ($7F,$7FF,$FFFF,$1FFFFF,$3FFFFFF,$7FFFFFFF);
var
  i, j, CharSize, mask, ucs4: integer;
  c, first: char;
begin
  setLength(Result,Length(s)+1); // assume no or little above-ASCII-chars
  j:=0;                          // keep track of actual length
  i:=0;
  while i<length(s) do
  begin
    Inc(i); c:=s[i];
    if ord(c)>=$80 then         // UTF-8 sequence
    begin
      CharSize:=1;
      first:=c; mask:=$40; ucs4:=ord(c);
      if (ord(c) and $C0<>$C0) then
        raise EConvertError.CreateFmt('Invalid UTF-8 sequence %2.2X',[ord(c)]);
      while (mask and ord(first)<>0) do
      begin
        // read next character of stream
        if i=length(s) then
          raise EConvertError.CreateFmt('Aborted UTF-8 sequence "%s"',[Copy(s,i-CharSize,CharSize)]);
        Inc(i); c:=s[i];
        if (ord(c) and $C0<>$80) then
          raise EConvertError.CreateFmt('Invalid UTF-8 sequence $%2.2X',[ord(c)]);
        ucs4:=(ucs4 shl 6) or (ord(c) and $3F); // add bits to result
        Inc(CharSize);  // increase sequence length
        mask:=mask shr 1;    // adjust mask
      end;
      if (CharSize>6) then   // no 0 bit in sequence header 'first'
        raise EConvertError.CreateFmt('Invalid UTF-8 sequence "%s"',[Copy(s,i-CharSize,CharSize)]);
      ucs4:=ucs4 and MaxCode[CharSize]; // dispose of header bits
      // check for invalid sequence as suggested by RFC2279
      if ((CharSize>1) and (ucs4<=MaxCode[CharSize-1])) then
        raise EConvertError.CreateFmt('Invalid UTF-8 encoding "%s"',[Copy(s,i-CharSize,CharSize)]);
      // convert non-ASCII UCS-4 to UTF-16 if possible
      case ucs4 of
      $00000080..$0000D7FF,$0000E000..$0000FFFD:
        begin
          Inc(j); Result[j]:=WideChar(ord(c));
        end;
      $0000D800..$0000DFFF,$0000FFFE,$0000FFFF:
        raise EConvertError.CreateFmt('Invalid UCS-4 character $%8.8X',[ucs4]);
      $00010000..$0010FFFF:
        begin
          // add high surrogate to content as if it was processed earlier
          Inc(j); Result[j]:=Utf16HighSurrogate(ucs4);  // assign high surrogate
          Inc(j); Result[j]:=Utf16LowSurrogate(ucs4);   // assign low surrogate
        end;
      else // out of UTF-16 range
        raise EConvertError.CreateFmt('Cannot convert $%8.8X to UTF-16',[ucs4]);
      end;
    end
    else        // ASCII char
    begin
      Inc(j); Result[j]:=WideChar(ord(c));
    end;
  end;
  setLength(Result,j); // set to correct length
end;

function UTF16BEToUTF8Str(const ws: wideString;
                          const expandLF: boolean): string;
var
  StringStr: TStringStream;
  UTF16To8: TUTF16BEToUTF8Stream;
begin
  StringStr := TStringStream.create('');
  try
    UTF16To8 := TUTF16BEToUTF8Stream.create(StringStr);
    try
      UTF16To8.ExpandLF := expandLF;
      UTF16To8.WriteBuffer(pointer(ws)^, Length(ws) shl 1);
    finally
      UTF16To8.Free;
    end;
    Result := StringStr.DataString;
  finally
    StringStr.Free;
  end;
end;

function Utf16HighSurrogate(const value: integer): WideChar;
var
  value2: word;
begin
  value2:= ($D7C0 + ( value shr 10 ));
  Result:= WideChar(value2);
end;

function Utf16LowSurrogate(const value: integer): WideChar;
var
  value2: word;
begin
  value2:= ($DC00 XOR (value AND $3FF));
  Result:= WideChar(value2);
end;

function Utf16SurrogateToInt(const highSurrogate, lowSurrogate: WideChar): integer;
begin
  Result:=  ( (word(highSurrogate) -  $D7C0) shl 10 )
          + (  word(lowSurrogate) XOR $DC00  );
end;

function IsUtf16HighSurrogate(const S: WideChar): boolean;
begin
  Case Word(S) of
    $D800..$DBFF: result:= true;
  else
    result:= false;
  end;
end;

function IsUtf16LowSurrogate(const S: WideChar): boolean;
begin
  Case Word(S) of
    $DC00..$DFFF: result:= true;
  else
    result:= false;
  end;
end;

procedure writeWideString(stream: TStream; const XMLStrg: wideString);
begin
  stream.WriteBuffer(pointer(XMLStrg)^, Length(XMLStrg) shl 1);
end;

procedure writeWideChars(stream: TStream; const XMLChars: array of WideChar);
begin
  stream.WriteBuffer(XMLChars, SizeOf(XMLChars));
end;

procedure writeWideStrings(stream: TStream; const XMLStrgs: array of wideString);
var
  Indx: longint;
begin
for Indx := 0 to High(XMLStrgs) do
  stream.WriteBuffer(pointer(XMLStrgs[Indx])^, Length(XMLStrgs[Indx]) shl
1);
end;

// October 16, 2001 - Borland Change - Added iconv_openW function
{$IFDEF LINUX}

function iconv_openW(ToCode: WideString; FromCode: WideString): iconv_t;
var s1, s2 : string;
begin
  s1 := ToCode;
  s2 := FromCode;
  Result := iconv_open(PChar(s1), PChar(s2));
end;

{$ENDIF}



// +++++++++++++++++++++++++ TdomNameValueList +++++++++++++++++++++++++
constructor TdomNameValueList.create;
begin
  inherited create;
  FNames:= TStringList.create;
  FValues:= TStringList.create;
end;

destructor TdomNameValueList.destroy;
begin
  FNames.free;
  FValues.free;
  inherited destroy;
end;

function TdomNameValueList.getLength: integer;
begin
  result:= FNames.Count;
end;

function TdomNameValueList.getCapacity: integer;
begin
  result:= FNames.Capacity;
end;

function TdomNameValueList.getNames(index: integer): wideString;
begin
  result:= FNames[index];
end;

function TdomNameValueList.getValues(index: integer): wideString;
begin
  result:= FValues[index];
end;

procedure TdomNameValueList.setCapacity(const value: integer);
begin
  FNames.Capacity:= value;
  FValues.Capacity:= value;
end;

function TdomNameValueList.add(const name,
                                     value: wideString): integer;
begin
  result:= FNames.Add(name);
  FValues.Add(value);
end;

procedure TdomNameValueList.clear;
begin
  FNames.clear;
  FValues.clear;
end;

procedure TdomNameValueList.delete(const item: integer);
begin
  FNames.delete(item);
  FValues.delete(item);
end;

procedure TdomNameValueList.exchange(const index1,
                                           index2: integer);
begin
  FNames.exchange(index1,index2);
  FValues.exchange(index1,index2);
end;

function TdomNameValueList.indexOf(const name,
                                         value: wideString): integer;
var
  i: integer;
begin
  result:= -1;
  for i:= 0 to pred(FNames.count) do begin
    if FNames[i] = name then
      if FValues[i] = value then begin
        result:= i;
        exit;
      end;
  end;
end;

function TdomNameValueList.indexOfName(const name: wideString): integer;
begin
  result:= FNames.IndexOf(name);
end;

procedure TdomNameValueList.insert(const index: integer;
                                   const name,
                                         value: wideString);
begin
  FNames.insert(index,name);
  FValues.insert(index,value);
end;



//++++++++++++++++++++++++++ TdomCustomStr +++++++++++++++++++++++++++++
constructor TdomCustomStr.create;
begin
  inherited create;
  reset;
end;

function TdomCustomStr.getWideChars(indx: integer): wideChar;
begin
  result:= FContent[indx];
end;

procedure TdomCustomStr.setWideChars(indx: integer;
                                     ch: wideChar);
begin
  FContent[indx]:= ch;
end;

procedure TdomCustomStr.addWideChar(const Ch: wideChar);
begin
  if FActualLen = FCapacity then begin  // Grow
    FCapacity:= FCapacity + FCapacity div 4;
    setLength(FContent,FCapacity);
  end;
  Inc(FActualLen);
  FContent[FActualLen]:= Ch;
end;

procedure TdomCustomStr.addWideString(const s: wideString);
var
  i,l: integer;
begin
  l:= system.length(s);
  while FActualLen+l > FCapacity do begin  // Grow
    FCapacity:= FCapacity + FCapacity div 4;
    setLength(Fcontent,FCapacity);
  end;
  Inc(FActualLen,l);
  for i:= 1 to l do
    FContent[FActualLen-l+i]:= WideChar(s[i]);
end;

function  TdomCustomStr.endsWith(const s: wideString): boolean;
var
  i,offset,sLength: integer;
begin
  sLength:= system.length(s);
  offset:= FActualLen-sLength;
  if (offset < 0) or (sLength = 0)
    then begin result:= false; exit; end;
  i:= 1;
  repeat
    result := FContent[i+offset] = s[i];
    Inc(i);
  until (not result) or (i > sLength);
end;

function  TdomCustomStr.isEqual(const s: wideString): boolean;
var
  i,sLength: integer;
begin
  sLength:= system.length(s);
  if FActualLen <> sLength
    then begin result:= false; exit; end;
  if sLength = 0
    then begin result:= true; exit; end;
  i:= 1;
  repeat
    result := FContent[i] = s[i];
    Inc(i);
  until (not result) or (i > sLength);
end;

procedure TdomCustomStr.reset;
begin
  FCapacity:= 64;
  setLength(FContent,FCapacity);
  FActualLen:= 0;
end;

function  TdomCustomStr.startsWith(const s: wideString): boolean;
var
  i,sLength: integer;
begin
  sLength:= system.length(s);
  if (FActualLen < sLength) or (sLength = 0)
    then begin result:= false; exit; end;
  i:= 1;
  repeat
    result := FContent[i] = s[i];
    Inc(i);
  until (not result) or (i > sLength);
end;

function TdomCustomStr.value: wideString;
begin
  Result:= Copy(FContent,1,FActualLen);
end;



// +++++++++++++++++++++++ TdomWideStringStream +++++++++++++++++++++++
//                     - Provided by Karl Waclawek -
// This is a stream interface for widestrings.
// Purpose: avoid excessive memory re-allocations that occur with
//          wideStrings because they are not reference counted.
//  Note: when the dataString property is accesses, the complete
//        wideString will be copied out.

constructor TdomWideStringStream.CreateFromString(const aString: wideString);
begin
  inherited create;
  setSize(Length(aString) shl 1);
  Move(pointer(aString)^, FDataStringP^, FSize);
end;

destructor TdomWideStringStream.destroy;
begin
  FreeMem(FDataStringP);
  inherited destroy;
end;

function TdomWideStringStream.GetDataString: wideString;
begin
  setLength(Result, StringLength);
  Move(FDataStringP^, pointer(Result)^, FSize);
end;

function TdomWideStringStream.Read(var Buffer; Count: longint): longint;
begin
  Result := FSize - FPosition;
  if Result > Count then Result := Count;
  Move((FDataStringP + FPosition)^, Buffer, Result);
  Inc(FPosition, Result);
end;

function TdomWideStringStream.Write(const Buffer; Count: longint): longint;
var
  NewPos: longint;
begin
  Result := Count;
  NewPos := FPosition + Result;
  if NewPos > FSize
    then setSize(((NewPos + 1) shr 1) shl 1); //next larger even value
  Move(Buffer, (FDataStringP + FPosition)^, Result);
  FPosition := NewPos;
end;

function TdomWideStringStream.Seek(Offset: longint; Origin: Word): longint;
begin
  case Origin of
    soFromBeginning: FPosition := Offset;
    soFromCurrent: FPosition := FPosition + Offset;
    soFromEnd: FPosition := FSize - Offset;
  end;
  if FPosition > FSize then FPosition := FSize
  else if FPosition < 0 then FPosition := 0;
  Result := FPosition;
end;

function TdomWideStringStream.ReadString(Count: longint): wideString;
// Reads Count WideChars from stream and returns them as wideString.
var
  Len: longint;
begin
  if Odd(FPosition) then raise EReadError.create(SCannotReadOddPos);
  Len := (FSize - FPosition) shr 1;
  if Len > Count then Len := Count;
  setLength(Result, Len);
  Read(pointer(Result)^, Len shl 1);
end;

procedure TdomWideStringStream.WriteString(const aString: wideString);
// Writes aString into stream, starting at StringPosition, overwriting
// existing characters and extending the stream if necessary.
begin
  if Odd(FPosition) then raise EWriteError.create(SCannotWriteOddPos);
  Write(pointer(aString)^, Length(aString) shl 1);
end;

procedure TdomWideStringStream.SetCapacity(NewCapacity: longint);
// sets stream capacity in bytes.
begin
  if NewCapacity < FSize then raise EStreamError.create(SCapacityLessSize);
  ReallocMem(FDataStringP, NewCapacity);
  FCapacity := NewCapacity;
end;

procedure TdomWideStringStream.SetSize(NewSize: longint);
// sets stream size in bytes.
var
  Delta: longint;
begin
  if Odd(NewSize) then raise EStreamError.create(SOddSizeInvalid);
  if NewSize > Capacity then begin
    Delta := NewSize shr 2;
    if Delta < 8 then Delta := 8;
    setCapacity(((NewSize + Delta) shr 2) shl 2); //make it a multiple of 4
  end else
    if NewSize < 0 then raise EStreamError.create(SNegativeSizeInvalid);
  FSize := NewSize;
  if FPosition > FSize then FPosition := FSize;
end;

procedure TdomWideStringStream.SetStringPosition(value: longint);
// sets string position in terms of WideChars.
begin
  Position := (value - 1) shl 1;
end;

function TdomWideStringStream.GetStringPosition: longint;
// ets string position in terms of WideChars.
begin
  if Odd(Position) then raise EStreamError.create(SOddPosInvalid);
  Result := (Position shr 1) + 1;
end;

procedure TdomWideStringStream.SetStringLength(value: longint);
// sets string length in terms of WideChars.
begin
  setSize(value shl 1);
end;

function TdomWideStringStream.GetStringLength: longint;
// gets string length in terms of WideChars.
begin
  Result := FSize shr 1;
end;



// +++++++++++++++++++++++++ TConversionStream +++++++++++++++++++++++++
//                     - Provided by Karl Waclawek -
// This is an input/output stream for other streams.
// Purpose: transform data as they are written to or read from a target
//          stream.
constructor TConversionStream.create(Target: TStream);
begin
  if Target = nil then raise EConversionStream.create(STargetNil);
  inherited create;
  FTarget := Target;
end;

destructor TConversionStream.destroy;
begin
  FreeMem(FConvertBufP);
  inherited destroy;
end;

function TConversionStream.Seek(Offset: longint; Origin: Word): longint;
begin
  Result := 0;  // Seek makes no sense here
end;

function TConversionStream.ConvertReadBuffer(const Buffer; Count: longint): longint;
// Performs the actual conversion of the data in Buffer (read buffer);
// the result of the conversion must be written to ConvertBufB }
begin
  Result := 0; //do nothing, override in descendants
end;

function TConversionStream.ConvertWriteBuffer(const Buffer; Count: longint): longint;
// Performs the actual conversion of the data in Buffer (write buffer);
// the result of the conversion must be written to ConvertBufB }
begin
  Result := 0; //do nothing, override in descendants
end;

function TConversionStream.Read(var Buffer; Count: longint): longint;
// Reads Count bytes from target stream into Buffer;
// converts those bytes and stores the result in ConvertBufP;
// ConvertCount indicates the amount of bytes converted.
begin
  Result := Target.Read(Buffer, Count);
  FConvertCount := ConvertReadBuffer(Buffer, Result);
end;

function TConversionStream.Write(const Buffer; Count: longint): longint;
// Converts Count bytes from Buffer into ConvertBufP;
// ConvertCount indicates the amount of bytes converted;
// if not all converted bytes could be written to the target stream,
// then this returns the negative of the number of bytes actually written.
begin
  Result := Count;
  FConvertCount := ConvertWriteBuffer(Buffer, Result);
  Count := Target.Write(FConvertBufP^, FConvertCount);
  //if not all converted data could be written, return the negative
  //count of the data actually written. This avoids having Result
  //being the same as Count by coincidence
  if Count <> FConvertCount then Result := -Count;
end;

procedure TConversionStream.FreeConvertBuffer;
begin
  ReallocMem(FConvertBufP, 0);
  FConvertBufSize := 0;
end;

procedure TConversionStream.SetConvertBufSize(NewSize: Integer);
begin
  ReallocMem(FConvertBufP, NewSize);
  FConvertBufSize := NewSize;
end;


// ++++++++++++++++++++++++++ TUTF16BEToUTF8Stream +++++++++++++++++++++++
function TUTF16BEToUTF8Stream.ConvertWriteBuffer(const Buffer;
                                                       Count: Integer): longint;
// Converts an UTF-16BE stream into an UTF-8 encoded stream
// (and expands LF to CR+LF if its protected expandLF property
// is 'true').
//  - This function was provided by Ernst van der Pols -
//  - expandLF parameter added by Dieter K�hler -
//  - converted for stream processing by Karl Waclawek -
type
  TWideCharBuf = array[0..(MaxInt shr 1) - 1] of WideChar;
var
  InIndx, OutIndx: longint;
  Wc: WideChar;
  InBuf: TWideCharBuf absolute Buffer;

  procedure IncBufSize(BufSize: longint);
    var
      Delta: longint;
    begin
    Inc(BufSize);
    Delta := BufSize shr 2;
    if Delta < 8 then Delta := 8;
    BufSize := ((BufSize + Delta) shr 2) shl 2; //make it multiple of 4
    setConvertBufSize(BufSize);
    end;

  procedure UCS4CodeToUTF8String(Code: longint);
    const
      MaxCode: array[0..5] of longint = ($7F,$7FF,$FFFF,$1FFFFF,$3FFFFFF,$7FFFFFFF);
      FirstByte: array[0..5] of Byte = (0,$C0,$E0,$F0,$F8,$FC);
    var
      Mo, Indx, StartIndx: longint;
    begin
    Mo := 0;			// get number of bytes
    while ((Code > MaxCode[Mo]) and (Mo < 5)) do Inc(Mo);
    StartIndx := OutIndx;
    OutIndx := StartIndx + Mo;
    if OutIndx >= ConvertBufSize then IncBufSize(OutIndx);
    for Indx := OutIndx downto StartIndx + 1 do	// fill bytes from rear end
      begin
      PChar(FConvertBufP)[Indx] := Char($80 or (Code and $3F));
      Code := Code shr 6;
      end;
    PChar(FConvertBufP)[StartIndx] := Char(FirstByte[Mo] or Code); // fill first byte
    end;

begin
  Result := 0;
  if Count = 0 then Exit;
  if Odd(Count) then raise EConversionStream.create(SOddSizeInvalid);
  Count := Count shr 1;  //for initial size, assume all low ASCII chars
  if Count > ConvertBufSize then setConvertBufSize(Count);
  OutIndx := -1;	// keep track of end position
  InIndx := 0;
  if InBuf[0] = #$feff then Inc(InIndx);  // Test for BOM

  while InIndx < Count do begin
    Wc := InBuf[InIndx];
    case Word(Wc) of
      $0020..$007F,$0009,$000D:	// plain ASCII
        begin
        Inc(OutIndx);
        if OutIndx >= ConvertBufSize then IncBufSize(OutIndx);
        PChar(FConvertBufP)[OutIndx]:= Char(Wc);
        end;
      $000A:	// LF --> CR+LF
        if ExpandLF then
          begin
          Inc(OutIndx, 2);
          if OutIndx >= ConvertBufSize then IncBufSize(OutIndx);
          PChar(FConvertBufP)[OutIndx - 1] := Chr(13);
          PChar(FConvertBufP)[OutIndx] := Chr(10);
          end
        else
          begin
          Inc(OutIndx);
          if OutIndx >= ConvertBufSize then IncBufSize(OutIndx);
          PChar(FConvertBufP)[OutIndx] := Chr(10);
          end;
      $D800..$DBFF:	// high surrogate
        begin
        Inc(InIndx);
        if (InIndx < (Count - 1)) and (Word(InBuf[InIndx]) >= $DC00)
          and (Word(InBuf[InIndx]) <= $DFFF) then
          begin
          Inc(OutIndx);
          UCS4CodeToUTF8String(Utf16SurrogateToInt(Wc, InBuf[InIndx]));
          end
        else
          raise EConvertError.CreateFmt(
            'High surrogate %4.4X without low surrogate.',[Word(Wc)]);
        end;
      $DC00..$DFFF:	// low surrogate
        begin
        Inc(InIndx);
        if (InIndx < (Count - 1)) and (Word(InBuf[InIndx]) >= $D800)
          and (Word(InBuf[InIndx]) <= $DBFF) then
          begin
          Inc(OutIndx);
          UCS4CodeToUTF8String(Utf16SurrogateToInt(InBuf[InIndx], Wc));
          end
        else
          raise EConvertError.CreateFmt(
            'Low surrogate %4.4X without high surrogate.',[Word(Wc)]);
        end;
      $0080..$D7FF,$E000..$FFFD:
        begin
        Inc(OutIndx);
        UCS4CodeToUTF8String(Word(Wc));
        end;
    end; {case ...}
    Inc(InIndx);
  end; { while ...}
  Result := OutIndx + 1;
end;


//+++++++++++++++++++++++ TdomImplementation ++++++++++++++++++++++++++
constructor TdomImplementation.create(aOwner: TComponent);
begin
  inherited create(aOwner);
  FCreatedCMObjectsListing:= TList.create;
  FCreatedCMObjects:= TdomCMNodeList.create(FCreatedCMObjectsListing);
  FCreatedDocumentsListing:= TList.create;
  FCreatedDocuments:= TdomNodeList.create(FCreatedDocumentsListing);
  FCreatedDocumentTypesListing:= TList.create;
  FCreatedDocumentTypes:= TdomNodeList.create(FCreatedDocumentTypesListing);
  FCreatedCMExternalObjectsListing:= TList.create;
  FCreatedCMExternalObjects:= TdomCMNodeList.create(FCreatedCMExternalObjectsListing);
  FCreatedCMInternalObjectsListing:= TList.create;
  FCreatedCMInternalObjects:= TdomCMNodeList.create(FCreatedCMInternalObjectsListing);
end;

destructor TdomImplementation.destroy;
begin
  clear;
  FCreatedCMObjectsListing.free;
  FCreatedCMObjects.free;
  FCreatedDocumentsListing.free;
  FCreatedDocuments.free;
  FCreatedDocumentTypesListing.free;
  FCreatedDocumentTypes.free;
  FCreatedCMExternalObjectsListing.free;
  FCreatedCMExternalObjects.free;
  FCreatedCMInternalObjectsListing.free;
  FCreatedCMInternalObjects.free;
  inherited destroy;
end;

procedure TdomImplementation.clear;
var
  i: integer;
begin
  for i:= 0 to FCreatedDocumentsListing.count-1 do begin
    TdomDocument(FCreatedDocumentsListing[i]).clear; // destroys all child nodes, nodeIterators and treeWalkers
    TdomDocument(FCreatedDocumentsListing[i]).free;
    FCreatedDocumentsListing[i]:= nil;
  end;
  FCreatedDocumentsListing.pack;
  FCreatedDocumentsListing.Capacity:= FCreatedDocumentsListing.Count;

  for i:= 0 to FCreatedDocumentTypesListing.count-1 do begin
    TdomDocumentType(FCreatedDocumentTypesListing[i]).free;
    FCreatedDocumentTypesListing[i]:= nil;
  end;
  FCreatedDocumentTypesListing.pack;
  FCreatedDocumentTypesListing.Capacity:= FCreatedDocumentTypesListing.Count;

  for i:= 0 to FCreatedCMExternalObjectsListing.count-1 do begin
    TdomCMExternalObject(FCreatedCMExternalObjectsListing[i]).free;
    FCreatedCMExternalObjectsListing[i]:= nil;
  end;
  FCreatedCMExternalObjectsListing.pack;
  FCreatedCMExternalObjectsListing.Capacity:= FCreatedCMExternalObjectsListing.Count;

  for i:= 0 to FCreatedCMInternalObjectsListing.count-1 do begin
    TdomCMInternalObject(FCreatedCMInternalObjectsListing[i]).free;
    FCreatedCMInternalObjectsListing[i]:= nil;
  end;
  FCreatedCMInternalObjectsListing.pack;
  FCreatedCMInternalObjectsListing.Capacity:= FCreatedCMInternalObjectsListing.Count;

  for i:= 0 to FCreatedCMObjectsListing.count-1 do begin
    TdomCMObject(FCreatedCMObjectsListing[i]).free;
    FCreatedCMObjectsListing[i]:= nil;
  end;
  FCreatedCMObjectsListing.pack;
  FCreatedCMObjectsListing.Capacity:= FCreatedCMObjectsListing.Count;
end;

procedure TdomImplementation.FreeCMExternalObject(var arg: TdomCMExternalObject);
var
  index: integer;
begin
  index:= FCreatedCMExternalObjectsListing.IndexOf(arg);
  if index = -1
    then raise ENot_Found_Err.create('External content model not found error.');
  // remove the content model from its associated content models:
  if assigned(arg.associatedContentModel)
    then arg.associatedContentModel.removeExternalCM;
  // free the external content model itself:
  FCreatedCMExternalObjectsListing.Delete(index);
  arg.free;
  arg:= nil;
end;

procedure TdomImplementation.FreeCMInternalObject(var arg: TdomCMInternalObject);
var
  index: integer;
begin
  index:= FCreatedCMInternalObjectsListing.indexOf(arg);
  if index = -1
    then raise ENot_Found_Err.create('Internal content model not found error.');
  // remove the content model from its associated content model:
  if assigned(arg.associatedContentModel)
    then arg.associatedContentModel.removeInternalCM;
  // free the Internal content model itself:
  FCreatedCMInternalObjectsListing.Delete(index);
  arg.free;
  arg:= nil;
end;

procedure TdomImplementation.FreeCMObject(var arg: TdomCMObject);
var
  index: integer;
begin
  index:= FCreatedCMObjectsListing.IndexOf(arg);
  if index = -1
    then raise ENot_Found_Err.create('Content model not found error.');
  // remove associated content models
  arg.removeExternalCM;
  arg.removeInternalCM;
  // remove the content model from its associated document:
  if assigned(arg.associatedDocument)
    then arg.associatedDocument.removeContentModel;
  // free the content model itself:
  FCreatedCMObjectsListing.Delete(index);
  arg.free;
  arg:= nil;
end;

procedure TdomImplementation.FreeDocument(var doc: TdomDocument);
var
  index: integer;
begin
  index:= FCreatedDocumentsListing.IndexOf(doc);
  if index = -1
    then raise ENot_Found_Err.create('Document not found error.');
  // free the content model associated with the document:
  if assigned(doc.FCMInternal) then FreeCMObject(doc.FCMInternal);
  // free all child nodes, nodeIterators and treeWalkers:
  doc.clear;
  // free the document itself:
  FCreatedDocumentsListing.Delete(index);
  doc.free;
  doc:= nil;
end;

procedure TdomImplementation.FreeDocumentType(var docType: TdomDocumentType);
var
  index: integer;
begin
  index:= FCreatedDocumentTypesListing.IndexOf(docType);
  if index = -1
    then raise ENot_Found_Err.create('DocumentType not found error.');
  FCreatedDocumentTypesListing.delete(index);
  docType.free;
  docType:= nil;
end;

function TdomImplementation.getCMObjects: TdomCMNodeList;
begin
  result:= FCreatedCMObjects;
end;

function TdomImplementation.getDocuments: TdomNodeList;
begin
  Result:= FCreatedDocuments;
end;

function TdomImplementation.getDocumentTypes: TdomNodeList;
begin
  Result:= FCreatedDocumentTypes;
end;

function TdomImplementation.getCMExternalObjects: TdomCMNodeList;
begin
  result:= FCreatedCMExternalObjects;
end;

function TdomImplementation.getCMInternalObjects: TdomCMNodeList;
begin
  result:= FCreatedCMInternalObjects;
end;

function TdomImplementation.HasFeature(const feature,
                                             version: wideString): boolean;
var
  VersionStr: string;
begin
  Result:= false;
  VersionStr:= WideCharToString(PWideChar(feature));
  if (WideCharToString(PWideChar(version))='1.0')
    or (WideCharToString(PWideChar(version))='')
  then begin
    if (CompareText(VersionStr,'XML')=0)
       then Result:= true;
  end else begin
    if (WideCharToString(PWideChar(version))='2.0')
      then begin
        if (CompareText(VersionStr,'XML')=0)
           then Result:= true;
        if (CompareText(VersionStr,'VIEWS')=0)
           then Result:= true;
        if (CompareText(VersionStr,'TRAVERSAL')=0)
           then Result:= true;
    end else begin
      if version = ''
        then begin
          if (CompareText(VersionStr,'XML')=0)
             then Result:= true;
          if (CompareText(VersionStr,'VIEWS')=0)
             then Result:= true;
          if (CompareText(VersionStr,'TRAVERSAL')=0)
             then Result:= true;
      end;  {if ... }
    end;  {if ... else ...}
  end; {if ... else ...}
end;

function TdomImplementation.createCMExternalObject(const pubId,
                                                         sysId: wideString): TdomCMExternalObject;
begin
  Result:= TdomCMExternalObject.create(self,pubId,sysId);
  FCreatedCMExternalObjectsListing.add(Result);
end;

function TdomImplementation.createCMInternalObject(const pubId,
                                                         sysId: wideString): TdomCMInternalObject;
begin
  Result:= TdomCMInternalObject.create(self,pubId,sysId);
  FCreatedCMInternalObjectsListing.add(Result);
end;

function TdomImplementation.createCMObject: TdomCMObject;
begin
  Result:= TdomCMObject.create(self);
  FCreatedCMObjectsListing.add(Result);
end;

function TdomImplementation.createDocument(const name: wideString;
                                                 doctype: TdomDocumentType): TdomDocument;
begin
  if assigned(doctype) then
    if documentTypes.IndexOf(doctype) = -1
      then raise EWrong_Document_Err.create('Wrong document error.');
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if SupportsDocumentFormat('',name)
    then Result:= getDocumentClass('',name).create(self)
    else Result:= TdomDocument.create(self);
  FCreatedDocumentsListing.add(Result);
  if assigned(doctype) then begin
    FCreatedDocumentTypes.FNodeList.Remove(doctype);
    doctype.FDocument:= Result;
    Result.appendChild(doctype);
  end;
  Result.InitDoc(name);
end;

function TdomImplementation.createDocumentNS(const namespaceURI,
                                                   qualifiedName: wideString;
                                                   doctype: TdomDocumentType): TdomDocument;
var
  prfx: wideString;
begin
  if assigned(doctype) then
    if documentTypes.IndexOf(doctype) = -1
      then raise EWrong_Document_Err.create('Wrong document error.');
  if not IsXmlName(qualifiedName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not IsXmlQName(qualifiedName)
    then raise ENamespace_Err.create('Namespace error.');
  prfx:= XMLExtractPrefix(qualifiedName);
  if ( ((prfx = 'xmlns') or (qualifiedName = 'xmlns'))
    and not (namespaceURI ='http://www.w3.org/2000/xmlns/') )
      then raise ENamespace_Err.create('Namespace error.');
  if (namespaceURI = '') and (prfx <> '')
    then raise ENamespace_Err.create('Namespace error.');
  if (prfx = 'xml') and (namespaceURI <> 'http://www.w3.org/XML/1998/namespace')
    then raise ENamespace_Err.create('Namespace error.');
  if SupportsDocumentFormat(namespaceURI,qualifiedName)
    then Result:= getDocumentClass(namespaceURI,qualifiedName).create(self)
    else Result:= TdomDocument.create(self);
  FCreatedDocuments.FNodeList.add(Result);
  if assigned(doctype) then begin
    FCreatedDocumentTypes.FNodeList.Remove(doctype);
    doctype.FDocument:= Result;
    Result.appendChild(doctype);
  end;
  Result.InitDocNS(namespaceURI,qualifiedName);
end;

{
  The following two methods have been removed from this version of
  the XDOM, but will be reintroduced in a further release.

function TdomImplementation.createDocumentType(const name,
                                                     publicId,
                                                     systemId,
                                                     intSubset: wideString): TdomDocumentType;
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  Result:= TdomDocumentType.create(nil,name,publicId,systemId,intSubset);
  FCreatedDocumentTypes.FNodeList.add(Result);
end;

function TdomImplementation.createDocumentTypeNS(const qualifiedName,
                                                       publicId,
                                                       systemId,
                                                       intSubset: wideString): TdomDocumentType;
begin
  if not IsXmlName(qualifiedName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not IsXmlQName(qualifiedName)
    then raise ENamespace_Err.create('Namespace error.');
  Result:= TdomDocumentType.create(nil,qualifiedName,publicId,systemId,intSubset);
  FCreatedDocumentTypes.FNodeList.add(Result);
end;
 }

function TdomImplementation.GetDocumentClass(const aNamespaceUri,
                                                   aQualifiedName: wideString): TdomDocumentClass;
var
  aDocFormat: PdomDocumentFormat;
begin
  aDocFormat := domDocumentFormatList;
  while aDocFormat <> nil do
    with aDocFormat^ do begin
      if (aNamespaceUri = NamespaceUri) and (aQualifiedName = qualifiedName) then begin
        Result:= DocumentClass;
        exit;
      end else aDocFormat := next;
    end;
  raise EUnknown_Document_Format_Err.create('Unknown document format yet');
end;

class procedure TdomImplementation.RegisterDocumentFormat(const aNamespaceUri,
                                                                aQualifiedName: wideString;
                                                                aDocumentClass: TdomDocumentClass);
var
  newRec: PdomDocumentFormat;
begin
  if aQualifiedName = 'default'
    then raise EInvalid_Access_Err.create('Illegal Parameter Error: Attempt to set the reserved Document Format "default".');
  new(newRec);
  with newRec^ do begin
    documentClass:= aDocumentClass;
    NamespaceUri:= aNamespaceUri;
    qualifiedName:= aQualifiedName;
    next:= domDocumentFormatList;
  end;
  domDocumentFormatList:= newRec;
end;

function TdomImplementation.SupportsDocumentFormat(const aNamespaceUri,
                                                         aQualifiedName: wideString): boolean;
var
  aDocFormat: PdomDocumentFormat;
begin
  Result:= false;
  aDocFormat:= domDocumentFormatList;
  while aDocFormat <> nil do
    with aDocFormat^ do begin
      if (aNamespaceUri = NamespaceUri) and (aQualifiedName = qualifiedName) then begin
        Result:= true;
        exit;
      end else aDocFormat := next;
    end;
end;

class procedure TdomImplementation.UnregisterDocumentClass(const aDocumentClass: TdomDocumentClass);
var
  aDocFormat,oldRec,previous: PdomDocumentFormat;
begin
  previous:= nil;
  aDocFormat := domDocumentFormatList;
  while aDocFormat <> nil do
    with aDocFormat^ do begin
      if aDocumentClass = DocumentClass then begin
        oldRec:= aDocFormat;
        if assigned(previous)
          then previous.next:= next
          else domDocumentFormatList := next;
        previous:= aDocFormat;
        aDocFormat := next;
        Dispose(oldRec);
      end else begin
        previous:= aDocFormat;
        aDocFormat := next;
      end;
    end; {with ...}
end;



//++++++++++++++++++++++++++++ TdomTreeWalker +++++++++++++++++++++++++++++++
constructor TdomTreeWalker.create(const Root: TdomNode;
                                  const WhatToShow: TdomWhatToShow;
                                  const NodeFilter: TdomNodeFilter;
                                  const EntityReferenceExpansion: boolean);
begin
  if not assigned(Root)
    then raise ENot_Supported_Err.create('Not supported error.');
  inherited create;
  FWhatToShow:= WhatToShow;
  FFilter:= NodeFilter;
  FExpandEntityReferences:= EntityReferenceExpansion;
  FRoot:= Root;
  FCurrentNode:= Root;
end;

function TdomTreeWalker.GetCurrentNode: TdomNode;
begin
  Result:= FCurrentNode;
end;

procedure TdomTreeWalker.SetCurrentNode(const node: TdomNode);
begin
  if not assigned(node)
    then raise ENot_Supported_Err.create('Not supported error.');
  FCurrentNode:= node;
end;

function TdomTreeWalker.FindNextSibling(const oldNode: TdomNode): TdomNode;
var
  accept: TdomFilterResult;
  newNode: TdomNode;
begin
  Result:= nil;
  if oldNode = root then exit;
  newNode:= oldNode.NextSibling;
  if assigned(newNode) then begin
    if newNode.NodeType in FWhatToShow then begin
      if assigned(FFilter)
        then accept:= FFilter.acceptNode(newNode)
        else accept:= filter_accept;
    end else accept:= filter_skip;
    case accept of
      filter_reject:
        Result:= FindNextSibling(newNode);
      filter_skip:
        begin
          Result:= FindFirstChild(newNode);
          if not assigned(result)
            then Result:= FindNextSibling(newNode);
        end;
      filter_accept:
        Result:= newNode;
    end; {case ...}
  end else begin
    if not assigned(oldNode.parentNode)
      then begin result:= nil; exit; end; // TreeWalker.root not found!
    if oldNode.parentNode.NodeType in FWhatToShow then begin
      if assigned(FFilter)
        then accept:= FFilter.acceptNode(oldNode.parentNode)
        else accept:= filter_accept;
    end else accept:= filter_skip;
    case accept of
      filter_reject, filter_skip:
        Result:= FindNextSibling(oldNode.parentNode);
      filter_accept:
        Result:= nil;
    end; {case ...}
  end;
end;

function TdomTreeWalker.FindPreviousSibling(const OldNode: TdomNode): TdomNode;
var
  accept: TdomFilterResult;
  newNode: TdomNode;
begin
  Result:= nil;
  if OldNode = root then exit;
  newNode:= oldNode.PreviousSibling;
  if assigned(newNode) then begin
    if newNode.NodeType in FWhatToShow then begin
      if assigned(FFilter)
        then accept:= FFilter.acceptNode(newNode)
        else accept:= filter_accept;
    end else accept:= filter_skip;
    case accept of
      filter_reject:
        Result:= FindPreviousSibling(newNode);
      filter_skip:
        begin
          Result:= FindLastChild(newNode);
          if not assigned(result)
            then Result:= FindPreviousSibling(newNode);
        end;
      filter_accept:
        Result:= newNode;
    end; {case ...}
  end else begin
    if not assigned(oldNode.parentNode)
      then begin result:= nil; exit; end; // TreeWalker.root not found!
    if oldNode.parentNode.NodeType in FWhatToShow then begin
      if assigned(FFilter)
        then accept:= FFilter.acceptNode(oldNode.parentNode)
        else accept:= filter_accept;
    end else accept:= filter_skip;
    case accept of
      filter_reject, filter_skip:
        Result:= FindPreviousSibling(oldNode.parentNode);
      filter_accept:
        Result:= nil;
    end; {case ...}
  end;
end;

function TdomTreeWalker.FindParentNode(const OldNode: TdomNode): TdomNode;
var
  accept: TdomFilterResult;
begin
  Result:= nil;
  if OldNode = root then exit;
  Result:= OldNode.ParentNode;
  if not assigned(Result)
    then begin result:= nil; exit; end; // TreeWalker.root not found!
  if Result.NodeType in FWhatToShow then begin
    if assigned(FFilter)
      then accept:= FFilter.acceptNode(Result)
      else accept:= filter_accept;
  end else accept:= filter_skip;
  case accept of
    filter_reject, filter_skip:
      Result:= FindParentNode(Result);
  end;
end;

function TdomTreeWalker.FindFirstChild(const oldNode: TdomNode): TdomNode;
var
  i: integer;
  newNode: TdomNode;
  accept: TdomFilterResult;
begin
  Result:= nil;
  if (oldNode.nodeType = ntEntity_Reference_Node) and not FExpandEntityReferences
    then exit;
  for i:= 0 to pred(oldnode.childNodes.length) do begin
    newNode:= oldnode.childNodes.item(i);
    if newNode.NodeType in FWhatToShow then begin
      if assigned(FFilter)
        then accept:= FFilter.acceptNode(newNode)
        else accept:= filter_accept;
    end else accept:= filter_skip;
    case accept of
      filter_skip:
        Result:= FindFirstChild(newNode);
      filter_accept:
        Result:= newNode;
    end; {case ...}
    if assigned(result) then break;
  end; {for ...}
end;

function TdomTreeWalker.FindLastChild(const OldNode: TdomNode): TdomNode;
var
  i: integer;
  newNode: TdomNode;
  accept: TdomFilterResult;
begin
  Result:= nil;
  if (oldNode.nodeType = ntEntity_Reference_Node) and not FExpandEntityReferences
    then exit;
  for i:= pred(oldnode.childNodes.length) downto 0 do begin
    newNode:= oldnode.childNodes.item(i);
    if newNode.NodeType in FWhatToShow then begin
      if assigned(FFilter)
        then accept:= FFilter.acceptNode(newNode)
        else accept:= filter_accept;
    end else accept:= filter_skip;
    case accept of
      filter_skip:
        Result:= FindLastChild(newNode);
      filter_accept:
        Result:= newNode;
    end; {case ...}
    if assigned(result) then break;
  end; {for ...}
end;

function TdomTreeWalker.FindNextNode(OldNode: TdomNode): TdomNode;
var
  newNode: TdomNode;
begin
  Result:= FindFirstChild(oldNode);
  if OldNode = root then exit;
  if not assigned(Result)
    then Result:= FindNextSibling(oldNode);
  while not assigned(Result) do begin
    newNode:= FindParentNode(oldNode);
    if not assigned(newNode) then exit;  // No next node.
    Result:= FindNextSibling(newNode);
    oldNode:= newNode;
  end;
end;

function TdomTreeWalker.FindPreviousNode(const OldNode: TdomNode): TdomNode;
var
  newNode: TdomNode;
begin
  Result:= nil;
  if OldNode = root then exit;
  Result:= FindPreviousSibling(oldNode);
  if assigned(Result) then begin
    newNode:= FindLastChild(Result);
    if assigned(newNode) then result:= newNode;
  end else
    result:= FindParentNode(oldNode);
end;

function TdomTreeWalker.parentNode: TdomNode;
begin
  Result:= FindParentNode(FCurrentNode);
  if assigned(Result) then FCurrentNode:= Result;
end;

function TdomTreeWalker.firstChild: TdomNode;
begin
  Result:= FindFirstChild(FCurrentNode);
  if assigned(Result) then FCurrentNode:= Result;
end;

function TdomTreeWalker.lastChild: TdomNode;
begin
  Result:= FindLastChild(FCurrentNode);
  if assigned(Result) then FCurrentNode:= Result;
end;

function TdomTreeWalker.previousSibling: TdomNode;
begin
  Result:= FindPreviousSibling(FCurrentNode);
  if assigned(Result) then FCurrentNode:= Result;
end;

function TdomTreeWalker.nextSibling: TdomNode;
begin
  Result:= FindNextSibling(FCurrentNode);
  if assigned(Result) then FCurrentNode:= Result;
end;

function TdomTreeWalker.previousNode: TdomNode;
begin
  Result:= FindPreviousNode(FCurrentNode);
  if assigned(Result) then FCurrentNode:= Result;
end;

function TdomTreeWalker.nextNode: TdomNode;
begin
  Result:= FindNextNode(FCurrentNode);
  if assigned(Result) then FCurrentNode:= Result;
end;



//++++++++++++++++++++++++++++ TdomNodeIterator +++++++++++++++++++++++++++++++
constructor TdomNodeIterator.create(const Root: TdomNode;
                                    const WhatToShow: TdomWhatToShow;
                                    const nodeFilter: TdomNodeFilter;
                                    const EntityReferenceExpansion: boolean);
begin
  if not assigned(Root)
    then raise ENot_Supported_Err.create('Not supported error.');
  inherited create;
  FRoot:= root;
  FWhatToShow:= WhatToShow;
  FFilter:= NodeFilter;
  FExpandEntityReferences:= EntityReferenceExpansion;
  FReferenceNode:= Root;
  FInvalid:= false;
  FPosition:= posBefore;
end;

procedure TdomNodeIterator.FindNewReferenceNode(const nodeToRemove: TdomNode);
var
  newRefNode: TdomNode;
  newPosition: TdomPosition;
begin
  newRefNode:= nil;
  newPosition:= FPosition;
  case FPosition of
    posBefore: begin
      newRefNode:= nodeToRemove.NextSibling;
      if not assigned(newRefNode) then begin
        newRefNode:= FindPreviousNode(nodeToRemove);
        newPosition:= posAfter;
      end;
    end;
    posAfter: begin
      newRefNode:= nodeToRemove.NextSibling;
      if not assigned(newRefNode) then begin
        newRefNode:= FindPreviousNode(nodeToRemove);
        newPosition:= posBefore;
      end;
    end;
  end; {case ...}
  if assigned(newRefNode) then begin
    FReferenceNode:= newRefNode;
    FPosition:= newPosition;
  end;
end;

procedure TdomNodeIterator.detach;
begin
  FReferenceNode:= nil;
  FInvalid:= true;
end;

function TdomNodeIterator.FindNextNode(OldNode: TdomNode): TdomNode;
var
  newNode: TdomNode;
begin
  with OldNode do
    if HasChildNodes
      and ( FExpandEntityReferences or (nodeType <> ntEntity_Reference_Node) )
      then result:= FirstChild
      else result:= NextSibling;
  while not assigned(Result) do begin
    newNode:= oldNode.ParentNode;
    if not assigned(newNode) then exit;  // No next node.
    Result:= newNode.NextSibling;
    oldNode:= newNode;
  end;
end;

function TdomNodeIterator.FindPreviousNode(const OldNode: TdomNode): TdomNode;
var
  newNode: TdomNode;
begin
  with OldNode do begin
    result:= PreviousSibling;
    if assigned(result) then begin
      newNode:= result;
      while assigned(newNode) do begin
        result:= newNode;
        newNode:= newNode.LastChild;
      end;
    end else result:= ParentNode;
  end;
end;

function TdomNodeIterator.NextNode: TdomNode;
var
  accept: TdomFilterResult;
  newNode: TdomNode;
begin
  newNode:= nil;
  if FInvalid
    then raise EInvalid_State_Err.create('Invalid state error.');
  case FPosition of
    posBefore: begin
      FPosition:= posAfter;
      newNode:= FReferenceNode;
    end;
    posAfter: begin
      newNode:= FindNextNode(FReferenceNode);
    end;
  end;
  repeat
    accept:= filter_accept;
    if assigned(newNode) then begin
      if newNode.NodeType in FWhatToShow then begin
        if assigned(FFilter)
          then accept:= FFilter.acceptNode(newNode);
      end else accept:= filter_skip;
      if not (accept = filter_accept)
        then newNode:= FindNextNode(newNode);
    end;
  until accept = filter_accept;
  if assigned(newNode) then
    if not (newNode.IsAncestor(root) or (newNode = root)) then
      if (FReferenceNode.IsAncestor(root) or (FReferenceNode = root)) then newNode:= nil;
  if assigned(newNode) then FReferenceNode:= newNode;
  Result:= newNode;
end;

function TdomNodeIterator.PreviousNode: TdomNode;
var
  accept: TdomFilterResult;
  newNode: TdomNode;
begin
  newNode:= nil;
  if FInvalid
    then raise EInvalid_State_Err.create('Invalid state error.');
  case FPosition of
    posBefore: begin
      newNode:= FindPreviousNode(FReferenceNode);
    end;
    posAfter: begin
      FPosition:= posBefore;
      newNode:= FReferenceNode;
    end;
  end;
  repeat
    accept:= filter_accept;
    if assigned(newNode) then begin
      if newNode.NodeType in FWhatToShow then begin
        if assigned(FFilter)
          then accept:= FFilter.acceptNode(newNode);
      end else accept:= filter_skip;
      if not (accept = filter_accept)
        then newNode:= FindPreviousNode(newNode);
    end;
  until accept = filter_accept;
  if assigned(newNode) then
    if not (newNode.IsAncestor(root) or (newNode = root)) then
      if (FReferenceNode.IsAncestor(root) or (FReferenceNode = root)) then newNode:= nil;
  if assigned(newNode) then FReferenceNode:= newNode;
  Result:= newNode;
end;



//++++++++++++++++++++++++++++ TdomNodeList +++++++++++++++++++++++++++++++
constructor TdomNodeList.create(const nodeList: TList);
begin
  inherited create;
  FNodeList:= nodeList;
end;

function TdomNodeList.GetLength: integer;
begin
  Result:= FNodeList.count;
end;

function TdomNodeList.IndexOf(const node: TdomNode): integer;
begin
  Result:= FNodeList.IndexOf(node);
end;

function TdomNodeList.Item(const index: integer): TdomNode;
begin
  if (index < 0) or (index + 1 > FNodeList.count)
    then Result:= nil
    else Result:= TdomNode(FNodeList.Items[index]);
end;



//++++++++++++++++++++++++ TdomElementsNodeList ++++++++++++++++++++++++++
constructor TdomElementsNodeList.create(const QueryName: wideString;
                                        const StartElement: TdomNode);
begin
  inherited create(nil);
  FQueryName:= QueryName;
  FStartElement:= StartElement;
end;

function TdomElementsNodeList.GetLength: integer;
var
  AktNode,NewNode: TdomNode;
  Level: integer;
begin
  Result:= 0;
  if not assigned(FStartElement) then exit;
  Level:= 0;
  AktNode:= FStartElement;
  if AktNode.NodeType = ntElement_Node then
    if (AktNode.NodeName = FQueryName) or (FQueryName = '*') then
      inc(Result);
  repeat
    if AktNode.HasChildNodes
      then begin NewNode:= AktNode.FirstChild; inc(Level); end
      else NewNode:= AktNode.NextSibling;
    while not assigned(NewNode) do begin
      dec(Level);
      if Level < 1 then break;
      AktNode:= AktNode.ParentNode;
      NewNode:= AktNode.NextSibling;
    end;
    if Level < 1 then break;
    AktNode:= NewNode;
    if AktNode.NodeType = ntElement_Node then
      if (AktNode.NodeName = FQueryName) or (FQueryName = '*') then
        inc(Result);
  until Level < 1;
end;

function TdomElementsNodeList.IndexOf(const node: TdomNode): integer;
var
  AktNode,NewNode: TdomNode;
  Level,i: integer;
begin
  Result:= -1;
  if not assigned(FStartElement) then exit;
  if not (node is TdomNode) then exit;
  if node.NodeType <> ntElement_Node then exit;
  i:= -1;
  Level:= 0;
  AktNode:= FStartElement;
  repeat
    if AktNode.HasChildNodes
      then begin NewNode:= AktNode.FirstChild; inc(Level); end
      else NewNode:= AktNode.NextSibling;
    while not assigned(NewNode) do begin
      dec(Level);
      if Level < 1 then break;
      AktNode:= AktNode.ParentNode;
      NewNode:= AktNode.NextSibling;
    end;
    if Level < 1 then break;
    AktNode:= NewNode;
    if AktNode.NodeType = ntElement_Node then
      if (AktNode.NodeName = FQueryName) or (FQueryName = '*') then begin
        inc(i);
        if AktNode = node then begin Result:= i; break; end;
      end;
  until Level < 1;
end;

function TdomElementsNodeList.Item(const index: integer): TdomNode;
var
  AktNode,NewNode: TdomNode;
  Level,i: integer;
begin
  Result:= nil;
  if not assigned(FStartElement) then exit;
  if (index < 0) then exit;
  i:= -1;
  Level:= 0;
  AktNode:= FStartElement;
  repeat
    if AktNode.HasChildNodes
      then begin NewNode:= AktNode.FirstChild; inc(Level); end
      else NewNode:= AktNode.NextSibling;
    while not assigned(NewNode) do begin
      dec(Level);
      if Level < 1 then break;
      AktNode:= AktNode.ParentNode;
      NewNode:= AktNode.NextSibling;
    end;
    if Level < 1 then break;
    AktNode:= NewNode;
    if AktNode.NodeType = ntElement_Node then
      if (AktNode.NodeName = FQueryName) or (FQueryName = '*') then begin
        inc(i);
        if i = index then begin Result:= AktNode; break; end;
      end;
  until Level < 1;
end;



//+++++++++++++++++++++TdomElementsNodeListNS ++++++++++++++++++++++++++
constructor TdomElementsNodeListNS.create(const QueryNamespaceURI,
                                                QueryLocalName: wideString;
                                          const StartElement: TdomNode);
begin
  inherited create(nil);
  FQueryNamespaceURI:= QueryNamespaceURI;
  FQueryLocalName:= QueryLocalName;
  FStartElement:= StartElement;
end;

function TdomElementsNodeListNS.GetLength: integer;
var
  AktNode,NewNode: TdomNode;
  Level: integer;
begin
  Result:= 0;
  if not assigned(FStartElement) then exit;
  Level:= 0;
  AktNode:= FStartElement;
  repeat
    if AktNode.HasChildNodes
      then begin NewNode:= AktNode.FirstChild; inc(Level); end
      else NewNode:= AktNode.NextSibling;
    while not assigned(NewNode) do begin
      dec(Level);
      if Level < 1 then break;
      AktNode:= AktNode.ParentNode;
      NewNode:= AktNode.NextSibling;
    end;
    if Level < 1 then break;
    AktNode:= NewNode;
    if AktNode.NodeType = ntElement_Node then
      if ((AktNode.namespaceURI = FQueryNamespaceURI) or (FQueryNamespaceURI = '*'))
        and ((AktNode.localName = FQueryLocalName) or (FQueryLocalName = '*'))
          then inc(Result);
  until Level < 1;
end;

function TdomElementsNodeListNS.IndexOf(const node: TdomNode): integer;
var
  AktNode,NewNode: TdomNode;
  Level,i: integer;
begin
  Result:= -1;
  if not assigned(FStartElement) then exit;
  if not (node is TdomNode) then exit;
  if node.NodeType <> ntElement_Node then exit;
  i:= -1;
  Level:= 0;
  AktNode:= FStartElement;
  repeat
    if AktNode.HasChildNodes
      then begin NewNode:= AktNode.FirstChild; inc(Level); end
      else NewNode:= AktNode.NextSibling;
    while not assigned(NewNode) do begin
      dec(Level);
      if Level < 1 then break;
      AktNode:= AktNode.ParentNode;
      NewNode:= AktNode.NextSibling;
    end;
    if Level < 1 then break;
    AktNode:= NewNode;
    if AktNode.NodeType = ntElement_Node then
      if ((AktNode.namespaceURI = FQueryNamespaceURI) or (FQueryNamespaceURI = '*'))
        and ((AktNode.localName = FQueryLocalName) or (FQueryLocalName = '*'))
          then begin
            inc(i);
            if AktNode = node then begin Result:= i; break; end;
          end;
  until Level < 1;
end;

function TdomElementsNodeListNS.Item(const index: integer): TdomNode;
var
  AktNode,NewNode: TdomNode;
  Level,i: integer;
begin
  Result:= nil;
  if not assigned(FStartElement) then exit;
  if (index < 0) then exit;
  i:= -1;
  Level:= 0;
  AktNode:= FStartElement;
  repeat
    if AktNode.HasChildNodes
      then begin NewNode:= AktNode.FirstChild; inc(Level); end
      else NewNode:= AktNode.NextSibling;
    while not assigned(NewNode) do begin
      dec(Level);
      if Level < 1 then break;
      AktNode:= AktNode.ParentNode;
      NewNode:= AktNode.NextSibling;
    end;
    if Level < 1 then break;
    AktNode:= NewNode;
    if AktNode.NodeType = ntElement_Node then
      if ((AktNode.namespaceURI = FQueryNamespaceURI) or (FQueryNamespaceURI = '*'))
        and ((AktNode.localName = FQueryLocalName) or (FQueryLocalName = '*'))
          then begin
            inc(i);
            if i = index then begin Result:= AktNode; break; end;
          end;
  until Level < 1;
end;



//++++++++++++++++++++++++ TdomSpecialNodeList ++++++++++++++++++++++++++
constructor TdomSpecialNodeList.create(const nodeList: TList;
                                       const allowedNTs: TDomNodeTypeSet);
begin
  inherited create(nodeList);
  FAllowedNodeTypes:= allowedNTs;
end;

function TdomSpecialNodeList.GetLength: integer;
var
  i: integer;
begin
  Result:= 0;
  for i:= 0 to FNodeList.count-1 do
    if TdomNode(FNodeList[i]).NodeType in FAllowedNodeTypes
      then inc(Result);
end;

function TdomSpecialNodeList.IndexOf(const node: TdomNode): integer;
var
  i: integer;
begin
  Result:= -1;
  if not (node.NodeType in FAllowedNodeTypes) then exit;
  for i:= 0 to FNodeList.count-1 do begin
    if TdomNode(FNodeList[i]).NodeType in FAllowedNodeTypes
      then inc(Result);
    if TdomNode(FNodeList[i]) = node
      then begin Result:= i; break; end;
  end;
end;

function TdomSpecialNodeList.Item(const index: integer): TdomNode;
var
  i,j: integer;
begin
  Result:= nil;
  j:= -1;
  if (index < 0) or (index > FNodeList.count-1) then exit;
  for i:= 0 to FNodeList.count-1 do begin
    if TdomNode(FNodeList[i]).NodeType in FAllowedNodeTypes
      then inc(j);
    if j = index then begin Result:= TdomNode(FNodeList[i]); break; end;
  end;
end;

function TdomSpecialNodeList.GetNamedIndex(const name: wideString): integer;
var
  i,j: integer;
begin
  result:= -1;
  j:= -1;
  for i:= 0 to FNodeList.count-1 do
    if TdomNode(FNodeList[i]).NodeType in FAllowedNodeTypes then begin
      inc(j);
      if (TdomNode(FNodeList[i]).NodeName = name)
        then begin Result:= j; break; end;
    end;
end;

function TdomSpecialNodeList.GetNamedItem(const name: wideString): TdomNode;
var
  i: integer;
begin
  result:= nil;
  for i:= 0 to FNodeList.count-1 do
    if (TdomNode(FNodeList[i]).NodeName = name)
      and (TdomNode(FNodeList[i]).NodeType in FAllowedNodeTypes) then begin
      Result:= TdomNode(FNodeList[i]);
      break;
    end;
end;


//+++++++++++++++++++++++++ TdomNamedNodeMap +++++++++++++++++++++++++++++
constructor TdomNamedNodeMap.create(const aOwner,
                                          aOwnerNode: TdomNode;
                                    const nodeList: TList;
                                    const allowedNTs: TDomNodeTypeSet);
begin
  inherited create(nodeList);
  FOwner:= aOwner;
  FOwnerNode:= aOwnerNode;
  FAllowedNodeTypes:= allowedNTs;
  FNamespaceAware:= false;
  FIsReadonly:= false;
end;

function TdomNamedNodeMap.getOwnerNode: TdomNode;
begin
  Result:= FOwnerNode;
end;

function TdomNamedNodeMap.getNamespaceAware: boolean;
begin
  Result:= FNamespaceAware;
end;

procedure TdomNamedNodeMap.setNamespaceAware(const value: boolean);
begin
  if FNodeList.count > 0
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  FNamespaceAware:= value;
end;

function TdomNamedNodeMap.RemoveItem(const arg: TdomNode): TdomNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FNodeList.IndexOf(arg) = -1
    then raise ENot_Found_Err.create('Node not found error.');
  Result:= arg;
  FNodeList.Remove(arg);
  Result.FParentNode:= nil;
end;

procedure TdomNamedNodeMap.setIsReadonly(const value: boolean);
begin
  FIsReadonly:= value;
end;

function TdomNamedNodeMap.GetNamedIndex(const name: wideString): integer;
var
  i: integer;
begin
  if FNamespaceAware then raise ENamespace_Err.create('Namespace error.');
  result:= -1;
  for i:= 0 to FNodeList.count-1 do
    if (TdomNode(FNodeList[i]).NodeName = name)
      and (TdomNode(FNodeList[i]).NodeType in FAllowedNodeTypes) then begin
      Result:= i;
      break;
    end;
end;

function TdomNamedNodeMap.GetNamedItem(const name: wideString): TdomNode;
var
  i: integer;
begin
  if FNamespaceAware then raise ENamespace_Err.create('Namespace error.');
  result:= nil;
  for i:= 0 to FNodeList.count-1 do
    if (TdomNode(FNodeList[i]).NodeName = name)
      and (TdomNode(FNodeList[i]).NodeType in FAllowedNodeTypes) then begin
      Result:= TdomNode(FNodeList[i]);
      break;
    end;
end;

function TdomNamedNodeMap.SetNamedItem(const arg: TdomNode): TdomNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FNamespaceAware then raise ENamespace_Err.create('Namespace error.');
  if FOwner.OwnerDocument <> arg.OwnerDocument
    then raise EWrong_Document_Err.create('Wrong document error.');
  if not (arg.NodeType in FAllowedNodeTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if assigned(arg.parentNode)
    then raise EInuse_Node_Err.create('Inuse node error.');
  if arg.NodeType = ntAttribute_Node
    then if assigned((arg as TdomAttr).OwnerElement)
      then if (arg as TdomAttr).OwnerElement <> FOwnerNode
        then raise EInuse_Attribute_Err.create('Inuse attribute error.');
  if assigned(GetNamedItem(arg.NodeName))
    then Result:= RemoveNamedItem(arg.NodeName)
    else Result:= nil;
  FNodeList.Add(arg);
  arg.FParentNode:= nil;
  if (arg.NodeType = ntAttribute_Node)
    and (FOwnerNode.NodeType = ntElement_Node)
    then (arg as TdomAttr).FownerElement:= TdomElement(FOwnerNode);
end;

function TdomNamedNodeMap.RemoveNamedItem(const name: wideString): TdomNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FNamespaceAware then raise ENamespace_Err.create('Namespace error.');
  Result:= getNamedItem(name);
  if not assigned(Result)
    then raise ENot_Found_Err.create('Node not found error.');
  FNodeList.Remove(Result);
  if Result.NodeType = ntAttribute_Node
    then (Result as TdomAttr).FownerElement:= nil;
end;

function TdomNamedNodeMap.GetNamedItemNS(const namespaceURI,
                                               localName: wideString): TdomNode;
var
  i: integer;
begin
  if not FNamespaceAware then raise ENamespace_Err.create('Namespace error.');
  result:= nil;
  for i:= 0 to FNodeList.count-1 do
    if (TdomNode(FNodeList[i]).namespaceURI = namespaceURI)
      and (TdomNode(FNodeList[i]).localName = localName)
      and (TdomNode(FNodeList[i]).NodeType in FAllowedNodeTypes) then begin
      Result:= TdomNode(FNodeList[i]);
      break;
    end;
end;

function TdomNamedNodeMap.SetNamedItemNS(const arg: TdomNode): TdomNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if not FNamespaceAware then raise ENamespace_Err.create('Namespace error.');
  if FOwner.OwnerDocument <> arg.OwnerDocument
    then raise EWrong_Document_Err.create('Wrong document error.');
  if not (arg.NodeType in FAllowedNodeTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if assigned(arg.parentNode)
    then raise EInuse_Node_Err.create('Inuse node error.');
  if arg.NodeType = ntAttribute_Node
    then if assigned((arg as TdomAttr).OwnerElement)
      then if (arg as TdomAttr).OwnerElement <> FOwnerNode
        then raise EInuse_Attribute_Err.create('Inuse attribute error.');
  if assigned(GetNamedItemNS(arg.namespaceURI,arg.localName))
    then Result:= RemoveNamedItemNS(arg.namespaceURI,arg.localName)
    else Result:= nil;
  FNodeList.Add(arg);
  if (arg.NodeType = ntAttribute_Node)
    and (FOwnerNode.NodeType = ntElement_Node)
    then (arg as TdomAttr).FownerElement:= TdomElement(FOwnerNode);
end;

function TdomNamedNodeMap.RemoveNamedItemNS(const namespaceURI,
                                                  localName: wideString): TdomNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if not FNamespaceAware then raise ENamespace_Err.create('Namespace error.');
  Result:= getNamedItemNS(namespaceURI,localName);
  if not assigned(Result)
    then raise ENot_Found_Err.create('Node not found error.');
  FNodeList.Remove(Result);
  if Result.NodeType = ntAttribute_Node
    then (Result as TdomAttr).FownerElement:= nil;
end;



//+++++++++++++++++++++++++ TdomEntitiesNamedNodeMap +++++++++++++++++++++++++++++
procedure TdomEntitiesNamedNodeMap.ResolveAfterAddition(const addedEntity: TdomEntity);
var
  EntityName: wideString;
  i: integer;
  oldChild: TdomNode;
begin
  if not assigned(addedEntity) then exit;
  EntityName:= addedEntity.NodeName;
  for i:= 0 to pred(FNodeList.Count) do
    if TdomNode(FNodeList[i]).NodeName <> EntityName
      then addedEntity.addEntRefSubtree(TdomNode(FNodeList[i]).NodeName);

  // Test for circular reference:
  with addedEntity do begin
    if HasEntRef(nodeName) then begin
      while HasChildNodes do begin
        FirstChild.setIsReadonly(false);
        oldChild:= RemoveChild(FirstChild);
        OwnerDocument.FreeAllNodes(oldChild);
      end; {while ...}
      raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
    end; {if ...}
  end; {with ...}

  for i:= 0 to pred(FNodeList.Count) do
    TdomEntity(FNodeList[i]).addEntRefSubtree(EntityName);
end;

procedure TdomEntitiesNamedNodeMap.ResolveAfterRemoval(const removedEntity: TdomEntity);
var
  EntityName: wideString;
  i: integer;
begin
  if not assigned(removedEntity) then exit;
  EntityName:= removedEntity.NodeName;
  for i:= 0 to pred(FNodeList.Count) do
    TdomEntity(FNodeList[i]).removeEntRefSubtree(EntityName);
end;

function TdomEntitiesNamedNodeMap.SetNamedItem(const arg: TdomNode): TdomNode;
begin
  result:= inherited setNamedItem(arg);
  try
    ResolveAfterAddition(arg as TdomEntity);
  except
    RemoveNamedItem(arg.nodeName);
    raise;
  end;
end;

function TdomEntitiesNamedNodeMap.RemoveNamedItem(const name: wideString): TdomNode;
begin
  result:= inherited RemoveNamedItem(name);
  if assigned(result)
    then ResolveAfterRemoval(result as TdomEntity);
end;

function TdomEntitiesNamedNodeMap.SetNamedItemNS(const arg: TdomNode): TdomNode;
begin
  result:= inherited setNamedItemNS(arg);
  ResolveAfterAddition(arg as TdomEntity);
end;

function TdomEntitiesNamedNodeMap.RemoveNamedItemNS(const namespaceURI,
                                                          LocalName: wideString): TdomNode;
begin
  result:= inherited RemoveNamedItemNS(namespaceURI,LocalName);
  if assigned(result)
    then ResolveAfterRemoval(result as TdomEntity);
end;



//++++++++++++++++++++++++++++++ TdomNode +++++++++++++++++++++++++++++++++
constructor TdomNode.create(const aOwner: TdomDocument);
begin
  inherited create;
  FDocument:= aOwner;
  FParentNode:= nil;
  FNodeListing:= TList.create;
  FNodeList:= TdomNodeList.create(FNodeListing);
  FNodeName:= '';
  FNodeValue:= '';
  FLocalName:= '';
  FNamespaceURI:= '';
  FPrefix:= '';
  FNodeType:= ntUnknown;
  FAllowedChildTypes:= [ntElement_Node,
                        ntText_Node,
                        ntCDATA_Section_Node,
                        ntEntity_Reference_Node,
                        ntProcessing_Instruction_Node,
                        ntComment_Node,
                        ntDocument_Type_Node,
                        ntDocument_Fragment_Node,
                        ntNotation_Node];
  FIsReadonly:= false;
end;

destructor TdomNode.destroy;
begin
  FNodeListing.free;
  FNodeList.free;
  inherited destroy;
end;

procedure TdomNode.clear;
var
  oldChild: TdomNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  while hasChildNodes do begin
    firstChild.setIsReadonly(false);
    oldChild:= removeChild(firstChild);
    ownerDocument.FreeAllNodes(oldChild);
  end;
end;

procedure TdomNode.makeChildrenReadonly;
var
  i: integer;
begin
  with childnodes do
    for i:= 0 to pred(length) do
      with item(i) do begin
        item(i).setIsReadonly(true);
        item(i).makeChildrenReadonly;
      end;
end;

function TdomNode.RefersToExternalEntity: boolean;
// Returns 'true', if one the TdomNode's children or grandchildren
// (not the TdomNode itself!) is an TdomEntityReference node refering
// directly or indirectly to an external Entity.  Otherwise it returns
// 'false'.  If the target of a TdomEntityReference cannot be detected
// this TdomEntityReference counts NOT as refering to an external Entity.
var
  i: integer;
  node: TdomNode;
  contmod: TdomCMObject;
  ent: TdomCMEntity;
begin
  result:= false;
  contmod:= OwnerDocument.contentModel;
  if not assigned(contmod) then exit;
  for i:= 0 to pred(childnodes.length) do begin
    node:= childnodes.item(i);
    case node.nodeType of
      ntEntity_Reference_Node: begin
        ent:= contMod.Entities.getNamedItem(node.nodeName);
        if assigned(ent) then result:=  ent.refersToExternalEntity(true);
      end;
    else
      result:= node.RefersToExternalEntity;
    end; {case ...}
    if result then exit;
  end; {for ...}
end;

function TdomNode.RefersToUnparsedEntity: boolean;
// Returns 'true', if one the TdomNode's children or grandchildren
// (not the TdomNode itself) is an TdomEntityReference node refering
// directly or indirectly to an unparsed Entity.  Otherwise it returns
// 'false'.  If the target of a TdomEntityReference cannot be detected
// this TdomEntityReference counts NOT as refering to an unparsed Entity.
var
  i: integer;
  contmod: TdomCMObject;
begin
  result:= false;
  contmod:= OwnerDocument.contentModel;
  if not assigned(contmod) then exit;
  for i:= 0 to pred(childnodes.length) do begin
    result:= childnodes.item(i).RefersToUnparsedEntity;
    if result then exit;
  end; {for ...}
end;

function TdomNode.HasEntRef(const EntName: wideString): boolean;
var
  i: integer;
begin
  result:= false;
  for i:= 0 to pred(childnodes.length) do
    with childnodes.item(i) do
      if (nodeType = ntEntity_Reference_Node)
          and (nodeName = EntName)
        then result:= true
        else if HasEntRef(EntName) then begin result:= true; exit; end;
end;

procedure TdomNode.addEntRefSubtree(const EntName: wideString);
var
  i: integer;
begin
  for i:= 0 to pred(childnodes.length) do begin
    if (childnodes.item(i).nodeType = ntEntity_Reference_Node)
      and (childnodes.item(i).nodeName = EntName) then begin
      OwnerDocument.ExpandEntRef(childnodes.item(i) as TdomEntityReference);
    end; {if ...}
    childnodes.item(i).addEntRefSubtree(EntName);
  end; {for ...}
end;

procedure TdomNode.removeEntRefSubtree(const EntName: wideString);
var
  i: integer;
  oldChild: TdomNode;
begin
  for i:= 0 to pred(childnodes.length) do
    with childnodes.item(i) do
      if (nodeType = ntEntity_Reference_Node)
          and (nodeName = EntName)
      then begin
        while HasChildNodes do begin
          FirstChild.setIsReadonly(false);
          oldChild:= RemoveChild(FirstChild);
          OwnerDocument.FreeAllNodes(oldChild);
        end;
      end else removeEntRefSubtree(EntName);
end;

function TdomNode.GetNodeName: wideString;
begin
  Result:= FNodeName;
end;

function TdomNode.GetNodeValue: wideString;
begin
  Result:= FNodeValue;
end;

procedure TdomNode.SetNodeValue(const value: wideString);
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  FNodeValue:= value;
end;

function TdomNode.GetNodeType: TdomNodeType;
begin
  Result:= FNodeType;
end;

function TdomNode.GetAttributes: TdomNamedNodeMap;
begin
  Result:= nil;
end;

function TdomNode.GetParentNode: TdomNode;
begin
  Result:= FParentNode;
end;

function TdomNode.GetDocument: TdomDocument;
begin
  Result:= FDocument;
end;

function TdomNode.GetCode: wideString;
var
  XMLStream: TdomWideStringStream;
begin
  XMLStream := TdomWideStringStream.create;
  try
    writeCode(XMLStream);
    Result := XMLStream.DataString;
  finally
    XMLStream.Free;
  end;
end;

function TdomNode.getTextContent: wideString;
var
  childType: TdomNodeType;
  childItem: TdomNode;
  i,cl: integer;
begin
  case nodeType of
    ntElement_Node,ntEntity_Reference_Node,ntEntity_Node,ntDocument_Node,ntDocument_Fragment_Node: begin
      result:= '';
      cl:= pred(childnodes.length);
      for i:= 0 to cl do begin
        childItem:= childnodes.item(i);
        childType:= childItem.nodeType;
        if (childType <> ntComment_Node) and (childType <> ntProcessing_Instruction_Node)
          then result:= concat(result,childItem.textContent);
      end;
    end;
    ntAttribute_Node,ntText_Node,ntCDATA_Section_Node,ntComment_Node,ntProcessing_Instruction_Node:
      result:= nodeValue;
    ntDocument_Type_Node,ntNotation_Node:
      result:= '';
  else
    result:= '';
  end;
end;

procedure TdomNode.writeCode(stream: TStream);
var
  i: integer;
begin
  for i:= 0 to pred(ChildNodes.Length) do
    ChildNodes.item(i).writeCode(stream);
end;

procedure TdomNode.SetPrefix(const value: wideString);
begin
  if not IsXmlName(value)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if not IsXmlPrefix(value)
    then raise ENamespace_Err.create('Namespace error.');
  if namespaceURI = ''
    then raise ENamespace_Err.create('Namespace error.');
  if (value = 'xml') and (namespaceURI <> 'http://www.w3.org/XML/1998/namespace')
    then raise ENamespace_Err.create('Namespace error.');
  if self.NodeType = ntAttribute_Node then begin
    if (value = 'xmlns')
      and not (namespaceURI ='http://www.w3.org/2000/xmlns/')
        then raise ENamespace_Err.create('Namespace error.');
    if NodeName = 'xmlns'
      then raise ENamespace_Err.create('Namespace error.');
  end;
  FPrefix:= value;
  FNodeName:= concat(value,':',localName);
end;

procedure TdomNode.setIsReadonly(const value: boolean);
begin
  FIsReadonly:= value;
end;

function TdomNode.GetChildNodes: TdomNodeList;
begin
  Result:= FNodeList;
end;

function TdomNode.GetFirstChild: TdomNode;
begin
  if FNodeListing.count = 0
    then Result:= nil
    else Result:= TdomNode(FNodeListing.First);
end;

function TdomNode.GetLastChild: TdomNode;
begin
  if FNodeListing.count = 0
    then Result:= nil
    else Result:= TdomNode(FNodeListing.Last);
end;

function TdomNode.GetPreviousSibling: TdomNode;
begin
  if assigned(ParentNode)
    then Result:= ParentNode.ChildNodes.Item(ParentNode.ChildNodes.IndexOf(Self)-1)
    else Result:= nil;
end;

function TdomNode.GetNextSibling: TdomNode;
begin
  if assigned(ParentNode)
    then Result:= ParentNode.ChildNodes.Item(ParentNode.ChildNodes.IndexOf(Self)+1)
    else Result:= nil;
end;

function TdomNode.insertBefore(const newChild,
                                     refChild: TdomNode): TdomNode;
begin
  if not assigned(newChild)
    then raise ENot_Supported_Err.create('Not supported error.');
  if not (newChild.NodeType in FAllowedChildTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if OwnerDocument <> newChild.OwnerDocument
    then raise EWrong_Document_Err.create('Wrong document error.');
  if IsAncestor(newChild) or (newChild = self) or (newChild = refChild ) // Test for circularity
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(newChild.ParentNode)
    then if newChild.ParentNode.isReadonly
      then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(refChild) then
    if FNodeListing.IndexOf(refChild) = -1
      then raise ENot_Found_Err.create('Node not found error.');
  Result:= newChild;
  if NewChild is TdomDocumentFragment then begin
    while NewChild.HasChildNodes do
      insertBefore(newChild.ChildNodes.Item(0),refChild)
  end else begin
    if assigned(newChild.parentNode)
      then newChild.parentNode.RemoveChild(newChild);
    if assigned(refChild)
      then FNodeListing.Insert(FNodeListing.IndexOf(refChild),newChild)
      else FNodeListing.Add(newChild);
    NewChild.FParentNode:= self;
  end;
end;

function TdomNode.replaceChild(const newChild,
                                     oldChild: TdomNode): TdomNode;
var
  refChild: TdomNode;
begin
  if not ( assigned(newChild) and assigned(oldChild) )
    then raise ENot_Supported_Err.create('Not supported error.');
  if not (newChild.NodeType in FAllowedChildTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if OwnerDocument <> newChild.OwnerDocument
    then raise EWrong_Document_Err.create('Wrong document error.');
  if IsAncestor(newChild) or (newChild = self) // Test for circularity
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(newChild.ParentNode)
    then if newChild.ParentNode.isReadonly
      then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FNodeListing.IndexOf(oldChild) = -1
    then raise ENot_Found_Err.create('Node not found error.');
  Result:= oldChild;
  if newChild = oldChild then exit;
  if assigned(newChild.parentNode)
    then newChild.parentNode.RemoveChild(newChild);
  refChild:= oldChild.NextSibling;
  RemoveChild(oldChild);
  if assigned(refChild)
    then insertBefore(newChild,refChild)
    else appendChild(newChild);
end;

function TdomNode.appendChild(const newChild: TdomNode): TdomNode;
begin
  if not assigned(newChild)
    then raise ENot_Supported_Err.create('Not supported error.');
  if not (newChild.NodeType in FAllowedChildTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if OwnerDocument <> newChild.OwnerDocument
    then raise EWrong_Document_Err.create('Wrong document error.');
  if IsAncestor(newChild) or (newChild = self)  // Test for circularity
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(newChild.ParentNode)
    then if newChild.ParentNode.isReadonly
      then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= newChild;
  if NewChild is TdomDocumentFragment then
    while NewChild.HasChildNodes do
      appendChild(newChild.ChildNodes.Item(0))
  else begin
    if assigned(newChild.parentNode)
      then newChild.parentNode.RemoveChild(newChild);
    FNodeListing.Add(newChild);
    NewChild.FParentNode:= self;
  end;
end;

function TdomNode.removeChild(const oldChild: TdomNode): TdomNode;
begin
  if not assigned(oldChild)
    then raise ENot_Supported_Err.create('Not supported error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FNodeListing.IndexOf(oldChild) = -1
    then raise ENot_Found_Err.create('Node not found error.');
  OwnerDocument.FindNewReferenceNodes(oldChild);
  Result:= oldChild;
  FNodeListing.Remove(oldChild);
  OldChild.FParentNode:= nil;
end;

function TdomNode.hasChildNodes: boolean;
begin
  if FNodeListing.count = 0
    then result:= false
    else result:= true;
end;

function TdomNode.cloneNode(const deep: boolean): TdomNode;
begin
  result:= ownerDocument.duplicateNode(self,deep);
end;

function TdomNode.getFirstChildElement(const name: wideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= firstChild;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node) and (nodeToTest.nodeName = name) then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.nextSibling;
  end;
end;

function TdomNode.getFirstChildElementNS(const namespaceURI,
                                               localName: WideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= firstChild;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node)
      and (nodeToTest.namespaceURI = namespaceURI)
      and (nodeToTest.localName = localName)
      then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.nextSibling;
  end;
end;

function TdomNode.getLastChildElement(const name: wideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= lastChild;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node) and (nodeToTest.nodeName = name) then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.previousSibling;
  end;
end;

function TdomNode.getLastChildElementNS(const namespaceURI,
                                              localName: WideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= lastChild;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node)
      and (nodeToTest.namespaceURI = namespaceURI)
      and (nodeToTest.localName = localName)
      then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.previousSibling;
  end;
end;

function TdomNode.getNextSiblingElement(const name: wideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= nextSibling;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node) and (nodeToTest.nodeName = name) then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.nextSibling;
  end;
end;

function TdomNode.getNextSiblingElementNS(const namespaceURI,
                                                localName: WideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= nextSibling;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node)
      and (nodeToTest.namespaceURI = namespaceURI)
      and (nodeToTest.localName = localName)
      then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.nextSibling;
  end;
end;

function TdomNode.getParentElement(const name: wideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= parentNode;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node) and (nodeToTest.nodeName = name) then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.parentNode;
  end;
end;

function TdomNode.getParentElementNS(const namespaceURI,
                                           localName: WideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= parentNode;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node)
      and (nodeToTest.namespaceURI = namespaceURI)
      and (nodeToTest.localName = localName)
      then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.parentNode;
  end;
end;

function TdomNode.getPreviousSiblingElement(const name: wideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= previousSibling;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node) and (nodeToTest.nodeName = name) then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.previousSibling;
  end;
end;

function TdomNode.getPreviousSiblingElementNS(const namespaceURI,
                                                    localName: WideString): TdomElement;
var
  nodeToTest: TdomNode;
begin
  result:= nil;
  nodeToTest:= previousSibling;
  while assigned(nodeToTest) do begin
    if (nodeToTest.nodeType = ntElement_Node)
      and (nodeToTest.namespaceURI = namespaceURI)
      and (nodeToTest.localName = localName)
      then begin
      result:= (nodeToTest as TdomElement);
      exit;
    end;
    nodeToTest:= nodeToTest.previousSibling;
  end;
end;

function TdomNode.isAncestor(const AncestorNode: TdomNode): boolean;
var
  NewAncestor: TdomNode;
  List1: TList;
begin
  Result:= false;
  NewAncestor:= ParentNode;
  List1:= TList.create;
  List1.clear;
  try
    while assigned(NewAncestor) do begin
      {Ciculation test:}
      if List1.IndexOf(NewAncestor) > -1
        then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      List1.Add(NewAncestor);
      if NewAncestor = AncestorNode then begin Result:= true; break; end;
      NewAncestor:= NewAncestor.ParentNode;
    end;
  finally
    List1.free;
  end;
end;

procedure TdomNode.normalize;
var
  i: integer;
begin
  for i:= 0 to ChildNodes.Length-1 do
    ChildNodes.Item(i).normalize;
end;

function TdomNode.supports(const feature,
                                 version: wideString): boolean;
var
  VersionStr: string;
begin
  Result:= false;
  VersionStr:= WideCharToString(PWideChar(feature));
  if (WideCharToString(PWideChar(version))='1.0')
    or (WideCharToString(PWideChar(version))='')
  then begin
    if (CompareText(VersionStr,'XML')=0)
       then Result:= true;
  end else begin
    if (WideCharToString(PWideChar(version))='2.0')
      then begin
        if (CompareText(VersionStr,'XML')=0)
           then Result:= true;
    end; {if ...}
  end; {if ... else ...}
end;

function TdomNode.validate2(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  raise ENot_Supported_Err.create('Not supported error.');
end;

function TdomNode.validateIDREFS(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  raise ENot_Supported_Err.create('Not supported error.');
end;

function TdomNode.resolveEntityReferences(const opt: TdomEntityResolveOption): boolean;
var
  i: integer;
  ok: boolean;
begin
  result:= true;
  for i:= 0 to pred(ChildNodes.Length) do begin
    ok:= ChildNodes.Item(i).resolveEntityReferences(opt);
    if not ok then result:= false;
  end;
end;



//+++++++++++++++++++++++++ TdomCharacterData ++++++++++++++++++++++++++++
constructor TdomCharacterData.create(const aOwner: TdomDocument);
begin
  inherited create(aOwner);
  FAllowedChildTypes:= [];
end;

function TdomCharacterData.getData: wideString;
begin
  Result:= NodeValue;
end;

procedure TdomCharacterData.setData(const value: wideString);
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  NodeValue:= value;
end;

function TdomCharacterData.getLength: integer;
begin
  Result:= System.Length(Data);
end;

function TdomCharacterData.substringData(const offset,
                                               count: integer):wideString;
var
  len: integer;
begin
  if(offset < 0) or (offset > Length) or (count < 0)
    then raise EIndex_Size_Err.create('Index size error.');
  // Make sure, that the length of the wideString is not
  // exeeded, when using count and offset:
  len:= Length-Offset;
  if count < len then len:= count;
  setString(Result,PWideChar(Data)+Offset,len);
end;

procedure TdomCharacterData.appendData(const arg: wideString);
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Data:= concat(Data,arg);
end;

procedure TdomCharacterData.insertData(const offset: integer;
                                       const arg: wideString);
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  ReplaceData(offset,0,arg);
end;

procedure TdomCharacterData.deleteData(const offset,
                                             count: integer);
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  ReplaceData(offset,count,'');
end;

procedure TdomCharacterData.replaceData(const offset,
                                              count: integer;
                                        const arg: wideString);
var
  len: integer;
  Data1,Data2:wideString;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if (offset < 0) or (offset > Length) or (count < 0)
    then raise EIndex_Size_Err.create('Index size error.');
  // Make sure, that the length of the wideString is not
  // exeeded, when using count and offset:
  len:= Length-Offset;
  if count < len then len:= count;
  Data1:= SubstringData(0,offset);
  Data2:= SubstringData(offset+len,Length-offset-len);
  Data:= concat(Data1,arg,Data2);
end;



// +++++++++++++++++++++++++++++ TdomAttr +++++++++++++++++++++++++++++
constructor TdomAttr.create(const aOwner: TdomDocument;
                            const name: wideString;
                            const spcfd: boolean);
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeValue:= '';
  FNodeType:= ntAttribute_Node;
  FOwnerElement:= nil;
  FSpecified:= Spcfd;
  FAllowedChildTypes:= [ntText_Node,
                        ntEntity_Reference_Node,
                        ntDocument_Fragment_Node];
end;

constructor TdomAttr.createNS(const aOwner: TdomDocument;
                              const namespaceURI,
                                    qualifiedName: wideString;
                              const spcfd: boolean);
var
  locName,prfx: wideString;
begin
  if not IsXmlName(qualifiedName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  try
    locName:= XMLExtractLocalName(qualifiedName);
    prfx:= XMLExtractPrefix(qualifiedName);
  except
    raise ENamespace_Err.create('Namespace error.');
  end;
  if ( ((prfx = 'xmlns') or (qualifiedName = 'xmlns'))
    and not (namespaceURI ='http://www.w3.org/2000/xmlns/') )
      then raise ENamespace_Err.create('Namespace error.');
  if (namespaceURI = '') and (prfx <> '')
    then raise ENamespace_Err.create('Namespace error.');
  if (prfx = 'xml') and (namespaceURI <> 'http://www.w3.org/XML/1998/namespace')
    then raise ENamespace_Err.create('Namespace error.');
  inherited create(aOwner);
  FNodeName:= qualifiedName;
  FNamespaceURI:= namespaceURI;
  FPrefix:= prfx;
  FLocalName:= locName;
  FNodeValue:= '';
  FNodeType:= ntAttribute_Node;
  FOwnerElement:= nil;
  FSpecified:= Spcfd;
  FAllowedChildTypes:= [ntText_Node,
                        ntEntity_Reference_Node,
                        ntDocument_Fragment_Node];
end;

procedure TdomAttr.normalize;
var
  PrevNode, CurrentNode: TdomNode;
  i: integer;
begin
  {normalize text:}
  PrevNode:=nil;
  i:=ChildNodes.Length;
  while i>0 do
  begin
    Dec(i);
    CurrentNode:=ChildNodes.Item(i);
    if (CurrentNode.NodeType = ntText_Node) then
      begin
         if (Assigned(PrevNode)) and (PrevNode.NodeType = ntText_Node) then
         begin
            (CurrentNode as TdomText).AppendData((PrevNode as TdomText).Data);
            removeChild(PrevNode);
            PrevNode.OwnerDocument.FreeAllNodes(PrevNode);
         end;
      end
    else  // no text node, then normalize
      CurrentNode.normalize;
    PrevNode:=CurrentNode;
  end;
end;

function TdomAttr.GetName: wideString;
begin
  Result:= NodeName;
end;

function TdomAttr.GetSpecified: boolean;
begin
  Result:= FSpecified;
end;

function TdomAttr.GetNodeValue: wideString;
begin
  Result:= getValue;
end;

function TdomAttr.getLiteralValue: wideString;
var
  i: integer;
  child: TdomNode;
begin
  Result:='';
  for i:= 0 to ChildNodes.Length -1 do begin
    child:= ChildNodes.item(i);
    case child.NodeType of
      ntText_Node:
        result:= Concat(result,xmlReplaceSpecialCharacters((child as TdomText).data));
      ntEntity_Reference_Node: begin
        result:= Concat(result,'&',child.nodeName,';');
      end;
    end;
  end; {for ...}
end;

procedure TdomAttr.SetNodeValue(const value: wideString);
begin
  setValue(value);
end;

function TdomAttr.GetValue: wideString;
  procedure FurtherAttrNormalization(var S: wideString);
  const
    DOUBLESPACE: wideString = #$20#$20;
  var
    nPos: integer;
    dummy: wideString;
  begin
    repeat
      nPos := Pos(DOUBLESPACE, S);
      if nPos > 0 then
        Delete(S, nPos, 1);
    until nPos = 0;
    dummy:= S;
    s:= XMLTruncSpace(dummy);
  end;
var
  i: integer;
  EntName: wideString;
  Entity: TdomCMEntity;
  CMAttr: TdomCMAttribute;
  child: TdomNode;
begin
  Result:='';
  for i:= 0 to ChildNodes.Length -1 do begin
    child:= ChildNodes.item(i);
    case child.NodeType of
      ntText_Node:
        Result:= Concat(Result,(child as TdomText).Data);
      ntEntity_Reference_Node: begin
        Entity:= nil;
        EntName:= (child as TdomEntityReference).NodeName;
        if (EntName='lt') then begin
          Result:= Concat(Result,wideString('&#60;'))
        end else if (EntName='gt') then begin
          Result:= Concat(Result,#62)
        end else if (EntName='amp') then begin
          Result:= Concat(Result,wideString('&#38;'))
        end else if (EntName='apos') then begin
          Result:= Concat(Result,#39)
        end else if (EntName='quot') then begin
          Result:= Concat(Result,#34)
        end else begin
          if assigned(OwnerDocument) then
            if assigned(OwnerDocument.contentModel) then
              Entity:= OwnerDocument.contentModel.entities.getNamedItem(EntName);
          if assigned(Entity) then begin
            Result:= Concat(Result,Entity.normalizedValue)
          end else raise EInvalid_Entity_Reference_Err.create('Invalid entity reference error.');
        end;
      end;
    end;
  end; {for ...}

  // Further attribute normalization:
  if assigned(OwnerElement) then
    if assigned(OwnerDocument) then
      if assigned(OwnerDocument.contentModel) then begin
        CMAttr:= OwnerDocument.contentModel.attributes.getNamedItem(OwnerElement.nodeName,nodename);
        if assigned(CMAttr) then
          if not IsXmlStringType(CMAttr.attributeType)
            then FurtherAttrNormalization(result);
      end;
end;

procedure TdomAttr.SetValue(const value: wideString);
var
  newTextNode: TdomText;
  oldChild: TdomNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  while HasChildNodes do begin
    FirstChild.setIsReadonly(false);
    oldChild:= RemoveChild(FirstChild);
    OwnerDocument.FreeAllNodes(oldChild);
  end;
  newTextNode:= OwnerDocument.CreateTextNode(value);
  appendChild(newTextNode);
end;

function TdomAttr.GetOwnerElement: TdomElement;
begin
  Result:= FOwnerElement;
end;

function TdomAttr.GetParentNode: TdomNode;
begin
  Result:= nil;
end;

function TdomAttr.GetPreviousSibling: TdomNode;
begin
  Result:= nil;
end;

function TdomAttr.GetNextSibling: TdomNode;
begin
  Result:= nil;
end;

procedure TdomAttr.writeCode(stream: TStream);
begin
  if specified then
  begin
    writeWideString(stream, NodeName);
    writeWideChars(stream, ['=', '"']);
    inherited writeCode(stream);
    writeWideChars(stream, ['"']);
  end;
end;

function TdomAttr.validate2(const errorHandler: TdomCustomErrorHandler): boolean;

  function isValidENTITY(const errorHandler: TdomCustomErrorHandler;
                         const entitiesList: TdomNamedCMEntityMap;
                         const entityValue: wideString): boolean;
  var
    e1: EParserTarget_Unparsed_Entity_Not_Found_Err;
  begin
    if not assigned(entitiesList.getNamedItem(entityValue)) then begin
      result:= false;
      e1:= EParserTarget_Unparsed_Entity_Not_Found_Err.create('Target_Unparsed_Entity_Not_Found_Err');
      try
        if assigned(errorHandler) then errorhandler.error(nil,nil,e1,entityValue);
      finally
        e1.free;
      end;
    end else result:= true;
  end;

const
  SPACE: WideChar  = #$20;
  LT: WideChar  = #60;  // '<'
var
  i,startIndex,indexCount: integer;
  ok, typeMismatch: boolean;
  attrivalue, AType: wideString;
  Attri: TdomCMAttribute;
  e0: EParserLtInAttributeValue_Err;
  e1: EParserAttribute_Definition_Not_Found_Err;
  e2: EParserAttributeValueRefersToExternalEntity_Err;
  e3: EParserMissing_Entity_Declaration_Err;
  e4: EParserDuplicate_ID_Value_Err;
  e5: EParserAttribute_Type_Mismatch_Err;
begin
  result:= true;

  try
    attriValue:= value;
  except
    // VC: Entity declared (XML 1.0, � 4.1)
    result:= false;
    e3:= EParserMissing_Entity_Declaration_Err.create('Missing_Entity_Declaration_Err');
    try
      if assigned(errorHandler) then errorhandler.error(nil,nil,e3,'');
    finally
      e3.free;
    end;
    exit; // Necessary because 'attriValue' would instead be used again in the next tests.
  end;

  // WFC: No < in Attribute Values (XML 1.0, � 3.1)
  if pos(LT,attriValue) > 0 then begin
    Result:= false;
    e0:= EParserLtInAttributeValue_Err.create('LtInAttributeValue_Err');
    try
      try
        if assigned(errorHandler) then errorhandler.fatalError(nil,nil,e0,'');
      except
      end;
    finally
      e0.free;
    end;
  end;

  // WFC: No External Entity Reference (XML 1.0, � 3.1)
  if refersToExternalEntity then begin
    Result:= false;
    e2:= EParserAttributeValueRefersToExternalEntity_Err.create('AttributeValueRefersToExternalEntity_Err');
    try
      try
        if assigned(errorHandler) then errorhandler.fatalError(nil,nil,e2,'');
      except
      end;
    finally
      e2.free;
    end;
  end;

  // VC: Attribute value Type (XML 1.0, � 3.1)
  if assigned(OwnerDocument.contentModel) and assigned(OwnerElement) then begin
    Attri:= (OwnerDocument.contentModel.attributes.GetNamedItem(OwnerElement.NodeName,NodeName) as TdomCMAttribute);
    if not assigned(Attri) then begin
      Result:= false;
      e1:= EParserAttribute_Definition_Not_Found_Err.create('Attribute_Definition_Not_Found_Err');
      try
        if assigned(errorHandler) then errorhandler.error(nil,nil,e1,'');
      finally
        e1.free;
      end;
    end else begin
      AType:= Attri.AttributeType;
      TypeMismatch:= false;
      If AType = '' then begin
        ok:= false;
        with attri do begin
          for i:= 0 to pred(ChildNodes.length) do begin
            if ChildNodes.item(i).NodeName = attriValue then begin
              ok:= true;
              break;
            end;
          end;
        end; {with ...}
        TypeMismatch:= not ok; // VC: Enumaration (XML 1.0, � 3.3.1)
      end else
      if AType = 'ID' then begin
        if not isXMLName(attriValue)
          then TypeMismatch:= true; // VC: Entity (XML 1.0, � 3.3.1)
        try
          OwnerDocument.IDs.addObject(attriValue,self);
        except  // VC: ID (XML 1.0, � 3.3.1)
          on EStringListError do begin
            Result:= false;
            e4:= EParserDuplicate_ID_Value_Err.create('Duplicate_ID_Value_Err');
            try
              if assigned(errorHandler) then errorhandler.error(nil,nil,e4,attriValue);
            finally
              e4.free;
            end;
          end;
        end;
      end else
      if AType = 'ENTITY' then begin
        // VC: Entity (XML 1.0, � 3.3.1)
        if not isXMLName(attriValue) then begin
          TypeMismatch:= true
        end else begin
          if not isValidEntity(errorHandler,ownerDocument.contentModel.entities,attriValue)
            then result:= false;
        end;
      end else
      if AType = 'ENTITIES' then begin
        // VC: Entity (XML 1.0, � 3.3.1)
        if not isXMLNames(attriValue) then begin
          TypeMismatch:= true;
        end else begin
          startIndex:= 1; indexCount:= 0;
          for i:= 1 to length(attriValue) do begin
            if attriValue[i] = SPACE then begin
              if not isValidEntity(errorHandler,ownerDocument.contentModel.entities,copy(attriValue,startIndex,IndexCount)) then result:= false;
              startIndex:= succ(i);
              indexCount:= 0;
            end else inc(indexCount);
          end;
          if not isValidEntity(errorHandler,ownerDocument.contentModel.entities,copy(attriValue,startIndex,IndexCount)) then result:= false;
        end;
      end else
      if AType = 'NMTOKEN' then begin
        if not isXmlNmtoken(attriValue)
          then TypeMismatch:= true; // VC: name Token (XML 1.0, � 3.3.1)
      end else
      if AType = 'NMTOKENS' then begin
        if not isXmlNmtokens(attriValue)
          then TypeMismatch:= true; // VC: name Token (XML 1.0, � 3.3.1)
      end;

      if TypeMismatch then begin
        Result:= false;
        e5:= EParserAttribute_Type_Mismatch_Err.create('Attribute_Type_Mismatch_Err');
        try
          if assigned(errorHandler) then errorhandler.error(nil,nil,e5,'');
        finally
          e5.free;
        end;
      end;

    end;
  end else begin
    Result:= false;
    e1:= EParserAttribute_Definition_Not_Found_Err.create('Attribute_Definition_Not_Found_Err');
    try
      if assigned(errorHandler) then errorhandler.error(nil,nil,e1,'');
    finally
      e1.free;
    end;
  end; {if assigned(OwnerDocument.contentModel) ... else ... end}

end;

function TdomAttr.validateIDREFS(const errorHandler: TdomCustomErrorHandler): boolean;
  function isValidIDREF(const errorHandler: TdomCustomErrorHandler;
                        const idList: TStringList;
                        const idrefValue: wideString): boolean;
  var
    dummyIndex: integer;
    e1: EParserTarget_ID_Value_Not_Found_Err;
  begin
    if not idList.find(idrefValue,dummyIndex) then begin
      result:= false;
      e1:= EParserTarget_ID_Value_Not_Found_Err.create('Target_ID_Value_Not_Found_Err');
      try
        if assigned(errorHandler) then errorhandler.error(nil,nil,e1,idrefValue);
      finally
        e1.free;
      end;
    end else result:= true;
  end;

const
  SPACE: WideChar  = #$20;
var
  i, startIndex, indexCount: integer;
  attrivalue, AType: wideString;
  TypeMismatch: boolean;
  Attri: TdomCMAttribute;
  e3: EParserMissing_Entity_Declaration_Err;
  e5: EParserAttribute_Type_Mismatch_Err;
begin
  result:= true;

  try
    attriValue:= value;
  except
    // VC: Entity declared (XML 1.0, � 4.1)
    result:= false;
    e3:= EParserMissing_Entity_Declaration_Err.create('Missing_Entity_Declaration_Err');
    try
      if assigned(errorHandler) then errorhandler.error(nil,nil,e3,'');
    finally
      e3.free;
    end;
    exit; // Necessary because 'attriValue' would instead be used again in the next tests.
  end;

  // VC: IDREF (XML 1.0, � 3.3.1)
  TypeMismatch:= false;
  if assigned(OwnerDocument.contentModel) and assigned(OwnerElement) then begin
    Attri:= (OwnerDocument.contentModel.attributes.GetNamedItem(OwnerElement.NodeName,NodeName) as TdomCMAttribute);
    AType:= Attri.AttributeType;
    if AType = 'IDREF' then begin
      if not isXMLName(attriValue)
        then TypeMismatch:= true
        else begin
          if not isValidIDREF(errorHandler,ownerDocument.IDs,attriValue) then result:= false;
        end;
    end else
    if AType = 'IDREFS' then begin
      if not isXMLNames(attriValue)
        then TypeMismatch:= true
        else begin
          startIndex:= 1; indexCount:= 0;
          for i:= 1 to length(attriValue) do begin
            if attriValue[i] = SPACE then begin
              if not isValidIDREF(errorHandler,ownerDocument.IDs,copy(attriValue,startIndex,IndexCount)) then result:= false;
              startIndex:= succ(i);
              indexCount:= 0;
            end else inc(indexCount);
          end;
          if not isValidIDREF(errorHandler,ownerDocument.IDs,copy(attriValue,startIndex,IndexCount)) then result:= false;
        end;
    end;
  end;

  if TypeMismatch then begin
    Result:= false;
    e5:= EParserAttribute_Type_Mismatch_Err.create('Attribute_Type_Mismatch_Err');
    try
      if assigned(errorHandler) then errorhandler.error(nil,nil,e5,'');
    finally
      e5.free;
    end;
  end;

end;

function TdomAttr.resolveEntityReferences(const opt: TdomEntityResolveOption): boolean;
var
  i: integer;
  s, childName: wideString;
  child: TdomNode;
  cmEnt: TdomCMEntity;
  parser: TXmlToDomParser;
begin
  result:= true;
  parser:= TXmlToDomParser.create(nil);
  try
    case opt of
      erReplace: begin
        S:= value;
        clear;
        parser.docWideStringToDom(S,'','',self);
      end;
      erExpand: begin  // xxx Shouldn't that be removed at all ???
        for i:= 0 to pred(childnodes.length) do begin
          child:= childnodes.item(i);
          if child.nodeType = ntEntity_Reference_Node then begin
            child.clear;
            cmEnt:= (child as TdomEntityReference).correspondingCMEntity;
            if assigned(cmEnt) then begin
              try
                S:= cmEnt.normalizedValue;
                parser.docWideStringToDom(S,'','',child);
              except
                result:= false;
              end;
            end else begin
              childName:= child.nodeName;
              if (childName='lt') then begin
                child.appendChild(ownerDocument.CreateTextNode(#60))
              end else if (childName='gt') then begin
                child.appendChild(ownerDocument.CreateTextNode(#62))
              end else if (childName='amp') then begin
                child.appendChild(ownerDocument.CreateTextNode(#38))
              end else if (childName='apos') then begin
                child.appendChild(ownerDocument.CreateTextNode(#39))
              end else if (childName='quot') then begin
                child.appendChild(ownerDocument.CreateTextNode(#34))
              end else result:= false;
            end; {if assigned(cmEnt) ...}
    // xxx setting the readonly property is missing here!
          end;
        end;
      end;
    end;
  finally
    parser.free;
  end;
end;



//++++++++++++++++++++++++++++ TdomElement ++++++++++++++++++++++++++++++++
constructor TdomElement.create(const aOwner: TdomDocument;
                               const tagName: wideString);
begin
  if not IsXmlName(tagName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= tagName;
  FNodeValue:= '';
  FNodeType:= ntElement_Node;
  FAttributeListing:= TList.create;
  FCreatedElementsNodeLists:= TList.create;
  FCreatedElementsNodeListNSs:= TList.create;
  FAttributeList:= TdomNamedNodeMap.create(aOwner,self,FAttributeListing,[ntAttribute_Node]);
  FAllowedChildTypes:= [ntElement_Node,
                        ntText_Node,
                        ntCDATA_Section_Node,
                        ntEntity_Reference_Node,
                        ntProcessing_Instruction_Node,
                        ntComment_Node,
                        ntDocument_Fragment_Node];
end;

constructor TdomElement.createNS(const aOwner: TdomDocument;
                                 const namespaceURI,
                                       qualifiedName: wideString);
var
  locName,prfx: wideString;
begin
  if not IsXmlName(qualifiedName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  try
    locName:= XMLExtractLocalName(qualifiedName);
    prfx:= XMLExtractPrefix(qualifiedName);
  except
    raise ENamespace_Err.create('Namespace error.');
  end;
  if (namespaceURI = '') and (prfx <> '')
    then raise ENamespace_Err.create('Namespace error.');
  if (prfx = 'xml') and (namespaceURI <> 'http://www.w3.org/XML/1998/namespace')
    then raise ENamespace_Err.create('Namespace error.');
  inherited create(aOwner);
  FNodeName:= qualifiedName;
  FNamespaceURI:= namespaceURI;
  FPrefix:= prfx;
  FLocalName:= locName;
  FNodeValue:= '';
  FNodeType:= ntElement_Node;
  FAttributeListing:= TList.create;
  FCreatedElementsNodeLists:= TList.create;
  FCreatedElementsNodeListNSs:= TList.create;
  FAttributeList:= TdomNamedNodeMap.create(aOwner,self,FAttributeListing,[ntAttribute_Node]);
  FAllowedChildTypes:= [ntElement_Node,
                        ntText_Node,
                        ntCDATA_Section_Node,
                        ntEntity_Reference_Node,
                        ntProcessing_Instruction_Node,
                        ntComment_Node,
                        ntDocument_Fragment_Node];
end;

destructor TdomElement.destroy;
var
  i: integer;
begin
  FAttributeList.free;
  FAttributeListing.free;
  if FCreatedElementsNodeLists <> nil then // September 5, 2001 - Borland Fix for possible AV when exception raised.
    for i := 0 to FCreatedElementsNodeLists.Count - 1 do
      TdomElementsNodeList(FCreatedElementsNodeLists[i]).free;
  if FCreatedElementsNodeListNSs <> nil then // September 5, 2001 - Borland Fix for possible AV when exception raised.
    for i := 0 to FCreatedElementsNodeListNSs.Count - 1 do
      TdomElementsNodeListNS(FCreatedElementsNodeListNSs[i]).free;
  FCreatedElementsNodeLists.free;
  FCreatedElementsNodeListNSs.free;
  inherited destroy;
end;

procedure TdomElement.SetNodeValue(const value: wideString);
begin
end;

procedure TdomElement.writeCode(stream: TStream);
var
  i: integer;
  ndName: wideString;
begin
  writeWideChars(stream, ['<']);
  ndName := NodeName;
  writeWideString(stream, ndName);
  for i:= 0 to Attributes.length -1 do
    if (Attributes.Item(i) as TdomAttr).specified then
    begin
      writeWideChars(stream, [' ']);
      Attributes.Item(i).writeCode(stream);
    end;
  writeWideChars(stream, ['>']);
  inherited writeCode(stream);
  writeWideChars(stream, ['<', '/']);
  writeWideString(stream, ndName);
  writeWideChars(stream, ['>']);
end;

procedure TdomElement.setIsReadonly(const value: boolean);
begin
  inherited setIsReadonly(value);
  Attributes.setIsReadonly(value);
end;

function TdomElement.GetTagName: wideString;
begin
  Result:= NodeName;
end;

function TdomElement.GetAttributes: TdomNamedNodeMap;
begin
  Result:= FAttributeList;
end;

function TdomElement.GetAttribute(const name: wideString): wideString;
begin
  if Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  if not assigned(GetAttributeNode(name))
    then Result:= ''
    else Result:= (Attributes.GetNamedItem(name) as TdomAttr).value;
end;

function TdomElement.SetAttribute(const name,
                                        value: wideString): TdomAttr;
var
  Attr: TdomAttr;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  Attr:= getAttributeNode(name);
  if assigned(Attr) then begin
    Attr.value:= value;
    Result:= nil;
  end else begin
    Result:= OwnerDocument.CreateAttribute(name);
    Result.value:= value;
    setAttributeNode(Result);
  end;
end;

function TdomElement.RemoveAttribute(const name: wideString): TdomAttr;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  if not assigned(GetAttributeNode(name))
    then ENot_Found_Err.create('Node not found error.');
  Result:= RemoveAttributeNode(GetAttributeNode(name));
end;

function TdomElement.GetAttributeNode(const name: wideString): TdomAttr;
begin
  if Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  Result:= TdomAttr(Attributes.GetNamedItem(name));
end;

function TdomElement.SetAttributeNode(const newAttr: TdomAttr): TdomAttr;
var
  OldAttr: TdomAttr;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  if OwnerDocument <> newAttr.OwnerDocument
    then raise EWrong_Document_Err.create('Wrong document error.');
  if assigned(newAttr.parentNode) and not (newAttr.OwnerElement = self)
    then raise EInuse_Attribute_Err.create('Inuse attribute error.');
  Result:= nil;
  if not (newAttr.OwnerElement = self) then begin
    OldAttr:= (Attributes.GetNamedItem(newAttr.name) as TdomAttr);
    if assigned(OldAttr) then Result:= RemoveAttributeNode(OldAttr);
    Attributes.SetNamedItem(newAttr);
  end;
end;

function TdomElement.RemoveAttributeNode(const OldAttr: TdomAttr): TdomAttr;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if Attributes.indexof(OldAttr) = -1
    then raise ENot_Found_Err.create('Node not found error.');
  Attributes.RemoveItem(OldAttr);
  OldAttr.FOwnerElement:= nil;
  Result:= OldAttr;
end;

function TdomElement.GetElementsByTagName(const name: wideString): TdomNodeList;
var
  i: integer;
begin
  for i:= 0 to FCreatedElementsNodeLists.Count - 1 do
    if TdomElementsNodeList(FCreatedElementsNodeLists[i]).FQueryName = name
      then begin Result:= TdomElementsNodeList(FCreatedElementsNodeLists[i]); exit; end;
  Result:= TdomElementsNodeList.create(name,self);
  FCreatedElementsNodeLists.add(Result);
end;

function TdomElement.GetAttributeNS(const namespaceURI,
                                          localName: wideString): wideString;
begin
  if not Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  if not assigned(GetAttributeNodeNS(namespaceURI,localName))
    then Result:= ''
    else Result:= (Attributes.GetNamedItemNS(namespaceURI,localName) as TdomAttr).value;
end;

function TdomElement.SetAttributeNS(const namespaceURI,
                                          qualifiedName,
                                          value: wideString): TdomAttr;
var
  Attr: TdomAttr;
  prfx, localname: wideString;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if not Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  if not IsXmlName(qualifiedName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not IsXmlQName(qualifiedName)
    then raise ENamespace_Err.create('Namespace error.');
  prfx:= XMLExtractPrefix(qualifiedName);
  if ( ((prfx = 'xmlns') or (qualifiedName = 'xmlns'))
    and not (namespaceURI ='http://www.w3.org/2000/xmlns/') )
      then raise ENamespace_Err.create('Namespace error.');
  if (namespaceURI = '') and (prfx <> '')
    then raise ENamespace_Err.create('Namespace error.');
  if (prfx = 'xml') and (namespaceURI <> 'http://www.w3.org/XML/1998/namespace')
    then raise ENamespace_Err.create('Namespace error.');
  localname:= XMLExtractLocalName(qualifiedName);
  Attr:= getAttributeNodeNS(namespaceURI,localName);
  if assigned(Attr) then begin
    Attr.FNodeName:= qualifiedName;
    Attr.value:= value;
    Result:= nil;
  end else begin
    Result:= OwnerDocument.CreateAttributeNS(namespaceURI,qualifiedName);
    Result.value:= value;
    setAttributeNodeNS(Result);
  end;
end;

function TdomElement.RemoveAttributeNS(const namespaceURI,
                                             localName: wideString): TdomAttr;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if not Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  if not assigned(GetAttributeNodeNS(namespaceURI,localName))
    then ENot_Found_Err.create('Node not found error.');
  Result:= RemoveAttributeNode(GetAttributeNodeNS(namespaceURI,localName));
end;

function TdomElement.GetAttributeNodeNS(const namespaceURI,
                                              localName: wideString): TdomAttr;
begin
  if not Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  Result:= TdomAttr(Attributes.GetNamedItemNS(namespaceURI,localName));
end;

function TdomElement.SetAttributeNodeNS(const newAttr: TdomAttr): TdomAttr;
var
  OldAttr: TdomAttr;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if not Attributes.NamespaceAware
    then raise ENamespace_Err.create('Namespace error.');
  if OwnerDocument <> newAttr.OwnerDocument
    then raise EWrong_Document_Err.create('Wrong document error.');
  if assigned(newAttr.parentNode) and not (newAttr.OwnerElement = self)
    then raise EInuse_Attribute_Err.create('Inuse attribute error.');
  Result:= nil;
  if not (newAttr.OwnerElement = self) then begin
    OldAttr:= (Attributes.GetNamedItemNS(newAttr.namespaceURI,newAttr.localName) as TdomAttr);
    if assigned(OldAttr) then Result:= RemoveAttributeNode(OldAttr);
    Attributes.SetNamedItemNS(newAttr);
  end;
end;

function TdomElement.GetElementsByTagNameNS(const namespaceURI,
                                                  localName: wideString): TdomNodeList;
var
  i: integer;
  nl: TdomElementsNodeListNS;
begin
  for i:= 0 to FCreatedElementsNodeListNSs.Count - 1 do begin
    nl:= TdomElementsNodeListNS(FCreatedElementsNodeListNSs[i]);
    if (nl.FQueryNamespaceURI = namespaceURI) and (nl.FQueryLocalName = localName)
      then begin Result:= nl; exit; end;
  end;
  Result:= TdomElementsNodeListNS.create(namespaceURI,localName,self);
  FCreatedElementsNodeListNSs.add(Result);
end;

function TdomElement.hasAttribute(const name: wideString): boolean;
begin
  Result:= assigned(Attributes.GetNamedItem(name));
end;

function TdomElement.hasAttributeNS(const namespaceURI,
                                          localName: wideString): boolean;
begin
  if Attributes.namespaceAware then
    Result := assigned(Attributes.GetNamedItemNS(namespaceURI,localName))
  else
    Result := False;
end;

procedure TdomElement.normalize;
var
  PrevNode, CurrentNode: TdomNode;
  i: integer;
begin
  {normalize text:}
  PrevNode:=nil;
  i:=ChildNodes.Length;
  while i>0 do
  begin
    Dec(i);
    CurrentNode:=ChildNodes.Item(i);
    if (CurrentNode.NodeType = ntText_Node) then
      begin
         if (Assigned(PrevNode)) and (PrevNode.NodeType = ntText_Node) then
         begin
            (CurrentNode as TdomText).AppendData((PrevNode as TdomText).Data);
            removeChild(PrevNode);
            PrevNode.OwnerDocument.FreeAllNodes(PrevNode);
         end;
      end
    else  // no text node, then normalize
      CurrentNode.normalize;
    PrevNode:=CurrentNode;
  end;

  {normalize attributes:}
  for i:= 0 to attributes.Length-1 do
    attributes.item(i).normalize;
end;

function TdomElement.validate2(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i: integer;
  ok: boolean;
  EType: TdomCMElementTypeDeclaration;
  PcdataChoice: TdomCMPcdataChoiceParticle;
  particle: TdomCMParticle;
  elementnames,rest: TStringList;
  cm: TdomCMObject;
  attri: TdomCMAttribute;
  newAttr, textAttr: TdomAttr;
  treeWalker: TdomTreeWalker;
  nodeToTest: TdomNode;
  e1: EParserElement_Type_Declaration_Not_Found_Err;
  e2: EParserElement_Declared_Empty_Has_Content_Err;
  e3: EParserElement_With_Illegal_Element_Content_Err;
  e4: EParserElement_With_Illegal_Mixed_Content_Err;
  e5: EParserRequired_Attribute_Not_Found_Err;
  e6: EParserFixed_Attribute_Mismatch_Err;
begin
  result:= true;
  cm:= OwnerDocument.contentModel;

  if assigned(cm) then begin

    // VC: Element Valid (XML 1.0, � 3)
    EType:= (cm.elementTypes.GetNamedItem(NodeName) as TdomCMElementTypeDeclaration);
    if not assigned(EType) then begin
      Result:= false;
      e1:= EParserElement_Type_Declaration_Not_Found_Err.create('Element_Type_Declaration_Not_Found_Err');
      try
        if assigned(errorHandler) then errorhandler.error(nil,nil,e1,self.NodeName);
      finally
        e1.free;
      end;
    end else begin
      treeWalker:= ownerDocument.CreateTreeWalker(self,
                                                  // Hide entity reference nodes:
                                                  [ntElement_Node,
                                                  ntAttribute_Node,
                                                  ntText_Node,
                                                  ntCDATA_Section_Node,
                                                  ntEntity_Node,
                                                  ntProcessing_Instruction_Node,
                                                  ntComment_Node,
                                                  ntDocument_Node,
                                                  ntDocument_Type_Node,
                                                  ntDocument_Fragment_Node,
                                                  ntNotation_Node],
                                                  nil,
                                                  true);
      try
        case EType.ContentspecType of
          ctEmpty: begin
            nodeToTest:= treeWalker.firstChild;
            while assigned(nodeToTest) do begin
              if not ( (nodeToTest.nodeType = ntText_Node) and (nodeToTest.nodeValue = '') ) then begin
                Result:= false;
                e2:= EParserElement_Declared_Empty_Has_Content_Err.create('Element_Declared_Empty_Has_Content_Err');
                try
                  if assigned(errorHandler) then errorhandler.error(nil,nil,e2,self.NodeName);
                finally
                  e2.free;
                end;
                break;
              end;
              nodeToTest:= treeWalker.nextSibling;
            end; {while ...}
          end;
          ctChildren: begin
            try
              elementnames:= TStringList.create;
              rest:= TStringList.create;
              try
                ok:= true;
                nodeToTest:= treeWalker.firstChild;
                while assigned(nodeToTest) do begin
                  with nodeToTest do begin
                    case nodeType of
                      ntElement_Node:
                        elementnames.Add(NodeName);
                      ntText_Node:
                        if not (isXMLS(nodeValue) or (nodeValue = '')) then begin
                          ok:= false;
                          break;
                        end;
                      else begin
                        ok:= false;
                        break;
                      end;
                    end; {case ...}
                  end; {with ...}
                  nodeToTest:= treeWalker.nextSibling;
                end; {while ...}
                if ok then begin
                  particle:= EType.firstChild as TdomCMParticle;
                  if (not particle.contentModelTest(elementnames,rest))
                    or (rest.Count > 0) then ok:= false;
                end; {if ok ...}
              finally
                elementnames.free;
                rest.free;
              end;
              if not ok then begin
                Result:= false;
                e3:= EParserElement_With_Illegal_Element_Content_Err.create('Element_With_Illegal_Element_Content_Err');
                try
                  if assigned(errorHandler) then errorhandler.error(nil,nil,e3,self.NodeName);
                finally
                  e3.free;
                end;
              end; {if ...}
            except
              on E: EParserNondeterministic_Element_Content_Model_Err do begin
                result:= false;
                if assigned(errorHandler) then if assigned(errorHandler) then errorhandler.error(nil,nil,E,'');
              end;
            end; {try}
          end;
          ctMixed: begin
            PcdataChoice:= EType.firstChild as TdomCMPcdataChoiceParticle;
            nodeToTest:= treeWalker.firstChild;
            while assigned(nodeToTest) do begin
              ok:= true;
              with nodeToTest do begin
                case nodeType of
                  ntElement_Node:
                    if assigned(PcdataChoice) then begin
                      if not PcdataChoice.elementDefined(NodeName)
                        then ok:= false;
                    end else ok:= false;
                  ntText_Node:;
                  else
                    ok:= false;
                end; {case ...}
                if not ok then begin
                  Result:= false;
                  e4:= EParserElement_With_Illegal_Mixed_Content_Err.create('Element_With_Illegal_Mixed_Content_Err');
                  try
                    if assigned(errorHandler) then errorhandler.error(nil,nil,e4,self.NodeName);
                  finally
                    e4.free;
                  end;
                end; {if ...}
              end; {with ...}
              nodeToTest:= treeWalker.nextSibling;
            end; {while ...}
          end;
        end; {case ...}
      finally
        ownerDocument.freeTreeWalker(TreeWalker);
      end; {try ...}
    end; {if not assigned(EType) ... else ... end}

    with cm.attributes do begin
      for i:= 0 to pred(length) do begin
        attri:= item(i);
        if attri.elementName = nodeName then begin
          if attri.defaultDeclaration = '#REQUIRED' then begin
            // VC: Required Attribute (XML 1.0, � 3.3.2)
            if not hasAttribute(attri.attributeName) then begin
              Result:= false;
              e5:= EParserRequired_Attribute_Not_Found_Err.create('Required_Attribute_Not_Found_Err');
              try
                if assigned(errorHandler) then errorhandler.error(nil,nil,e5,self.NodeName);
              finally
                e5.free;
              end;
            end;
          end else begin

            textAttr:= self.GetAttributeNode(attri.attributeName);
            if assigned(textAttr) then begin
              // VC: Fixed Attribute Default (XML 1.0, � 3.3.2)
              if attri.defaultDeclaration = '#FIXED' then begin
                if attri.NodeValue <> textAttr.value then begin
                  Result:= false;
                  e6:= EParserFixed_Attribute_Mismatch_Err.create('Fixed_Attribute_Mismatch_Err');
                  try
                    if assigned(errorHandler) then errorhandler.error(nil,nil,e6,self.NodeName);
                  finally
                    e6.free;
                  end;
                end;
              end;
            end else begin
              // set default attributes:
              if not (attri.defaultDeclaration = '#IMPLIED') then begin
                newAttr:= OwnerDocument.CreateAttribute(attri.AttributeName);
                newAttr.value:= attri.NodeValue;
                newAttr.FSpecified:= false;
                self.SetAttributeNode(newAttr);
              end;
            end;

          end;
        end; {if attri.elementName ...}
      end; {for ...}
    end; {with ...}

  end else begin
    Result:= false;
    e1:= EParserElement_Type_Declaration_Not_Found_Err.create('Element_Type_Declaration_Not_Found_Err');
    try
      if assigned(errorHandler) then errorhandler.error(nil,nil,e1,self.NodeName);
    finally
      e1.free;
    end;
  end; {if assigned(cm) ... else ... end}

  // validate child attributes:
  for i:= 0 to pred(attributes.length) do
    if not attributes.item(i).validate2(errorHandler)
      then result:= false;

  // validate child nodes:
  for i:= 0 to pred(childnodes.length) do
    if not childnodes.item(i).validate2(errorHandler)
      then result:= false;

end;

function TdomElement.validateIDREFS(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i: integer;
begin
  result:= true;
  for i:= 0 to pred(attributes.length) do
    if not attributes.Item(i).validateIDREFS(errorHandler)
      then result:= false;
end;

function TdomElement.resolveEntityReferences(const opt: TdomEntityResolveOption): boolean;
var
  i: integer;
  ok,hasEntRefs: boolean;
  S, childName: wideString;
  child: TdomNode;
  docFrag: TdomDocumentFragment;
  ReplacementText: TdomText;
  cmEnt: TdomCMEntity;
  parser: TXmlToDomParser;
begin
  result:= true;

  for i:= 0 to pred(attributes.Length) do begin
    ok:= attributes.Item(i).resolveEntityReferences(opt);
    if not ok then result:= false;
  end;

  case opt of
    erReplace: begin
      parser:= TXmlToDomParser.create(nil);
      try
        hasEntRefs:= false;
        i:= 0;
        while i < ChildNodes.Length do begin
          child:= ChildNodes.Item(i);
          if child.nodeType = ntEntity_Reference_Node then begin
            hasEntRefs:= true;
            cmEnt:= (child as TdomEntityReference).correspondingCMEntity;
            if assigned(cmEnt) then begin
              try
                S:= cmEnt.resolvedValue;
                docFrag:= ownerDocument.CreateDocumentFragment;
                try
                  parser.docWideStringToDom(S,'','',docFrag);
                  replaceChild(docFrag,child);
                  ownerDocument.FreeAllNodes(child);
                  dec(i); // Necessary, if an empty entity was referenced.
                finally
                  ownerDocument.FreeAllNodes(TdomNode(docFrag));
                end;
              except
                result:= false;
              end;
            end else begin
              childName:= child.nodeName;
              if (childName='lt') then begin
                ReplacementText:= ownerDocument.CreateTextNode(#60);
                replaceChild(ReplacementText,child);
                ownerDocument.FreeAllNodes(child);
              end else if (childName='gt') then begin
                ReplacementText:= ownerDocument.CreateTextNode(#62);
                replaceChild(ReplacementText,child);
                ownerDocument.FreeAllNodes(child);
              end else if (childName='amp') then begin
                ReplacementText:= ownerDocument.CreateTextNode(#38);
                replaceChild(ReplacementText,child);
                ownerDocument.FreeAllNodes(child);
              end else if (childName='apos') then begin
                ReplacementText:= ownerDocument.CreateTextNode(#39);
                replaceChild(ReplacementText,child);
                ownerDocument.FreeAllNodes(child);
              end else if (childName='quot') then begin
                ReplacementText:= ownerDocument.CreateTextNode(#34);
                replaceChild(ReplacementText,child);
                ownerDocument.FreeAllNodes(child);
              end else result:= false;
            end; {if assigned(cmEnt) ...}
          end else child.resolveEntityReferences(opt);
          inc(i);
        end; {while ...}
      finally
        parser.free;
      end;
      if hasEntRefs then normalize;
    end;
    erExpand: begin
      for i:= 0 to pred(ChildNodes.Length) do begin
        child:= ChildNodes.Item(i);
        if child.nodeType = ntEntity_Reference_Node then begin
          ok:= (child as TdomEntityReference).expand;
          if not ok then result:= false;
        end else child.resolveEntityReferences(opt);
      end; {for ...}
    end;
  end;
end;



//+++++++++++++++++++++++++++++ TdomText +++++++++++++++++++++++++++++++++
constructor TdomText.create(const aOwner: TdomDocument);
begin
  inherited create(aOwner);
  FNodeName:= '#text';
  FNodeValue:= '';
  FNodeType:= ntText_Node;
  FAllowedChildTypes:= [];
end;

function TdomText.getIsWhitespaceInElementContent: boolean;
var
  cm: TdomCMObject;
  EType: TdomCMElementTypeDeclaration;
  pNode: TdomNode;
begin
  result:= false;
  if not (isXMLS(nodeValue) or (nodeValue = '')) then exit;
  cm:= OwnerDocument.contentModel;
  if assigned(cm) then begin
    pNode:= parentNode;
    while assigned(pNode) do begin
      case pNode.nodeType of
        ntElement_Node: begin
          EType:= (cm.elementTypes.GetNamedItem(pNode.NodeName) as TdomCMElementTypeDeclaration);
          if assigned(EType)
            then if EType.ContentspecType = ctChildren
              then result:= true;
          break;
        end;
        ntEntity_Reference_Node:
          pNode:= pNode.parentNode;
      else
        break;
      end; {case ...}
    end; {while ...}
  end; {if ...}
end;

function TdomText.getLiteralValue: wideString;
begin
  result:= xmlReplaceSpecialCharacters(nodeValue);
end;

function TdomText.validate2(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;

procedure TdomText.writeCode(stream: TStream);
const
  replace60: array[0..4] of WideChar = wideString('&#60;');
  replace62: array[0..4] of WideChar = wideString('&#62;');
  replace38: array[0..4] of WideChar = wideString('&#38;');
  replace39: array[0..4] of WideChar = wideString('&#39;');
  replace34: array[0..4] of WideChar = wideString('&#34;');
var
  indx, startIndx: Integer;
  ndValue: wideString;

  procedure replaceWideChar(const replaceStrg: array of WideChar; currIndx: Integer);
  begin
    if currIndx > startIndx then
      stream.WriteBuffer(ndValue[startIndx], (currIndx - startIndx) shl 1);
    writeWideChars(stream, replaceStrg);
    startIndx := currIndx + 1;
  end;

begin
  ndValue := NodeValue;
  startIndx := 1;
  for indx := 1 to system.length(ndValue) do
  begin
    case Word(ndValue[indx]) of
      34: replaceWideChar(replace34, indx);
      38: replaceWideChar(replace38, indx);
      39: replaceWideChar(replace39, indx);
      60: replaceWideChar(replace60, indx);
      62: replaceWideChar(replace62, indx);
    end;
  end;
  if system.length(ndValue) >= startIndx then
    stream.WriteBuffer(ndValue[startIndx], (system.length(ndValue)-startIndx+1) shl 1);
end;

function TdomText.SplitText(const offset: integer): TdomText;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if(offset < 0) or (offset > Length)
    then raise EIndex_Size_Err.create('Index size error.');
  Result:= OwnerDocument.CreateTextNode(SubstringData(offset,length-offset));
  DeleteData(offset,length-offset);
  if assigned(ParentNode) then ParentNode.insertBefore(Result,self.NextSibling);
end;



//++++++++++++++++++++++++++++ TdomComment +++++++++++++++++++++++++++++++
constructor TdomComment.create(const aOwner: TdomDocument);
begin
  inherited create(aOwner);
  FNodeName:= '#comment';
  FNodeValue:= '';
  FNodeType:= ntComment_Node;
  FAllowedChildTypes:= [];
end;

function TdomComment.validate2(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;

procedure TdomComment.writeCode(stream: TStream);
begin
  writeWideStrings(stream, ['<!--', NodeValue, '-->']);
end;



//+++++++++++++++++++++ TdomProcessingInstruction +++++++++++++++++++++++++
constructor TdomProcessingInstruction.create(const aOwner: TdomDocument;
                                             const targ: wideString);
begin
  if not IsXmlPITarget(targ)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= targ;
  FNodeValue:= '';
  FNodeType:= ntProcessing_Instruction_Node;
  FAllowedChildTypes:= [];
end;

function TdomProcessingInstruction.validate2(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;

function TdomProcessingInstruction.GetTarget: wideString;
begin
  Result:= FNodeName;
end;

function TdomProcessingInstruction.GetData: wideString;
begin
  Result:= FNodeValue;
end;

procedure TdomProcessingInstruction.SetData(const value: wideString);
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  FNodeValue:= value;
end;

procedure TdomProcessingInstruction.writeCode(stream: TStream); 
begin
  writeWideStrings(stream, ['<?', NodeName, ' ', NodeValue, '?>']);
end;



//++++++++++++++++++++++++++ TdomCDATASection +++++++++++++++++++++++++++++
constructor TdomCDATASection.create(const aOwner: TdomDocument);
begin
  inherited create(aOwner);
  FNodeName:= '#cdata-section';
  FNodeValue:= '';
  FNodeType:= ntCDATA_Section_Node;
end;

function TdomCDATASection.validate2(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;

procedure TdomCDATASection.writeCode(stream: TStream);  
begin
  writeWideStrings(stream, ['<![CDATA[', NodeValue, ']]>']);
end;



//++++++++++++++++++++++++++ TdomDocumentType +++++++++++++++++++++++++++++
constructor TdomDocumentType.create(const aOwner: TdomDocument;
                                    const name,
                                          pubId,
                                          sysId,
                                          IntSubset: wideString);
begin
  inherited create(aOwner);
  FNodeValue:= '';
  FNodeName:= name;
  FPublicId:= pubId;
  FSystemId:= sysId;
  FInternalSubset:= IntSubset;
  FNodeType:= ntDocument_Type_Node;
  FAllowedChildTypes:= [];
  FEntitiesListing:= TList.create;
  FEntitiesList:= TdomEntitiesNamedNodeMap.create(aOwner,self,FEntitiesListing,[ntEntity_Node]);
  FNotationsListing:= TList.create;
  FNotationsList:= TdomNamedNodeMap.create(aOwner,self,FNotationsListing,[ntNotation_Node]);
end;

destructor TdomDocumentType.destroy;
begin
  FEntitiesListing.free;
  FEntitiesList.free;
  FNotationsListing.free;
  FNotationsList.free;
  inherited destroy;
end;

function TdomDocumentType.validate2(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;

procedure TdomDocumentType.writeCode(stream: TStream);
var
  pubId, sysId, intSubset: wideString;
begin
  writeWideStrings(stream, ['<!DOCTYPE ', NodeName]);
  writeWideChars(stream, [' ']);
  pubId := publicId;
  sysId := systemId;
  if (pubId <> '') or (sysId <> '') then
    writeWideString(stream, XMLAnalysePubSysId(pubId,sysId,''));
  intSubSet := InternalSubSet;
  if Length(intSubSet) > 0 then
  begin
    writeWideChars(stream, ['[']);
    writeWideString(stream, intSubSet);
    writeWideChars(stream, [']']);
  end;
  writeWideChars(stream, ['>']);
end;

function TdomDocumentType.GetEntities: TdomEntitiesNamedNodeMap;
begin
  Result:= FEntitiesList;
end;

function TdomDocumentType.GetInternalSubset: wideString;
begin
  Result:= FInternalSubset;
end;

function TdomDocumentType.GetName: wideString;
begin
  Result:= NodeName;
end;

function TdomDocumentType.GetNotations: TdomNamedNodeMap;
begin
  Result:= FNotationsList;
end;

function TdomDocumentType.GetPublicId: wideString;
begin
  Result:= FPublicId;
end;

function TdomDocumentType.GetSystemId: wideString;
begin
  Result:= FSystemId;
end;

procedure TdomDocumentType.SetNodeValue(const value: wideString);
begin
end;



//++++++++++++++++++++++++++ TdomNotation ++++++++++++++++++++++++++++++
constructor TdomNotation.create(const aOwner: TdomDocument;
                                const name,
                                      pubId,
                                      sysId: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if ( not ( IsXMLSystemLiteral(concat(dQuote,systemId,dQuote)) or
    IsXMLSystemLiteral(concat(sQuote,sysId,sQuote)) ) )
    and ( not ( IsXMLPubidLiteral(concat(dQuote,publicId,dQuote)) or
    IsXMLPubidLiteral(concat(sQuote,pubId,sQuote)) ) )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeValue:= '';
  FPublicId:= pubId;
  FSystemId:= sysId;
  FNodeType:= ntNotation_Node;
  FAllowedChildTypes:= [];
end;

procedure TdomNotation.SetNodeValue(const value: wideString);
begin
  // Do nothing.
end;

function TdomNotation.GetPublicId: wideString;
begin
  Result:= FPublicId;
end;

function TdomNotation.GetSystemId: wideString;
begin
  Result:= FSystemId;
end;



//+++++++++++++++++++++++++++ TdomEntity +++++++++++++++++++++++++++++++++
constructor TdomEntity.create(const aOwner: TdomDocument;
                              const name,
                                    pubId,
                                    sysId,
                                    notaName: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLSystemLiteral(concat(dQuote,sysId,dQuote)) or
           IsXMLSystemLiteral(concat(sQuote,sysId,sQuote))    )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLPubidLiteral(concat(dQuote,pubId,dQuote)) or
           IsXMLPubidLiteral(concat(sQuote,pubId,sQuote))     )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNotationName:= notaName;
  FNodeType:= ntEntity_Node;
  FIsUnusable:= false;
  FPublicId:= pubId;
  FSystemId:= sysId;
  if (pubId = '') and (sysId = '')
    then FIsInternalEntity:= true
    else FIsInternalEntity:= false;
  FEncoding:= '';
  FVersion:= '';
  FAllowedChildTypes:= [ntElement_Node,
                        ntProcessing_Instruction_Node,
                        ntComment_Node,
                        ntText_Node,
                        ntCDATA_Section_Node,
                        ntEntity_Reference_Node,
                        ntDocument_Fragment_Node];
end;

function TdomEntity.GetNotationName: wideString;
begin
  Result:= FNotationName;
end;

procedure TdomEntity.SetNodeValue(const value: wideString);
begin
  // Do nothing
end;

function TdomEntity.insertBefore(const newChild,
                                       refChild: TdomNode): TdomNode;
begin
  if (publicId <> '') or (systemId <> '')
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= inherited insertBefore(newChild,refChild);
end;

function TdomEntity.replaceChild(const newChild,
                                       oldChild: TdomNode): TdomNode;
begin
  if (publicId <> '') or (systemId <> '')
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= inherited replaceChild(newChild,oldChild);
end;

function TdomEntity.appendChild(const newChild: TdomNode): TdomNode;
begin
  if (publicId <> '') or (systemId <> '')
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= inherited appendChild(newChild);
end;



//++++++++++++++++++++++++ TdomEntityReference +++++++++++++++++++++++++
constructor TdomEntityReference.create(const aOwner: TdomDocument;
                                       const name: wideString);
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeValue:= '';
  FNodeType:= ntEntity_Reference_Node;
  FAllowedChildTypes:= [ntElement_Node,
                        ntText_Node,
                        ntCDATA_Section_Node,
                        ntEntity_Reference_Node,
                        ntProcessing_Instruction_Node,
                        ntComment_Node,
                        ntDocument_Fragment_Node];
end;

function TdomEntityReference.getCorrespondingCMEntity: TdomCMEntity;
var
  cm: TdomCMObject;
begin
  cm:= ownerDocument.contentModel;
  if assigned(cm)
    then result:= cm.Entities.getNamedItem(NodeName)
    else result:= nil;
end;

function TdomEntityReference.getRefersToPredefinedEntity: boolean;
begin
  if (nodeName = 'lt') or
     (nodeName = 'gt') or
     (nodeName = 'amp') or
     (nodeName = 'apos') or
     (nodeName = 'quot')
  then result:= true
  else result:= false;
end;

function TdomEntityReference.expand: boolean;
// Resolves the replacement text of the entity reference by the value of
// its correspondingCMEntity or by a default entity respectivly.
// Returns 'true' if successful, otherwise 'false'.
var
  S: wideString;
  cmEnt: TdomCMEntity;
  parser: TXmlToDomParser;
begin
  result:= true;
  parser:= TXmlToDomParser.create(nil);
  try
    clear;
    cmEnt:= correspondingCMEntity;
    if assigned(cmEnt) then begin
      try
        S:= cmEnt.resolvedValue;
        parser.docWideStringToDom(S,'','',self);
        // xxx setting the readonly property is missing here!
      except
        result:= false;
      end;
    end else begin
      if (nodeName='lt') then begin
        appendChild(ownerDocument.CreateTextNode(#60))
      end else if (nodeName='gt') then begin
        appendChild(ownerDocument.CreateTextNode(#62))
      end else if (nodeName='amp') then begin
        appendChild(ownerDocument.CreateTextNode(#38))
      end else if (nodeName='apos') then begin
        appendChild(ownerDocument.CreateTextNode(#39))
      end else if (nodeName='quot') then begin
        appendChild(ownerDocument.CreateTextNode(#34))
      end else result:= false;
    end; {if assigned(cmEnt) ...}
    // xxx setting the readonly property is missing here!
  finally
    parser.free;
  end;
end;

function TdomEntityReference.validate2(const errorHandler: TdomCustomErrorHandler): boolean;
var
  ent: TdomCMEntity;
  e1: EParserMissing_Entity_Declaration_Err;
  e2: EParserReferenceToUnparsedEntity_Err;
  e3: EParserNoProperMarkupReferenced_Err;
begin
  result:= true;

  // VC: Entity declared (XML 1.0, � 4.1)
  ent:= getCorrespondingCMEntity;
  if not assigned(ent) then begin
    if not refersToPredefinedEntity then begin
      result:= false;
      e1:= EParserMissing_Entity_Declaration_Err.create('Missing_Entity_Declaration_Err');
      try
        if assigned(errorHandler) then errorhandler.error(nil,nil,e1,NodeName);
      finally
        e1.free;
      end;
    end;
    exit;
  end;

  // WFC: Parsed Entity (XML 1.0, � 4.1)
  if refersToUnparsedEntity then begin
    Result:= false;
    e2:= EParserReferenceToUnparsedEntity_Err.create('ReferenceToUnparsedEntity_Err');
    try
      try
        if assigned(errorHandler) then errorhandler.fatalError(nil,nil,e2,NodeName);
      except
      end;
    finally
      e2.free;
    end;
  end;

  // WFC: Well-Formed Parsed Entities (XML 1.0, � 4.3.2)
  if ent.isUnusable then begin
    Result:= false;
    e3:= EParserNoProperMarkupReferenced_Err.create('NoProperMarkupReferenced_Err');
    try
      try
        if assigned(errorHandler) then errorhandler.fatalError(nil,nil,e3,NodeName);
      except
      end;
    finally
      e3.free;
    end; {try ...}
  end; {if ...}

end;

function TdomEntityReference.RefersToUnparsedEntity: boolean;
var
  ent: TdomCMEntity;
begin
  ent:= CorrespondingCMEntity;
  if assigned(ent)
    then result:= ent.RefersToUnparsedEntity(true)
    else if refersToPredefinedEntity
      then result:= false
      else result:= true;
end;

procedure TdomEntityReference.writeCode(stream: TStream);
begin
  writeWideChars(stream, ['&']);
  writeWideString(stream, NodeName);
  writeWideChars(stream, [';']);
end;

procedure TdomEntityReference.SetNodeValue(const value: wideString);
begin
  // Do nothing.
end;

function TdomEntityReference.CloneNode(const deep: boolean): TdomNode;
begin
  result:= inherited cloneNode(deep);
  makeChildrenReadonly;
end;

function  TdomEntityReference.resolveEntityReferences(const opt: TdomEntityResolveOption): boolean;
begin
  result:= true;
end;



//++++++++++++++++++++++++ TdomDocumentFragment +++++++++++++++++++++++++++
constructor TdomDocumentFragment.create(const aOwner: TdomDocument);
begin
  inherited create(aOwner);
  FNodeName:= '#document-fragment';
  FNodeValue:= '';
  FNodeType:= ntDocument_Fragment_Node;
  FAllowedChildTypes:= [ntElement_Node,
                        ntText_Node,
                        ntCDATA_Section_Node,
                        ntEntity_Reference_Node,
                        ntProcessing_Instruction_Node,
                        ntComment_Node,
                        ntDocument_Type_Node,
                        ntDocument_Fragment_Node];
end;

procedure TdomDocumentFragment.SetNodeValue(const value: wideString);
begin
end;



//++++++++++++++++++++++++++++ TdomDocument +++++++++++++++++++++++++++++++
constructor TdomDocument.create(const aOwner: TDomImplementation);
begin
  inherited create(self);
  FDomImpl:= aOwner;
  FNodeName:= '#document';
  FNodeValue:= '';
  FNodeType:= ntDocument_Node;
  FEncoding:= '';
  FStandalone:= '';
  FSystemId:= '';
  FVersion:= '';
  FCMInternal:= nil;
  FDefaultView:= nil;
  FCreatedNodes:= TList.create;
  FCreatedNodeIterators:= TList.create;
  FCreatedTreeWalkers:= TList.create;
  FCreatedElementsNodeLists:= TList.create;
  FCreatedElementsNodeListNSs:= TList.create;
  FIDs:= TStringList.create;
  FIDs.Sorted:= true;
  FIDs.Duplicates:= dupError;
  FAllowedChildTypes:= [ntElement_Node,
                        ntProcessing_Instruction_Node,
                        ntComment_Node,
                        ntDocument_Type_Node,
                        ntDocument_Fragment_Node];
end;

destructor TdomDocument.destroy;
begin
  clear;
  FCreatedNodes.Free;
  FCreatedNodeIterators.Free;
  FCreatedTreeWalkers.Free;
  FCreatedElementsNodeLists.free;
  FCreatedElementsNodeListNSs.free;
  FIDs.free;
  inherited destroy;
end;

function TdomDocument.ExpandEntRef(const node: TdomEntityReference): boolean;
var
  oldChild,newChildNode: TdomNode;
  newText: TdomText;
  RefEntity: TdomEntity;
  i: integer;
  previousStatus: boolean;
begin
  // xxx must be changed to interact with TdomCMObject! ?
  result:= false;
  if node.OwnerDocument <> Self
    then raise EWrong_Document_Err.create('Wrong document error.');
  if not (node.NodeType in [ntEntity_Node,ntEntity_Reference_Node])
    then raise ENot_Supported_Err.create('Not supported error.');
  with node do begin
    while HasChildNodes do begin
      FirstChild.setIsReadonly(false);
      oldChild:= RemoveChild(FirstChild);
      FreeAllNodes(oldChild);
      result:= true;
    end;
    if nodeName = 'lt' then begin
      newText:= OwnerDocument.CreateTextNode(#60);
      appendChild(newText);
      result:= true;
    end else
    if nodeName = 'gt' then begin
      newText:= OwnerDocument.CreateTextNode(#62);
      appendChild(newText);
      result:= true;
    end else
    if nodeName = 'amp' then begin
      newText:= OwnerDocument.CreateTextNode(#38);
      appendChild(newText);
      result:= true;
    end else
    if nodeName = 'apos' then begin
      newText:= OwnerDocument.CreateTextNode(#39);
      appendChild(newText);
      result:= true;
    end else
    if nodeName = 'quot' then begin
      newText:= OwnerDocument.CreateTextNode(#34);
      appendChild(newText);
      result:= true;
    end else
    if assigned(Doctype) then begin
      RefEntity:= TdomEntity(Doctype.entities.GetNamedItem(nodeName));
      if assigned(RefEntity) then begin
        if RefEntity.notationName <> ''
          then raise EInvalid_Entity_Reference_Err.create('Invalid entity reference error.');
        previousStatus:= node.isReadonly;
        node.setIsReadonly(false);
        try
          for i:= 0 to RefEntity.ChildNodes.Length-1 do begin
            newChildNode:= RefEntity.ChildNodes.Item(i).CloneNode(true);
            node.appendChild(newChildNode);
          end; {for ...}
        finally
          node.setIsReadonly(previousStatus);
        end;
        result:= true;
      end; {if ...}
    end; {if ...}
    node.makeChildrenReadonly;
  end; {with ...}
end;

procedure TdomDocument.SetNodeValue(const value: wideString);
begin
  // Do nothing.
end;

procedure TdomDocument.writeCode(stream: TStream);
var
  i: integer;
  vr,ed,sd: wideString;
begin
  if version = ''
    then vr:= '1.0'
    else vr:= version;
  if encoding = ''
    then ed:= ''
    else ed:= concat(' encoding="',encoding,'"');
  if standalone = ''
    then sd:= ''
    else sd:= concat(' standalone="',standalone,'"');
  writeWideStrings(stream, ['<?xml version="', vr, '"', ed, sd]);
  writeWideChars(stream, ['?', '>', #10]);
  for i:= 0 to ChildNodes.Length - 1 do
  begin
    ChildNodes.item(i).writeCode(stream);
    writeWideChars(stream, [#10]);
  end;
end;

procedure TdomDocument.WriteCodeAsUTF8(stream: TStream);
var
  oldEncoding: wideString;
  UTF16to8: TUTF16BEToUTF8Stream;
begin
  oldEncoding:= encoding;
  encoding:= 'UTF-8';
  try
    UTF16to8 := TUTF16BEToUTF8Stream.create(stream);
    try
      UTF16to8.ExpandLF := True;
      writeCode(UTF16to8);
    finally
      UTF16to8.Free;
    end;
  finally
    encoding:= oldEncoding;
  end;
end;

procedure TdomDocument.WriteCodeAsUTF16(stream: TStream);
var
  oldEncoding: wideString;
begin
  oldEncoding:= encoding;
  encoding:= 'UTF-16';
  try
    writeWideChars(stream, [#$feff]);
    writeCode(stream);
  finally
    encoding:= oldEncoding;
  end;
end;

procedure TdomDocument.FindNewReferenceNodes(const NodeToRemove: TdomNode);
var
  i: integer;
  refNode, refRoot: TdomNode;
begin
  for i:= 0 to FCreatedNodeIterators.count-1 do begin
    refNode:= TdomNodeIterator(FCreatedNodeIterators[i]).FReferenceNode;
    if (refNode = NodeToRemove) or refNode.IsAncestor(NodeToRemove) then begin
      refRoot:= TdomNodeIterator(FCreatedNodeIterators[i]).root;
      if NodeToRemove.IsAncestor(refRoot)
        then TdomNodeIterator(FCreatedNodeIterators[i]).FindNewReferenceNode(NodeToRemove);
    end;
  end;
end;

procedure TdomDocument.clear;
var
  i : integer;
begin
  FNodeListing.clear;
  for i := 0 to FCreatedNodes.Count - 1 do
    TdomNode(FCreatedNodes[i]).free;
  FCreatedNodes.Clear;
  for i := 0 to FCreatedNodeIterators.Count - 1 do
    TdomNodeIterator(FCreatedNodeIterators[i]).free;
  FCreatedNodeIterators.Clear;
  for i := 0 to FCreatedTreeWalkers.Count - 1 do
    TdomTreeWalker(FCreatedTreeWalkers[i]).Free;
  FCreatedTreeWalkers.Clear;
  for i := 0 to FCreatedElementsNodeLists.Count - 1 do
    TdomElementsNodeList(FCreatedElementsNodeLists[i]).free;
  FCreatedElementsNodeLists.Clear;
  for i := 0 to FCreatedElementsNodeListNSs.Count - 1 do
    TdomElementsNodeListNS(FCreatedElementsNodeListNSs[i]).free;
  FCreatedElementsNodeListNSs.Clear;
end;

procedure TdomDocument.ClearInvalidNodeIterators;
var
  i: integer;
begin
  for i:= 0 to FCreatedNodeIterators.count-1 do
  if TdomNodeIterator(FCreatedNodeIterators[i]).FInvalid then begin
    TdomNodeIterator(FCreatedNodeIterators[i]).free;
    FCreatedNodeIterators[i]:= nil;
  end;
  FCreatedNodeIterators.pack;
  FCreatedNodeIterators.Capacity:= FCreatedNodeIterators.Count;
end;

function TdomDocument.createEntity(const name,
                                         pubId,
                                         sysId,
                                         notaName: wideString): TdomEntity;
begin
  result:= TdomEntity.create(self,name,pubId,sysId,notaName);
  FCreatedNodes.add(result);
end;

function TdomDocument.createNotation(const name,
                                           pubId,
                                           sysId: wideString): TdomNotation;
begin
  result:= TdomNotation.create(self,name,pubId,sysId);
  FCreatedNodes.add(result);
end;

function TdomDocument.duplicateNode(const sourceNode: TdomNode;
                                    const deep: boolean): TdomNode;
var
  cm: TdomCMObject;
  i: integer;
  newChild: TdomNode;
  attri: TdomCMAttribute;
  newAttr, oldAttr, textAttr: TdomAttr;
begin
  case sourceNode.NodeType of
    ntAttribute_Node:
      begin
        // September 19, 2001 - Borland Fix - Proper namespace handling.
        with sourceNode do
          if localName = ''
            then result:= createAttribute(nodeName)
            else result:= createAttributeNS(namespaceURI,nodeName);
        Result.FNodeValue:= FNodeValue;
        // duplicate the text of the attribute node:
        for i:= 0 to pred(sourceNode.ChildNodes.Length) do begin
          newChild:= duplicateNode(sourceNode.ChildNodes.Item(i),true);
          Result.appendChild(newChild);
        end;
      end;
    ntCDATA_Section_Node:
      Result:= createCDATASection((sourceNode as TdomCDATASection).Data);
    ntComment_Node:
      Result:= createComment((sourceNode as TdomComment).Data);
    ntDocument_Fragment_Node:
      begin
        Result:= createDocumentFragment;
        if deep then for i:= 0 to pred(sourceNode.ChildNodes.Length) do begin
          newChild:= duplicateNode(sourceNode.ChildNodes.Item(i),true);
          Result.appendChild(newChild);
        end;
      end;
    ntElement_Node:
      begin
        Result:= createElement(sourceNode.NodeName);
        // September 19, 2001 - Borland Fix - Set NamespaceAware on Cloned Element.
        TdomElement(Result).attributes.NamespaceAware := TdomElement(sourceNode).attributes.NamespaceAware;
        // Duplicating specified attributes:
        for i:= 0 to sourceNode.attributes.Length-1 do begin
          oldAttr:= TdomAttr(sourceNode.attributes.Item(i));
          if oldAttr.specified then begin
            newChild:= duplicateNode(oldAttr,true);
            // September 19, 2001 - Borland Fix - Proper namespace handling.
            if sourceNode.attributes.namespaceAware then
              (result as TdomElement).setAttributeNodeNS((newChild as TdomAttr))
            else
              (result as TdomElement).setAttributeNode((newChild as TdomAttr));
          end;
        end; {for i:= 0 to ...}
        // Adding default attributes:
       cm:= OwnerDocument.contentModel;
       if assigned(cm) then begin
          with cm.attributes do begin
            for i:= 0 to pred(length) do begin
              attri:= item(i);
              if attri.elementName = (result as TdomElement).nodeName then begin
                if (attri.defaultDeclaration <> '#REQUIRED')
                  and (attri.defaultDeclaration <> '#IMPLIED') then begin
                  textAttr:= (result as TdomElement).getAttributeNode(attri.attributeName);
                  if not assigned(textAttr) then begin
                    newAttr:= OwnerDocument.CreateAttribute(attri.AttributeName);
                    newAttr.value:= attri.NodeValue;
                    newAttr.FSpecified:= false;
                    (result as TdomElement).SetAttributeNode(newAttr);
                  end; {if not ...}
                end; {if ...}
              end; {if ...}
            end; {with ...}
          end; {if assigned(cm) ...}
        end; {for i:= 0 to ...}
        // Duplicating child nodes:
        if deep then for i:= 0 to pred(sourceNode.ChildNodes.Length) do begin
          newChild:= duplicateNode(sourceNode.ChildNodes.Item(i),true);
          Result.appendChild(newChild);
        end;
      end;
    ntEntity_Node:
      with (sourceNode as TdomEntity) do begin
        result:= createEntity(nodeName,publicId,systemId,notationName);
        (result as TdomEntity).encoding:= encoding;
        (result as TdomEntity).version:= version;
        if deep then for i:= 0 to pred(childNodes.length) do begin
          newChild:= duplicateNode(childNodes.Item(i),true);
          result.appendChild(newChild);
        end;
      end;
    ntEntity_Reference_Node:
      begin
        Result:= createEntityReference(sourceNode.NodeName);
        (result as TdomEntityReference).expand;
      end;
    ntNotation_Node:
      with (sourceNode as TdomEntity) do begin
        result:= createNotation(nodeName,publicId,systemId);
      end;
    ntProcessing_Instruction_Node:
        Result:= createProcessingInstruction((sourceNode as TdomProcessingInstruction).target,
                                             (sourceNode as TdomProcessingInstruction).data);
    ntText_Node:
      Result:= createTextNode((sourceNode as TdomText).Data);
  else
    raise ENot_Supported_Err.create('Not supported error.');
  end;
end;

procedure TdomDocument.InitDoc(const tagName: wideString);
begin
  if not IsXmlName(tagName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if assigned (DocumentElement)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  appendChild(CreateElement(tagName));
end;

procedure TdomDocument.InitDocNS(const namespaceURI,
                                       qualifiedName: wideString);
var
  prfx: wideString;
begin
  if not IsXmlName(qualifiedName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not IsXmlQName(qualifiedName)
    then raise ENamespace_Err.create('Namespace error.');
  prfx:= XMLExtractPrefix(qualifiedName);
  if ( ((prfx = 'xmlns') or (qualifiedName = 'xmlns'))
    and not (namespaceURI ='http://www.w3.org/2000/xmlns/') )
      then raise ENamespace_Err.create('Namespace error.');
  if (namespaceURI = '') and (prfx <> '')
    then raise ENamespace_Err.create('Namespace error.');
  if (prfx = 'xml') and (namespaceURI <> 'http://www.w3.org/XML/1998/namespace')
    then raise ENamespace_Err.create('Namespace error.');
  if assigned (DocumentElement)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  appendChild(CreateElementNS(namespaceURI,qualifiedName));
end;

function  TdomDocument.removeContentModel: TdomCMObject;
begin
  if assigned(FCMInternal)
    then FCMInternal.FAssociatedDocument:= nil;
  result:= FCMInternal;
  FCMInternal:= nil;
end;

function TdomDocument.setContentModel(const arg: TdomCMObject): TdomCMObject;
begin
  result:= removeContentModel;
  if assigned(arg)
    then if assigned(arg.associatedDocument)
      then raise EInuse_Content_Model_Err.create('Inuse content model error.');
  FCMInternal:= arg;
  arg.FAssociatedDocument:= self;
end;

function TdomDocument.GetCodeAsString: String;
var
  XMLStream: TStringStream;
begin
  XMLStream := TStringStream.create('');
  try
    WriteCodeAsUTF8(XMLStream);
    Result := XMLStream.DataString;
  finally
    XMLStream.Free;
  end;
end;

function TdomDocument.GetCodeAsWideString: wideString;
var
  XMLStream: TdomWideStringStream;
begin
  XMLStream := TdomWideStringStream.create;
  try
    WriteCodeAsUTF16(XMLStream);
    Result := XMLStream.DataString;
  finally
    XMLStream.Free;
  end;
end;

function TdomDocument.GetDoctype: TdomDocumentType;
var
  Child: TdomNode;
begin
  Result:= nil;
  Child:= getFirstChild;
  while assigned(Child) do begin
    if Child.NodeType = ntDocument_Type_Node then begin
      Result:= (Child as TdomDocumentType);
      break;
    end;
    Child:= Child.NextSibling;
  end;
end;

function TdomDocument.GetDocumentElement: TdomElement;
var
  Child: TdomNode;
begin
  Result:= nil;
  Child:= getFirstChild;
  while assigned(Child) do begin
    if Child.NodeType = ntElement_Node then begin
      Result:= (Child as TdomElement);
      break;
    end;
    Child:= Child.NextSibling;
  end;
end;

function TdomDocument.CreateElement(const tagName: wideString): TdomElement;
begin
  Result:= TdomElement.create(self,tagName);
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateElementNS(const namespaceURI,
                                            qualifiedName: wideString): TdomElement;
begin
  Result:= TdomElement.createNS(self,namespaceURI,qualifiedName);
  FCreatedNodes.add(Result);
  Result.attributes.namespaceAware:= true;
end;

function TdomDocument.CreateDocumentFragment: TdomDocumentFragment;
begin
  Result:= TdomDocumentFragment.create(self);
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateTextNode(const Data: wideString): TdomText;
begin
  Result:= TdomText.create(self);
  Result.Data:= Data;
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateComment(const Data: wideString): TdomComment;
begin
  Result:= TdomComment.create(self);
  Result.Data:= Data;
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateCDATASection(const Data: wideString): TdomCDATASection;
begin
  Result:= TdomCDATASection.create(self);
  Result.Data:= Data;
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateProcessingInstruction(const targ,
                                                        Data : wideString): TdomProcessingInstruction;
begin
  Result:= TdomProcessingInstruction.create(self,targ);
  Result.Data:= Data;
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateAttribute(const name: wideString): TdomAttr;
begin
  Result:= TdomAttr.create(self,name,true);
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateAttributeNS(const namespaceURI,
                                              qualifiedName: wideString): TdomAttr;
begin
  Result:= TdomAttr.createNS(self,namespaceURI,qualifiedName,true);
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateEntityReference(const name: wideString): TdomEntityReference;
begin
  Result:= TdomEntityReference.create(self,name);
  FCreatedNodes.add(Result);
end;

function TdomDocument.CreateDocumentType(const name,
                                               pubId,
                                               sysId,
                                               IntSubset: wideString): TdomDocumentType;
begin
  Result:= TdomDocumentType.create(self,name,pubId,sysId,IntSubset);
  FCreatedNodes.add(Result);
end;

procedure TdomDocument.FreeAllNodes(var node: TdomNode);
var
  index: integer;
  oldChild: TdomNode;
  oldAttr: TdomAttr;
begin
  if not assigned(node) then exit;
  if node.OwnerDocument <> Self
    then raise EWrong_Document_Err.create('Wrong document error.');
  if node = Self
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(node.ParentNode)
    then raise EInuse_Node_Err.create('Inuse node error.');
  if node.NodeType = ntAttribute_Node then
    if assigned((node as TdomAttr).OwnerElement)
      then raise EInuse_Attribute_Err.create('Inuse attribute error.');
      // xxx notations ?
  while node.HasChildNodes do begin
    node.FirstChild.setIsReadonly(false);
    oldChild:= node.RemoveChild(node.FirstChild);
    node.OwnerDocument.FreeAllNodes(oldChild);
  end;
  case node.NodeType of
    ntElement_Node:
    while node.Attributes.Length > 0 do begin
      oldAttr:= (node.Attributes.item(0) as TdomAttr);
      oldAttr.setIsReadonly(false);
      (node as TdomElement).RemoveAttributeNode(oldAttr);
      node.OwnerDocument.FreeAllNodes(TdomNode(oldAttr));
    end;
  end; {case ...}
  index:= FCreatedNodes.IndexOf(node);
  node.free;
  FCreatedNodes.Delete(index);
  node:= nil;
end;

procedure TdomDocument.FreeTreeWalker(var TreeWalker: TdomTreeWalker);
var
  TreeWalkerIndex: integer;
begin
  if not assigned(TreeWalker) then exit;
  TreeWalkerIndex:= FCreatedTreeWalkers.IndexOf(TreeWalker);
  if TreeWalkerIndex = -1
    then raise EWrong_Document_Err.create('Wrong document error.');
  TdomTreeWalker(FCreatedTreeWalkers[TreeWalkerIndex]).free;
  FCreatedTreeWalkers.Delete(TreeWalkerIndex);
end;

function TdomDocument.GetElementById(const elementId: wideString): TdomElement;
begin
  result:= nil;
end;

function TdomDocument.GetElementsByTagName(const tagName: wideString): TdomNodeList;
var
  i: integer;
begin
  for i:= 0 to FCreatedElementsNodeLists.Count - 1 do
    if TdomElementsNodeList(FCreatedElementsNodeLists[i]).FQueryName = tagName
      then begin Result:= TdomElementsNodeList(FCreatedElementsNodeLists[i]); exit; end;
  Result:= TdomElementsNodeList.create(tagName,self);
  FCreatedElementsNodeLists.add(Result);
end;

function TdomDocument.GetElementsByTagNameNS(const namespaceURI,
                                                   localName: wideString): TdomNodeList;
var
  i: integer;
  nl: TdomElementsNodeListNS;
begin
  for i:= 0 to FCreatedElementsNodeListNSs.Count - 1 do begin
    nl:= TdomElementsNodeListNS(FCreatedElementsNodeListNSs[i]);
    if (nl.FQueryNamespaceURI = namespaceURI) and (nl.FQueryLocalName = localName)
      then begin Result:= nl; exit; end;
  end;
  Result:= TdomElementsNodeListNS.create(namespaceURI,localName,self);
  FCreatedElementsNodeListNSs.add(Result);
end;

function TdomDocument.importNode(const importedNode: TdomNode;
                                 const deep: boolean): TdomNode;
begin
  result:= duplicateNode(importedNode,deep);
end;

function TdomDocument.insertBefore(const newChild,
                                         refChild: TdomNode): TdomNode;
begin
  if not assigned(newChild)
    then raise ENot_Supported_Err.create('Not supported error.');
  case newChild.NodeType of
    ntElement_Node: begin
      if assigned(DocType) then begin
        if DocType.NodeName <> newChild.NodeName
          then raise EInvalid_Character_Err.create('Invalid character error.');
        if ChildNodes.IndexOf(DocType) >= ChildNodes.IndexOf(refChild)
          then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      end;
      if assigned(DocumentElement)
        then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      Result:= inherited insertBefore(newChild,refChild);
      end;
    ntDocument_Type_Node: begin
      if assigned(DocumentElement) then begin
        if DocumentElement.NodeName <> newChild.NodeName
          then raise EInvalid_Character_Err.create('Invalid character error.');
        if ChildNodes.IndexOf(DocumentElement) < ChildNodes.IndexOf(refChild)
          then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      end;
      if assigned(DocType)
        then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      Result:= inherited insertBefore(newChild,refChild);
      end;
    ntProcessing_Instruction_Node,ntComment_Node,ntDocument_Fragment_Node:
      Result:= inherited insertBefore(newChild,refChild);
  else
    raise EHierarchy_Request_Err.create('Hierarchy request error.');
  end;
end;

function TdomDocument.replaceChild(const newChild,
                                         oldChild: TdomNode): TdomNode;
begin
  if not ( assigned(newChild) and assigned(oldChild) )
    then raise ENot_Supported_Err.create('Not supported error.');
  case newChild.NodeType of
    ntElement_Node: begin
      if assigned(DocumentElement) and (DocumentElement <> oldChild)
        then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      if assigned(DocType) then
        if DocType.NodeName <> newChild.NodeName
          then raise EInvalid_Character_Err.create('Invalid character error.');
      Result:= inherited replaceChild(newChild,oldChild);
      end;
    ntDocument_Type_Node: begin
      if assigned(DocType) and (DocType <> oldChild)
        then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      if assigned(DocumentElement)
        then if DocumentElement.NodeName <> newChild.NodeName
          then raise EInvalid_Character_Err.create('Invalid character error.');
      Result:= inherited replaceChild(newChild,oldChild);
      end;
    ntProcessing_Instruction_Node,ntComment_Node,
    ntDocument_Fragment_Node:
      Result:= inherited replaceChild(newChild,oldChild);
  else
    raise EHierarchy_Request_Err.create('Hierarchy request error.');
  end;
end;

function TdomDocument.appendChild(const newChild: TdomNode): TdomNode;
begin
  if not assigned(newChild)
    then raise ENot_Supported_Err.create('Not supported error.');
  case newChild.NodeType of
    ntElement_Node: begin
      if assigned(DocumentElement)
        then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      Result:= inherited appendChild(newChild);
      end;
    ntDocument_Type_Node: begin
      if assigned(Doctype) or assigned(DocumentElement)
        then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      Result:= inherited appendChild(newChild);
      end;
    ntProcessing_Instruction_Node,ntComment_Node,
    ntDocument_Fragment_Node:
      Result:= inherited appendChild(newChild);
  else
    raise EHierarchy_Request_Err.create('Hierarchy request error.');
  end;
end;

function TdomDocument.CreateNodeIterator(const root: TdomNode;
                                               whatToShow: TdomWhatToShow;
                                               nodeFilter: TdomNodeFilter;
                                               entityReferenceExpansion: boolean): TdomNodeIterator;
begin
  Result:= TdomNodeIterator.create(root,whatToShow,nodeFilter,entityReferenceExpansion);
  FCreatedNodeIterators.add(Result);
end;

function TdomDocument.CreateTreeWalker(const root: TdomNode;
                                             whatToShow: TdomWhatToShow;
                                             nodeFilter: TdomNodeFilter;
                                             entityReferenceExpansion: boolean): TdomTreeWalker;
begin;
  Result:= TdomTreeWalker.create(root,whatToShow,nodeFilter,entityReferenceExpansion);
  FCreatedTreeWalkers.add(Result);
end;

function TdomDocument.validate(const errorHandler: TdomCustomErrorHandler;
                               const opt: TdomEntityResolveOption): boolean;
var
  e1: EParserWrong_Root_Element_Type_Err;
  e2: EParserUnresolvable_Entity_Reference_Err;
  i: integer;
  ok: boolean;
begin
  result:= true;

  if not assigned(documentElement)
    then raise EParserRootNotFound_Err.create('Root not found error.');

  if assigned(docType) then begin
    if assigned(contentModel)
      then if not contentModel.validate(errorHandler)
        then result:= false;
  end;

  ok:= resolveEntityReferences(opt);
  if not ok then begin
    result:= false;
    e2:= EParserUnresolvable_Entity_Reference_Err.create('Unresolvable_Entity_Reference_Err');
    try
      if assigned(errorHandler) then errorhandler.error(nil,nil,e2,'');
    finally
      e2.free;
    end;
  end;

  // VC: Root Element Type (XML 1.0, � 2.8)
  if assigned(docType) then begin
    if docType.name <> documentElement.NodeName then begin
      Result:= false;
      e1:= EParserWrong_Root_Element_Type_Err.create('Wrong_Root_Element_Type_Err');
      try
        if assigned(errorHandler) then errorhandler.error(nil,nil,e1,'');
      finally
        e1.free;
      end;
    end;
  end;

  IDs.clear;
  for i:= 0 to pred(childnodes.length) do begin
    if not childnodes.item(i).validate2(errorHandler)
      then result:= false;
  end;
  if not result then IDs.clear
  else begin
    // VC: IDREF (XML 1.0, � 3.3.1)
    // Second parse only for IDREF and IDREFS:
    if not validateIDREFs(errorHandler)
      then result:= false;
  end;
end;

function TdomDocument.validateIDREFS(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= documentElement.validateIDREFS(errorHandler);
end;



//+++++++++++++++++++++++++ TdomCMNodeList +++++++++++++++++++++++++++++
constructor TdomCMNodeList.create(const CMNodeList: TList);
begin
  inherited create;
  FCMNodeList:= CMNodeList;
end;

function TdomCMNodeList.GetLength: integer;
begin
  Result:= FCMNodeList.count;
end;

function TdomCMNodeList.IndexOf(const node: TdomCMNode): integer;
begin
  Result:= FCMNodeList.IndexOf(node);
end;

function TdomCMNodeList.Item(const index: integer): TdomCMNode;
begin
  if (index < 0) or (index + 1 > FCMNodeList.count)
    then Result:= nil
    else Result:= TdomCMNode(FCMNodeList.Items[index]);
end;


//+++++++++++++++++++++++ TdomNamedCMNodeMap +++++++++++++++++++++++++++
constructor TdomNamedCMNodeMap.create(const aOwner,
                                            aOwnerNode: TdomCMNode;
                                      const nodeList: TList;
                                      const allowedNTs: TDomCMNodeTypeSet);
begin
  inherited create(nodeList);
  FOwner:= aOwner;
  FOwnerNode:= aOwnerNode;
  FAllowedNodeTypes:= allowedNTs;
  FIsReadonly:= false;
end;

function TdomNamedCMNodeMap.getOwnerNode: TdomCMNode;
begin
  Result:= FOwnerNode;
end;

function TdomNamedCMNodeMap.RemoveItem(const arg: TdomCMNode): TdomCMNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FCMNodeList.IndexOf(arg) = -1
    then raise ENot_Found_Err.create('Node not found error.');
  Result:= arg;
  FCMNodeList.Remove(arg);
  Result.FParentNode:= nil;
end;

procedure TdomNamedCMNodeMap.setIsReadonly(const value: boolean);
begin
  FIsReadonly:= value;
end;

function TdomNamedCMNodeMap.GetNamedIndex(const name: wideString): integer;
var
  i: integer;
begin
  result:= -1;
  for i:= 0 to FCMNodeList.count-1 do
    if (TdomCMNode(FCMNodeList[i]).NodeName = name)
      and (TdomCMNode(FCMNodeList[i]).NodeType in FAllowedNodeTypes) then begin
      Result:= i;
      break;
    end;
end;

function TdomNamedCMNodeMap.GetNamedItem(const name: wideString): TdomCMNode;
var
  i: integer;
begin
  result:= nil;
  for i:= 0 to FCMNodeList.count-1 do
    if (TdomCMNode(FCMNodeList[i]).NodeName = name)
      and (TdomCMNode(FCMNodeList[i]).NodeType in FAllowedNodeTypes) then begin
      Result:= TdomCMNode(FCMNodeList[i]);
      break;
    end;
end;

function TdomNamedCMNodeMap.SetNamedItem(const arg: TdomCMNode): TdomCMNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FOwner.OwnerCMObject <> arg.OwnerCMObject
    then raise EWrong_Document_Err.create('Wrong document error.');
  if not (arg.NodeType in FAllowedNodeTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if assigned(arg.parentNode)
    then raise EInuse_Node_Err.create('Inuse node error.');
  if assigned(GetNamedItem(arg.NodeName))
    then Result:= RemoveNamedItem(arg.NodeName)
    else Result:= nil;
  FCMNodeList.Add(arg);
  arg.FParentNode:= nil;
end;

function TdomNamedCMNodeMap.RemoveNamedItem(const name: wideString): TdomCMNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= getNamedItem(name);
  if not assigned(Result)
    then raise ENot_Found_Err.create('Node not found error.');
  FCMNodeList.Remove(Result);
end;



// ++++++++++++++++++++++ TdomNamedCMAttributeMap ++++++++++++++++++++++
constructor TdomNamedCMAttributeMap.create(const aOwner: TdomCMObject);
begin
  inherited create;
  FOwner:= aOwner;
  FCMAttributesList:= TList.create;
end;

destructor TdomNamedCMAttributeMap.destroy;
begin
  FCMAttributesList.free;
  inherited destroy;
end;

function TdomNamedCMAttributeMap.GetLength: integer;
begin
  result:= FCMAttributesList.count;
end;

function TdomNamedCMAttributeMap.item(const index: integer): TdomCMAttribute;
begin
  if (index < 0) or (index + 1 > FCMAttributesList.count)
    then Result:= nil
    else Result:= TdomCMAttribute(FCMAttributesList.Items[index]);
end;

function TdomNamedCMAttributeMap.GetNamedItem(const elementName,
                                                    attributeName: wideString): TdomCMAttribute;
var
  i: integer;
  cmAttr: TdomCMAttribute;
begin
  result:= nil;
  for i:= 0 to FCMAttributesList.count-1 do begin
    cmAttr:= TdomCMAttribute(FCMAttributesList[i]);
    if (cmAttr.elementName = elementName) and (cmAttr.attributeName = attributeName)
      then begin Result:= cmAttr; break; end;
  end;
end;

function TdomNamedCMAttributeMap.appendNamedItem(const arg: TdomCMAttribute): boolean;
begin
  if FOwner.OwnerCMObject <> arg.OwnerCMObject
    then raise EWrong_Document_Err.create('Wrong document error.');
  if assigned(arg.parentNode)
    then raise EInuse_Node_Err.create('Inuse node error.');
  if assigned(GetNamedItem(arg.elementName,arg.attributeName)) then begin
    result:= false;
  end else begin
    result:= true;
    FCMAttributesList.Add(arg);
    arg.FParentNode:= FOwner;
    arg.FCMObject:= FOwner;
  end; {if ...}
end;

function TdomNamedCMAttributeMap.removeLastItem: TdomCMAttribute;
begin
  with FCMAttributesList do begin
    result:= Last;
    if not assigned(result)
      then raise ENot_Found_Err.create('Node not found error.');
    remove(Last);
  end;
  Result.FCMObject:= nil;
  Result.FParentNode:= nil;
end;



// +++++++++++++++++++++++ TdomNamedCMEntityMap +++++++++++++++++++++++
constructor TdomNamedCMEntityMap.create(const aOwner: TdomCMObject);
begin
  inherited create;
  FOwner:= aOwner;
  FCMEntitiesList:= TList.create;
end;

destructor TdomNamedCMEntityMap.destroy;
begin
  FCMEntitiesList.free;
  inherited destroy;
end;

function TdomNamedCMEntityMap.GetLength: integer;
begin
  result:= FCMEntitiesList.count;
end;

function TdomNamedCMEntityMap.item(const index: integer): TdomCMEntity;
begin
  if (index < 0) or (index + 1 > FCMEntitiesList.count)
    then Result:= nil
    else Result:= TdomCMEntity(FCMEntitiesList.Items[index]);
end;

function TdomNamedCMEntityMap.GetNamedItem(const name: wideString): TdomCMEntity;
var
  i: integer;
begin
  result:= nil;
  for i:= 0 to FCMEntitiesList.count-1 do
    if (TdomCMEntity(FCMEntitiesList[i]).NodeName = name) then begin
      Result:= TdomCMEntity(FCMEntitiesList[i]);
      break;
    end;
end;

function TdomNamedCMEntityMap.appendNamedItem(const arg: TdomCMEntity): boolean;
begin
  if FOwner.OwnerCMObject <> arg.OwnerCMObject
    then raise EWrong_Document_Err.create('Wrong document error.');
  if assigned(arg.parentNode)
    then raise EInuse_Node_Err.create('Inuse node error.');
  if assigned(GetNamedItem(arg.NodeName)) then begin
    result:= false;
  end else begin
    // Append 'arg':
    result:= true;
    FCMEntitiesList.Add(arg);
    arg.FParentNode:= FOwner;
  end; {if ...}
end;

function TdomNamedCMEntityMap.removeLastItem: TdomCMEntity;
begin
  with FCMEntitiesList do begin
    result:= Last;
    if not assigned(result)
      then raise ENot_Found_Err.create('Node not found error.');
    remove(Last);
  end;
  Result.FParentNode:= nil;
end;



//+++++++++++++++++++++++++++ TdomCMNode +++++++++++++++++++++++++++++++
constructor TdomCMNode.create(const aOwner: TdomCustomCMObject);
begin
  inherited create;
  FCMObject:= aOwner;
  FParentNode:= nil;
  FCMNodeListing:= TList.create;
  FCMNodeList:= TdomCMNodeList.create(FCMNodeListing);
  FNodeName:= '';
  FNodeValue:= '';
  FNodeType:= ctUnknown;
  FAllowedChildTypes:= [];
  FIsReadonly:= false;
end;

destructor TdomCMNode.destroy;
begin
  FCMNodeListing.free;
  FCMNodeList.free;
  inherited destroy;
end;

procedure TdomCMNode.clear;
var
  oldCMChild: TdomCMNode;
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  while hasChildNodes do begin
    firstChild.setIsReadonly(false);
    oldCMChild:= removeChild(firstChild);
    OwnerCMObject.FreeAllCMNodes(oldCMChild);
  end;
end;

procedure TdomCMNode.makeChildrenReadonly;
var
  i: integer;
begin
  with childnodes do
    for i:= 0 to pred(length) do
      with item(i) do begin
        item(i).setIsReadonly(true);
        item(i).makeChildrenReadonly;
      end;
end;

function TdomCMNode.GetNodeName: wideString;
begin
  Result:= FNodeName;
end;

function TdomCMNode.GetNodeValue: wideString;
begin
  Result:= FNodeValue;
end;

procedure TdomCMNode.SetNodeValue(const value: wideString);
begin
  if isReadonly = true
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  FNodeValue:= value;
end;

function TdomCMNode.GetCMNodeType: TdomCMNodeType;
begin
  Result:= FNodeType;
end;

function TdomCMNode.GetParentNode: TdomCMNode;
begin
  Result:= FParentNode;
end;

function TdomCMNode.GetCMObject: TdomCustomCMObject;
begin
  Result:= FCMObject;
end;

function TdomCMNode.GetCode: wideString;
var
  XMLStream: TdomWideStringStream;
begin
  XMLStream := TdomWideStringStream.create;
  try
    writeCode(XMLStream);
    Result := XMLStream.DataString;
  finally
    XMLStream.Free;
  end;
end;

procedure TdomCMNode.writeCode(stream: TStream);
var
  i: integer;
begin
  for i:= 0 to pred(ChildNodes.Length) do
    ChildNodes.item(i).writeCode(stream);
end;

function TdomCMNode.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  raise ENot_Supported_Err.create('Not supported error.');
end;

procedure TdomCMNode.setIsReadonly(const value: boolean);
begin
  FIsReadonly:= value;
end;

function TdomCMNode.GetChildNodes: TdomCMNodeList;
begin
  Result:= FCMNodeList;
end;

function TdomCMNode.GetFirstChild: TdomCMNode;
begin
  if FCMNodeListing.count = 0
    then Result:= nil
    else Result:= TdomCMNode(FCMNodeListing.First);
end;

function TdomCMNode.GetLastChild: TdomCMNode;
begin
  if FCMNodeListing.count = 0
    then Result:= nil
    else Result:= TdomCMNode(FCMNodeListing.Last);
end;

function TdomCMNode.GetPreviousSibling: TdomCMNode;
begin
  if assigned(ParentNode)
    then Result:= ParentNode.ChildNodes.Item(ParentNode.ChildNodes.IndexOf(Self)-1)
    else Result:= nil;
end;

function TdomCMNode.GetNextSibling: TdomCMNode;
begin
  if assigned(ParentNode)
    then Result:= ParentNode.ChildNodes.Item(ParentNode.ChildNodes.IndexOf(Self)+1)
    else Result:= nil;
end;

function TdomCMNode.insertBefore(const newChild,
                                       refChild: TdomCMNode): TdomCMNode;
begin
  if not assigned(newChild)
    then raise ENot_Supported_Err.create('Not supported error.');
  if not (newChild.NodeType in FAllowedChildTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if OwnerCMObject <> newChild.OwnerCMObject
    then raise EWrong_Document_Err.create('Wrong document error.');
  if isAncestor(newChild) or (newChild = self) or (newChild = refChild ) // Test for circularity
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(newChild.ParentNode)
    then if newChild.ParentNode.isReadonly
      then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(refChild) then
    if FCMNodeListing.IndexOf(refChild) = -1
      then raise ENot_Found_Err.create('Node not found error.');
  Result:= newChild;
  if NewChild is TdomCMFragment
    then while NewChild.HasChildNodes do
      insertBefore(newChild.ChildNodes.Item(0),refChild)
    else begin
      if assigned(newChild.parentNode) then newChild.parentNode.RemoveChild(newChild);
      if assigned(refChild)
        then FCMNodeListing.Insert(FCMNodeListing.IndexOf(refChild),newChild)
        else FCMNodeListing.Add(newChild);
      NewChild.FParentNode:= self;
    end;
end;

function TdomCMNode.replaceChild(const newChild,
                                       oldChild: TdomCMNode): TdomCMNode;
var
  refChild: TdomCMNode;
begin
  if not ( assigned(newChild) and assigned(oldChild) )
    then raise ENot_Supported_Err.create('Not supported error.');
  if not (newChild.NodeType in FAllowedChildTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if OwnerCMObject <> newChild.OwnerCMObject
    then raise EWrong_Document_Err.create('Wrong document error.');
  if IsAncestor(newChild) or (newChild = self) // Test for circularity
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(newChild.ParentNode)
    then if newChild.ParentNode.isReadonly
      then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FCMNodeListing.IndexOf(oldChild) = -1
    then raise ENot_Found_Err.create('Node not found error.');
  Result:= oldChild;
  if newChild = oldChild then exit;
  if assigned(newChild.parentNode) then newChild.parentNode.RemoveChild(newChild);
  refChild:= oldChild.NextSibling;
  RemoveChild(oldChild);
  if assigned(refChild)
    then insertBefore(newChild,refChild)
    else appendChild(newChild);
end;

function TdomCMNode.removeChild(const oldChild: TdomCMNode): TdomcmNode;
begin
  if not assigned(oldChild)
    then raise ENot_Supported_Err.create('Not supported error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if FCMNodeListing.IndexOf(oldChild) = -1
    then raise ENot_Found_Err.create('Node not found error.');
  Result:= oldChild;
  FCMNodeListing.Remove(oldChild);
  OldChild.FParentNode:= nil;
end;

function TdomCMNode.appendChild(const newChild: TdomCMNode): TdomCMNode;
begin
  if not assigned(newChild)
    then raise ENot_Supported_Err.create('Not supported error.');
  if not (newChild.NodeType in FAllowedChildTypes)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if OwnerCMObject <> newChild.OwnerCMObject
    then raise EWrong_Document_Err.create('Wrong document error.');
  // Test for circularity:
  if IsAncestor(newChild) or (newChild = self)
    then raise EHierarchy_Request_Err.create('Hierarchy request error.');
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(newChild.ParentNode)
    then if newChild.ParentNode.isReadonly
      then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= newChild;
  if NewChild is TdomCMFragment then
    while NewChild.HasChildNodes do
      appendChild(newChild.ChildNodes.Item(0))
  else begin
    if assigned(newChild.parentNode) then newChild.parentNode.RemoveChild(newChild);
    FCMNodeListing.Add(newChild);
    NewChild.FParentNode:= self;
  end;
end;

function TdomCMNode.HasChildNodes: boolean;
begin
  if FCMNodeListing.count = 0
    then result:= false
    else result:= true;
end;

function TdomCMNode.CloneNode(const deep: boolean): TdomCmNode;
var
  newChildNode: TdomCMNode;
  i: integer;
begin
  Result:= OwnerCMObject.DuplicateCMNode(self);
  if deep then for i:= 0 to ChildNodes.Length-1 do
  begin
    newChildNode:= ChildNodes.Item(i).CloneNode(true);
    Result.appendChild(newChildNode);
  end;
end;

function TdomCMNode.IsAncestor(const AncestorNode: TdomCMNode): boolean;
var
  NewAncestor: TdomCMNode;
  List1: TList;
begin
  Result:= false;
  NewAncestor:= ParentNode;
  List1:= TList.create;
  List1.clear;
  try
    while assigned(NewAncestor) do begin
      {Ciculation test:}
      if List1.IndexOf(NewAncestor) > -1
        then raise EHierarchy_Request_Err.create('Hierarchy request error.');
      List1.Add(NewAncestor);
      if NewAncestor = AncestorNode then begin Result:= true; break; end;
      NewAncestor:= NewAncestor.ParentNode;
    end;
  finally
    List1.free;
  end;
end;



// +++++++++++++++++++++++++++ TdomCMComment +++++++++++++++++++++++++++
constructor TdomCMComment.create(const aOwner: TdomCustomCMObject);
begin
  inherited create(aOwner);
  FNodeName:= '#comment';
  FNodeValue:= '';
  FNodeType:= ctComment;
  FAllowedChildTypes:= [];
end;

procedure TdomCMComment.writeCode(stream: TStream);
begin
  writeWideStrings(stream, ['<!--', NodeValue, '-->']);
end;

function TdomCMComment.GetData: wideString;
begin
  Result:= NodeValue;
end;

procedure TdomCMComment.SetData(const value: wideString);
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  NodeValue:= value;
end;

function TdomCMComment.GetLength: integer;
begin
  Result:= System.Length(Data);
end;

function TdomCMComment.SubstringData(const offset,
                                           count: integer):wideString;
var
  len: integer;
begin
  if(offset < 0) or (offset > Length) or (count < 0)
    then raise EIndex_Size_Err.create('Index size error.');
  // Make sure, that the length of the wideString is not
  // exeeded, when using count and offset:
  len:= Length-Offset;
  if count < len then len:= count;
  setString(Result,PWideChar(Data)+Offset,len);
end;

procedure TdomCMComment.AppendData(const arg: wideString);
begin
  Data:= concat(Data,arg);
end;

procedure TdomCMComment.InsertData(const offset: integer;
                                   const arg: wideString);
begin
  ReplaceData(offset,0,arg);
end;

procedure TdomCMComment.DeleteData(const offset,
                                         count: integer);
begin
  ReplaceData(offset,count,'');
end;

procedure TdomCMComment.replaceData(const offset,
                                          count: integer;
                                    const arg: wideString);
var
  len: integer;
  Data1,Data2:wideString;
begin
  if(offset < 0) or (offset > Length) or (count < 0)
    then raise EIndex_Size_Err.create('Index size error.');
  // Make sure, that the length of the wideString is not
  // exeeded, when using count and offset:
  len:= Length-Offset;
  if count < len then len:= count;
  Data1:= SubstringData(0,offset);
  Data2:= SubstringData(offset+len,Length-offset-len);
  Data:= concat(Data1,arg,Data2);
end;

function TdomCMComment.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;


//++++++++++++++++++ TdomCMProcessingInstruction +++++++++++++++++++++++
constructor TdomCMProcessingInstruction.create(const aOwner: TdomCustomCMObject;
                                               const targ: wideString);
begin
  if not IsXmlPITarget(targ)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= targ;
  FNodeValue:= '';
  FNodeType:= ctProcessingInstruction;
  FAllowedChildTypes:= [];
end;

function TdomCMProcessingInstruction.GetTarget: wideString;
begin
  Result:= FNodeName;
end;

function TdomCMProcessingInstruction.GetData: wideString;
begin
  Result:= FNodeValue;
end;

procedure TdomCMProcessingInstruction.SetData(const value: wideString);
begin
  if isReadonly
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  FNodeValue:= value;
end;

procedure TdomCMProcessingInstruction.writeCode(stream: TStream);
begin
  writeWideStrings(stream, ['<?', NodeName, ' ', NodeValue, '?>']);
end;

function TdomCMProcessingInstruction.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



// +++++++++++++++++++++++++ TdomCustomCMObject ++++++++++++++++++++++++
constructor TdomCustomCMObject.create(const aOwner: TdomImplementation);
begin
  inherited create(self);
  FDomImpl:= aOwner;
  FNodeValue:= '';
  FCreatedNodes:= TList.create;
  FAllowedChildTypes:= [];
end;

destructor TdomCustomCMObject.destroy;
var
  i: integer;
begin
  for i := 0 to pred(FCreatedNodes.Count) do
    TdomCMNode(FCreatedNodes[i]).free;
  FCreatedNodes.free;
  inherited destroy;
end;

procedure TdomCustomCMObject.SetNodeValue(const value: wideString);
begin
end;

function TdomCustomCMObject.CreateCMAttributeDefinition(const name,
                                                              attType,
                                                              defaultDecl,
                                                              attValue: wideString) : TdomCMAttrDefinition;
begin
  Result:= TdomCMAttrDefinition.create(self,name,attType,defaultDecl,attValue);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMAttributeList(const name: wideString): TdomCMAttrList;
begin
  Result:= TdomCMAttrList.create(self,name);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMChoiceParticle(const freq: wideString): TdomCMChoiceParticle;
begin
  Result:= TdomCMChoiceParticle.create(self,freq);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMComment(const Data: wideString): TdomCMComment;
begin
  Result:= TdomCMComment.create(self);
  Result.Data:= Data;
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMElementParticle(const name,
                                                          freq: wideString): TdomCMElementParticle;
begin
  Result:= TdomCMElementParticle.create(self,name,freq);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMElementTypeDeclaration(const name: wideString;
                                                           const contspecType: TdomContentspecType): TdomCMElementTypeDeclaration;
begin
  Result:= TdomCMElementTypeDeclaration.create(self,name,contspecType);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMEntityDeclaration(const name,
                                                            entityValue,
                                                            pubId,
                                                            sysId,
                                                            notaName: wideString): TdomCMEntityDeclaration;
begin
  Result:= TdomCMEntityDeclaration.create(self,name,entityValue,pubId,sysId,notaName);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMFragment: TdomCMFragment;
begin
  Result:= TdomCMFragment.create(self);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMNameParticle(const name: wideString): TdomCMNameParticle;
begin
  Result:= TdomCMNameParticle.create(self,name);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMNmtokenParticle(const name: wideString): TdomCMNmtokenParticle;
begin
  Result:= TdomCMNmtokenParticle.create(self,name);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMNotationDeclaration(const name,
                                                              pubId,
                                                              sysId: wideString): TdomCMNotationDeclaration;
begin
  Result:= TdomCMNotationDeclaration.create(self,name,pubId,sysId);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMParameterEntityDeclaration(const name,
                                                                     entityValue,
                                                                     pubId,
                                                                     sysId: wideString): TdomCMParameterEntityDeclaration;
begin
  Result:= TdomCMParameterEntityDeclaration.create(self,name,entityValue,pubId,sysId);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMParameterEntityReference(const name: wideString): TdomCMParameterEntityReference;
begin
  Result:= TdomCMParameterEntityReference.create(self,name);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMPcdataChoiceParticle: TdomCMPcdataChoiceParticle;
begin
  Result:= TdomCMPcdataChoiceParticle.create(self,'*');
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMProcessingInstruction(const targ,
                                                                Data : wideString): TdomCMProcessingInstruction;
begin
  Result:= TdomCMProcessingInstruction.create(self,targ);
  Result.Data:= Data;
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.CreateCMSequenceParticle(const freq: wideString): TdomCMSequenceParticle;
begin
  Result:= TdomCMSequenceParticle.create(self,freq);
  FCreatedNodes.add(Result);
end;

function TdomCustomCMObject.DuplicateCMNode(const node: TdomCMNode): TdomCMNode;
// Creates a new CMNode of the same type and properties than 'Node',
// except that the new CMNode has no parent and no child nodes.
var
  i: integer;
  newChild: TdomCMNode;
begin
  case node.NodeType of
    ctUnknown:
      raise ENot_Supported_Err.create('Not supported error.');
    ctParameterEntityReference:
      begin
        Result:= CreateCMParameterEntityReference((node as TdomCMParameterEntityReference).NodeName);
        Result.FNodeValue:= FNodeValue;
      end;
    ctEntityDeclaration:
      Result:= CreateCMEntityDeclaration((node as TdomCMEntityDeclaration).NodeName,
                                         (node as TdomCMEntityDeclaration).NodeValue,
                                         (node as TdomCMEntityDeclaration).publicId,
                                         (node as TdomCMEntityDeclaration).systemId,
                                         (node as TdomCMEntityDeclaration).notationName);
    ctParameterEntityDeclaration:
      Result:= CreateCMParameterEntityDeclaration((node as TdomCMParameterEntityDeclaration).NodeName,
                                                  (node as TdomCMParameterEntityDeclaration).NodeValue,
                                                  (node as TdomCMParameterEntityDeclaration).publicId,
                                                  (node as TdomCMParameterEntityDeclaration).systemId);
    ctProcessingInstruction:
        Result:= CreateCMProcessingInstruction((node as TdomCMProcessingInstruction).Target,
                                               (node as TdomCMProcessingInstruction).Data);
    ctComment:
      Result:= CreateCMComment((node as TdomCMComment).Data);
    ctObject:
      Result:= TdomCMObject.create((node as TdomCMObject).FDomImpl);
    ctExternalObject:
      Result:= TdomCMExternalObject.create((node as TdomCMExternalObject).FDomImpl,
                                           (node as TdomCMExternalObject).FPublicId,
                                           (node as TdomCMExternalObject).FSystemId);
    ctInternalObject:
      Result:= TdomCMInternalObject.create((node as TdomCMInternalObject).FDomImpl,
                                           (node as TdomCMInternalObject).FPublicId,
                                           (node as TdomCMInternalObject).FSystemId);
    ctFragment:
      Result:= CreateCMFragment;
    ctNotationDeclaration:
      Result:= CreateCMNotationDeclaration((node as TdomCMNotationDeclaration).NodeName,
                                           (node as TdomCMNotationDeclaration).publicId,
                                           (node as TdomCMNotationDeclaration).systemId);
    ctElementTypeDeclaration:
      Result:= CreateCMElementTypeDeclaration((node as TdomCMElementTypeDeclaration).NodeName,
                                              (node as TdomCMElementTypeDeclaration).contentspecType);
    ctSequenceParticle:
      Result:= CreateCMSequenceParticle((node as TdomCMSequenceParticle).Frequency);
    ctPcdataChoiceParticle:
      Result:= CreateCMPcdataChoiceParticle;
    ctChoiceParticle:
      Result:= CreateCMChoiceParticle((node as TdomCMChoiceParticle).Frequency);
    ctElementParticle:
      Result:= CreateCMElementParticle((node as TdomCMElementParticle).NodeName,
                                       (node as TdomCMElementParticle).Frequency);
    ctAttributeList: begin
      Result:= CreateCMAttributeList((node as TdomCMAttrList).NodeName);
      {duplicate attribute definitions:}
      for i:= 0 to pred(node.ChildNodes.Length) do begin
        NewChild:= DuplicateCMNode(node.ChildNodes.Item(i));
        Result.appendChild(NewChild);
      end;
      end;
    ctAttributeDefinition: begin
      Result:= CreateCMAttributeDefinition((node as TdomCMAttrDefinition).NodeName,
                                           (node as TdomCMAttrDefinition).AttributeType,
                                           (node as TdomCMAttrDefinition).DefaultDeclaration,
                                           (node as TdomCMAttrDefinition).NodeValue);
      {duplicate the children of the attribute definition node:}
      for i:= 0 to node.ChildNodes.Length-1 do begin
        newChild:= DuplicateCMNode(node.ChildNodes.Item(i));
        Result.appendChild(newChild);
      end;
      end;
    ctNameParticle:
      Result:= CreateCMNameParticle((node as TdomCMNameParticle).NodeName);
    ctNmtokenParticle:
      Result:= CreateCMNmtokenParticle((node as TdomCMNmtokenParticle).NodeName);
  else
    raise ENot_Supported_Err.create('Not supported error.');
  end;
end;

procedure TdomCustomCMObject.FreeAllCMNodes(var CMNode: TdomCMNode);
var
  index: integer;
  oldChild: TdomCMNode;
begin
  if not assigned(CMNode) then exit;
  if CMNode.OwnerCMObject <> Self
    then raise EWrong_Document_Err.create('Wrong document error.');
  if CMNode = Self
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  if assigned(CMNode.ParentNode)
    then raise EInuse_Node_Err.create('Inuse node error.');
  while CMnode.HasChildNodes do begin
    CMnode.FirstChild.setIsReadonly(false);
    oldChild:= CMnode.RemoveChild(CMnode.FirstChild);
    CMnode.OwnerCMObject.FreeAllCMNodes(oldChild);
  end;
  index:= FCreatedNodes.IndexOf(CMNode);
  CMNode.free;
  FCreatedNodes.Delete(index);
  CMNode:= nil;
end;



// ++++++++++++++++++++++++++++ TdomCMObject +++++++++++++++++++++++++++
constructor TdomCMObject.create(const aOwner: TdomImplementation);
begin
  inherited create(aOwner);
  FNodeName:= '#cm-object';
  FNodeType:= ctObject;
  FAllowedChildTypes:= []; 
  FAssociatedDocument:= nil;
  FCMExternal:= nil;
  FCMInternal:= nil;
  FParameterEntitiesListing:= TList.create;
  FParameterEntitiesList:= TdomNamedCMNodeMap.create(self,self,FParameterEntitiesListing,[ctParameterEntity]);
  FNotationsListing:= TList.create;
  FNotationsList:= TdomNamedCMNodeMap.create(self,self,FNotationsListing,[ctNotation]);
  FElementTypesListing:= TList.create;
  FElementTypesList:= TdomNamedCMNodeMap.create(self,self,FElementTypesListing,[ctElementTypeDeclaration]);
  FAttributesList:= TdomNamedCMAttributeMap.create(self);
  FEntitiesList:= TdomNamedCMEntityMap.create(self);
  setPredefinedEntities(nil);
end;

destructor TdomCMObject.destroy;
begin
  FAttributesList.free;
  FEntitiesList.free;
  FParameterEntitiesListing.free;
  FParameterEntitiesList.free;
  FNotationsListing.free;
  FNotationsList.free;
  FElementTypesListing.free;
  FElementTypesList.free;
  inherited destroy;
end;

procedure TdomCMObject.clear;
begin
  clearAttributes;
  clearElementtypes;
  clearEntities;
  clearParameterEntities;
  clearNotations;
  inherited clear;
end;

procedure TdomCMObject.clearAttributes;
var
  removedAttribute: TdomCMAttribute;
begin
  while attributes.length > 0 do begin
    removedAttribute:= attributes.removeLastItem;
    FCreatedNodes.remove(removedAttribute);
    removedAttribute.free;
  end;
end;

procedure TdomCMObject.clearElementTypes;
var
  i: integer;
begin
  for i:= pred(FElementTypesListing.count) downto 0 do
    FCreatedNodes.remove(FElementTypesListing[i]);
  FElementTypesListing.clear;
end;

procedure TdomCMObject.clearEntities;
var
  removedEntity: TdomCMEntity;
begin
  while Entities.length > 0 do begin
    removedEntity:= Entities.removeLastItem;
    FCreatedNodes.remove(removedEntity);
    removedEntity.free;
  end;
end;

procedure TdomCMObject.clearNotations;
var
  i: integer;
begin
  for i:= pred(FNotationsListing.count) downto 0 do
    FCreatedNodes.remove(FNotationsListing[i]);
  FNotationsListing.clear;
end;

procedure TdomCMObject.clearParameterEntities;
var
  i: integer;
begin
  for i:= pred(FParameterEntitiesListing.count) downto 0 do
    FCreatedNodes.remove(FParameterEntitiesListing[i]);
  FParameterEntitiesListing.clear;
end;

function TdomCMObject.DuplicateCMNode(const node: TdomCMNode): TdomCMNode;
begin
  case node.NodeType of
    ctAttribute:
      Result:= CreateCMAttribute((node as TdomCMAttribute).elementName,
                                 (node as TdomCMAttribute).attributeName,
                                 (node as TdomCMAttribute).attributeType,
                                 (node as TdomCMAttribute).defaultDeclaration,
                                 (node as TdomCMAttribute).NodeValue);
    ctEntity:
      Result:= CreateCMEntity((node as TdomCMEntity).NodeName,
                              (node as TdomCMEntity).literalValue,
                              (node as TdomCMEntity).publicId,
                              (node as TdomCMEntity).systemId,
                              (node as TdomCMEntity).Version,
                              (node as TdomCMEntity).notationName);
    ctNotation:
      Result:= CreateCMNotation((node as TdomCMNotation).NodeName,
                                (node as TdomCMNotation).publicId,
                                (node as TdomCMNotation).systemId);
    ctParameterEntity:
      Result:= CreateCMParameterEntity((node as TdomCMParameterEntity).NodeName,
                                       (node as TdomCMParameterEntity).NodeValue,
                                       (node as TdomCMParameterEntity).publicId,
                                       (node as TdomCMParameterEntity).systemId,
                                       (node as TdomCMParameterEntity).version);
  else
    Result:= inherited DuplicateCMNode(node);
  end;
end;

function TdomCMObject.CreateCMAttribute(const elementName,
                                              attributeName,
                                              attType,
                                              defaultDecl,
                                              attValue: wideString): TdomCMAttribute;
begin
  Result:= TdomCMAttribute.create(self,elementName,attributeName,attType,defaultDecl,attValue);
  FCreatedNodes.add(Result);
end;

function TdomCMObject.CreateCMEntity(const name,
                                           literalValue,
                                           pubId,
                                           sysId,
                                           versionNumber,
                                           notaName: wideString): TdomCMEntity;
begin
  Result:= TdomCMEntity.create(self,name,literalValue,pubId,sysId,Versionnumber,notaName);
  FCreatedNodes.add(Result);
end;

function TdomCMObject.CreateCMNotation(const name,
                                             pubId,
                                             sysId: wideString): TdomCMNotation;
begin
  Result:= TdomCMNotation.create(self,name,pubId,sysId);
  FCreatedNodes.add(Result);
end;

function TdomCMObject.CreateCMParameterEntity(const name,
                                                    value,
                                                    pubId,
                                                    sysId,
                                                    versionNumber: wideString): TdomCMParameterEntity;
begin
  Result:= TdomCMParameterEntity.create(self,name,value,pubId,sysId,versionNumber);
  FCreatedNodes.add(Result);
end;

function TdomCMObject.setPredefinedEntities(const errorHandler: TdomCustomErrorHandler): boolean;

  function testGtAposQuot(const errorHandler: TdomCustomErrorHandler;
                          const entName,
                                litVal,
                                CdataVal: wideString): boolean;
  var
    newEntity, oldEntity: TdomCMEntity;
    ok: boolean;
    e1: EParserWrong_Declaration_Of_Predefined_Entity_Err;
  begin
    result:= true;
    oldEntity:= Entities.GetNamedItem(entName);
    if assigned(oldEntity) then begin
      try
        ok:= (oldEntity.replacementText = CdataVal);
      except
        ok:= false;
      end;
      if not ok then begin
        result:= false;
        e1:= EParserWrong_Declaration_Of_Predefined_Entity_Err.create('Wrong_Declaration_Of_Predefined_Entity_Err');
        try
          if assigned(errorHandler) then errorHandler.error(nil,nil,e1,entName);
        finally
          e1.free;
        end;
      end;
    end else begin
      newEntity:= CreateCMEntity(entName,litVal,'','','','');
      Entities.appendNamedItem(newEntity);
    end;
  end;

  function testLtAmp(const errorHandler: TdomCustomErrorHandler;
                     const entName,
                           litVal: wideString;
                     const charValue: integer): boolean;
  var
    newEntity, oldEntity: TdomCMEntity;
    ok: boolean;
    e1: EParserWrong_Declaration_Of_Predefined_Entity_Err;
  begin
    result:= true;
    oldEntity:= Entities.GetNamedItem(entName);
    if assigned(oldEntity) then begin
      try
        ok:= (XmlCharRefToInt(oldEntity.replacementText) = charValue);
      except
        ok:= false;
      end;
      if not ok then begin
        result:= false;
        e1:= EParserWrong_Declaration_Of_Predefined_Entity_Err.create('Wrong_Declaration_Of_Predefined_Entity_Err');
        try
          if assigned(errorHandler) then errorHandler.error(nil,nil,e1,entName);
        finally
          e1.free;
        end;
      end;
    end else begin
      newEntity:= CreateCMEntity(entName,litVal,'','','','');
      Entities.appendNamedItem(newEntity);
    end;
  end;

begin
  result:= true;
  if not testLtAmp(errorHandler,'lt','&#38;#60;',60)
    then result:= false;
  if not testGtAposQuot(errorHandler,'gt','&#62;',#62)
    then result:= false;
  if not testLtAmp(errorHandler,'amp','&#38;#38;',38)
    then result:= false;
  if not testGtAposQuot(errorHandler,'apos','&#39;',#39)
    then result:= false;
  if not testGtAposQuot(errorHandler,'quot','&#34;',#34)
    then result:= false;
end;

procedure TdomCMObject.prepareCM(const errorHandler: TdomCustomErrorHandler);
var
  dtdAnalyzer: TdomDtdAnalyzer;
begin
  clearEntities;
  clearAttributes;
  clearElementTypes;
  clearNotations;
  clearParameterEntities;

  dtdAnalyzer:= TdomDtdAnalyzer.create(nil);
  dtdAnalyzer.ErrorHandler:= errorHandler;
  try
    if assigned(internalCM)
      then dtdAnalyzer.analyzeCM(internalCM,self);
    if assigned(externalCM)
      then dtdAnalyzer.analyzeCM(externalCM,self);
  finally
    dtdAnalyzer.free;
  end;

  setPredefinedEntities(errorHandler);
end;

procedure TdomCMObject.prepare;
begin
  try
    prepareCM(nil);
  except
    raise EInvalid_State_Err.create('Invalid state error.');
  end;
end;

function  TdomCMObject.removeExternalCM: TdomCMExternalObject;
begin
  result:= FCMExternal;
  if assigned(FCMExternal)
    then FCMExternal.FAssociatedContentModel:= nil;
  FCMExternal:= nil;
end;

function TdomCMObject.setExternalCM(const arg: TdomCMExternalObject): TdomCMExternalObject;
begin
  if assigned(arg)
    then if assigned(arg.associatedContentModel)
      then raise EInuse_Content_Model_Err.create('Inuse content model error.');
  result:= removeExternalCM;
  FCMExternal:= arg;
  arg.FAssociatedContentModel:= self;
end;

function  TdomCMObject.removeInternalCM: TdomCMInternalObject;
begin
  result:= FCMInternal;
  if assigned(FCMInternal)
    then FCMInternal.FAssociatedContentModel:= nil;
  FCMInternal:= nil;
end;

function TdomCMObject.setInternalCM(const arg: TdomCMInternalObject): TdomCMInternalObject;
begin
  if assigned(arg)
    then if assigned(arg.associatedContentModel)
      then raise EInuse_Content_Model_Err.create('Inuse content model error.');
  result:= removeInternalCM;
  FCMInternal:= arg;
  arg.FAssociatedContentModel:= self;
end;

function TdomCMObject.validate(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i,j: integer;
  ok, typeMismatch: boolean;
  idNames, notationNames, notationTokens, enumerationTokens: TStringList;
  AType: wideString;
  Attri: TdomCMAttribute;
  EType: TdomCMElementTypeDeclaration;
  EHandler: TdomStandardErrorHandler;
  e1: EParserDuplicate_ID_On_Element_Type_Err;
  e2: EParserUndeclared_Notation_Name_Err;
  e3: EParserDuplicate_Notation_On_Element_Type_Err;
  e4: EParserNotation_On_Empty_Element_Err;
  e5: EParserAttribute_Default_Type_Mismatch_Err;
  e6: EParserReferenceToUnparsedEntity_Err;
  e7: EParserDuplicate_Notation_Token_Err;
  e8: EParserDuplicate_Enumeration_Token_Err;
begin
  result:= true;

  EHandler:= TdomStandardErrorHandler.create;
  try
    prepareCM(EHandler);
    with EHandler.errorList do
    if count > 0 then begin
      for i:= 0 to pred(count) do
        if TXmlParserError(items[i]).errorType <> xetWarning then begin
          result:= false;
          break;
        end;
      // Make sure, that the specified Error Handler gets the
      // information what went wrong; so call prepareCM again:
      if assigned(errorHandler) then prepareCM(errorHandler);
    end;
  finally
    EHandler.free;
  end;

  if assigned(internalCM) then begin
    if not internalCM.validate(errorHandler) then begin
      result:= false;
      exit;
    end;
  end;

  if assigned(externalCM) then begin
    if not externalCM.validate(errorHandler) then begin
      result:= false;
      exit;
    end;
  end;

  for i:= 0 to pred(entities.length) do begin
    with entities.item(i) do begin

      // VC: Notation Declared (XML 1.0, � 4.2.2)
      if not isInternalEntity then
        if notationName <> '' then begin
          if notations.GetNamedIndex(notationName) = -1 then begin
            result:= false;
            e2:= EParserUndeclared_Notation_Name_Err.create('Undeclared_Notation_Name_Err');
            try
              if assigned(errorHandler) then errorhandler.error(nil,nil,e2,notationName);
            finally
              e2.free;
            end;
          end;
        end;

      // WFC: Parsed Enity (XML 1.0, � 4.1)
      if isParsedEntity and refersToUnparsedEntity(true) then begin
        result:= false;
        e6:= EParserReferenceToUnparsedEntity_Err.create('ReferenceToUnparsedEntity_Err');
        try
          try
            if assigned(errorHandler) then errorhandler.fatalError(nil,nil,e6,NodeName);
          except
          end;
        finally
          e6.free;
        end;
      end;

    end; {with ...}
  end; {for ...}

  IdNames:= TStringList.create;
  IdNames.Sorted:= true;
  IdNames.Duplicates:= dupError;
  NotationNames:= TStringList.create;
  NotationNames.Sorted:= true;
  NotationNames.Duplicates:= dupError;
  NotationTokens:= TStringList.create;
  NotationTokens.Sorted:= true;
  NotationTokens.Duplicates:= dupError;
  EnumerationTokens:= TStringList.create;
  EnumerationTokens.Sorted:= true;
  EnumerationTokens.Duplicates:= dupError;
  try
    for i:= 0 to pred(attributes.length) do begin
      Attri:= attributes.item(i);
      AType:= Attri.AttributeType;
      TypeMismatch:= false;
      if  AType = 'ID' then begin

        // VC: One ID per Element Type (XML 1.0, � 3.3.1)
        try
          IdNames.Add(Attri.ElementName)
        except  // xxx not elegant
          result:= false;
          e1:= EParserDuplicate_ID_On_Element_Type_Err.create('Duplicate_ID_On_Element_Type_Err');
          try
            if assigned(errorHandler) then errorhandler.error(nil,nil,e1,'');
          finally
            e1.free;
          end;
        end;

      end else if AType = 'NOTATION' then begin

        NotationTokens.clear;

        for j:= 0 to pred(Attri.childnodes.length) do begin

          // VC: Notation Attributes (XML 1.0, � 3.3.1)
          if notations.GetNamedIndex(Attri.childnodes.item(j).NodeName) = -1 then begin
            result:= false;
            e2:= EParserUndeclared_Notation_Name_Err.create('Undeclared_Notation_Name_Err');
            try
              if assigned(errorHandler) then errorhandler.error(nil,nil,e2,Attri.childnodes.item(j).NodeName);
            finally
              e2.free;
            end;
          end;

          // VC: No Duplicate Tokens (XML 1.0, 2nd ed., erratum 2)
          try
            NotationTokens.Add(Attri.childnodes.item(j).NodeName)
          except  // xxx not elegant
            result:= false;
            e7:= EParserDuplicate_Notation_Token_Err.create('Duplicate_Notation_Token_Err');
            try
              if assigned(errorHandler) then errorhandler.error(nil,nil,e7,Attri.childnodes.item(j).NodeName);
            finally
              e7.free;
            end;
          end;

        end; {for ...}

        // VC: One Notation per Element Type (XML 1.0, � 3.3.1)
        try
          NotationNames.Add(Attri.ElementName)
        except  // xxx not elegant
          result:= false;
          e3:= EParserDuplicate_Notation_On_Element_Type_Err.create('Duplicate_Notation_On_Element_Type_Err');
          try
            if assigned(errorHandler) then errorhandler.error(nil,nil,e3,'');
          finally
            e3.free;
          end;
        end;

        // VC: No Notation on Empty Element (XML 1.0, � 3.3.1)
        EType:= (elementTypes.GetNamedItem(Attri.ElementName) as TdomCMElementTypeDeclaration);
        if assigned(EType) then begin
          if EType.ContentspecType = ctEmpty then begin
            result:= false;
            e4:= EParserNotation_On_Empty_Element_Err.create('Notation_On_Empty_Element_Err');
            try
              if assigned(errorHandler) then errorhandler.error(nil,nil,e4,'');
            finally
              e4.free;
            end;
          end;
        end;

      end else

      if AType = '' then begin
        if attri.NodeValue <> '' then begin
          ok:= false;
          EnumerationTokens.clear;
          with attri do begin
            for j:= 0 to pred(ChildNodes.length) do begin
              if ChildNodes.item(j).NodeName = NodeValue then begin
                ok:= true;
                break;
              end;

              // VC: No Duplicate Tokens (XML 1.0, 2nd ed., erratum 2)
              try
                EnumerationTokens.Add(childnodes.item(j).NodeName)
              except  // xxx not elegant
                result:= false;
                e8:= EParserDuplicate_Enumeration_Token_Err.create('Duplicate_Enumeration_Token_Err');
                try
                  if assigned(errorHandler) then errorhandler.error(nil,nil,e8,childnodes.item(j).NodeName);
                finally
                  e8.free;
                end;
              end;
              if not result then break;

            end;
          end; {with ...}
          TypeMismatch:= not ok; // VC: Enumeration (XML 1.0, � 3.3.1)
        end; {if ...}
      end else
      if AType = 'IDREF' then begin
        if not (isXMLName(attri.NodeValue) or (attri.NodeValue = ''))
          then TypeMismatch:= true; // VC: IDREF (XML 1.0, � 3.3.1)
      end else
      if AType = 'IDREFS' then begin
        if not (isXMLNames(attri.NodeValue) or (attri.NodeValue = ''))
          then TypeMismatch:= true; // VC: IDREF (XML 1.0, � 3.3.1)
      end else
      if AType = 'ENTITY' then begin
        if not (isXMLName(attri.NodeValue) or (attri.NodeValue = ''))
          then TypeMismatch:= true; // VC: Entity (XML 1.0, � 3.3.1)
      end else
      if AType = 'ENTITIES' then begin
        if not (isXMLNames(attri.NodeValue) or (attri.NodeValue = ''))
          then TypeMismatch:= true; // VC: Entity (XML 1.0, � 3.3.1)
      end else
      if AType = 'NMTOKEN' then begin
        if not (isXmlNmtoken(attri.NodeValue) or (attri.NodeValue = ''))
          then TypeMismatch:= true; // VC: name Token (XML 1.0, � 3.3.1)
      end else
      if AType = 'NMTOKENS' then begin
        if not (isXmlNmtokens(attri.NodeValue) or (attri.NodeValue = ''))
          then TypeMismatch:= true; // VC: name Token (XML 1.0, � 3.3.1)
      end;

      if TypeMismatch then begin
        Result:= false;
        e5:= EParserAttribute_Default_Type_Mismatch_Err.create('Attribute_Default_Type_Mismatch_Err');
        try
          if assigned(errorHandler) then errorhandler.error(nil,nil,e5,'');
        finally
          e5.free;
        end;
      end;

    end; {for ...}
  finally
    IdNames.free;
    NotationNames.free;
    NotationTokens.free;
    EnumerationTokens.free;
  end;

end;



// +++++++++++++++++++++++ TdomCustomCMIEObject +++++++++++++++++++++++
constructor TdomCustomCMIEObject.create(const aOwner: TdomImplementation;
                                        const pubId,
                                              sysId: wideString);
begin
  inherited create(aOwner);
  FParameterEntitiesList:= TdomNameValueList.create;
  FPublicId:= pubId;
  FSystemId:= sysId;
  FAssociatedContentModel:= nil;
end;

destructor TdomCustomCMIEObject.destroy;
begin
  FParameterEntitiesList.free;
  inherited destroy;
end;

function TdomCustomCMIEObject.validate(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i: integer;
begin
  result:= true;
  for i:= 0 to pred(childnodes.length) do begin
    if not childnodes.item(i).validate(errorHandler) then begin
      result:= false;
      exit;
    end;
  end;
end;


// +++++++++++++++++++++++ TdomCMInternalObject +++++++++++++++++++++++
constructor TdomCMInternalObject.create(const aOwner: TdomImplementation;
                                        const pubId,
                                              sysId: wideString);
begin
  inherited create(aOwner,pubId,sysId);
  FNodeName:= '#cm-internal-object';
  FNodeType:= ctInternalObject;
  FAllowedChildTypes:= [ctAttributeList,
                        ctComment,
                        ctElementTypeDeclaration,
                        ctEntityDeclaration,
                        ctNotationDeclaration,
                        ctParameterEntityDeclaration,
                        ctParameterEntityReference,
                        ctProcessingInstruction];
end;



// ++++++++++++++++++++++++ TdomCMExternalObject +++++++++++++++++++++++
constructor TdomCMExternalObject.create(const aOwner: TdomImplementation;
                                        const pubId,
                                              sysId: wideString);
begin
  inherited create(aOwner,pubId,sysId);
  FNodeName:= '#cm-external-object';
  FNodeType:= ctExternalObject;
  FEncoding:= '';
  FVersion:= '';
  FAllowedChildTypes:= [ctAttributeList,
                        ctComment,
                        ctElementTypeDeclaration,
                        ctEntityDeclaration,
                        ctNotationDeclaration,
                        ctParameterEntityDeclaration,
                        ctParameterEntityReference,
                        ctProcessingInstruction];
end;



// ++++++++++++++++++ TdomCMNotationDeclaration ++++++++++++++++++++++++
constructor TdomCMNotationDeclaration.create(const aOwner: TdomCustomCMObject;
                                             const name,
                                                   pubId,
                                                   sysId: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if ( not ( IsXMLSystemLiteral(concat(dQuote,systemId,dQuote)) or
    IsXMLSystemLiteral(concat(sQuote,sysId,sQuote)) ) )
    and ( not ( IsXMLPubidLiteral(concat(dQuote,publicId,dQuote)) or
    IsXMLPubidLiteral(concat(sQuote,pubId,sQuote)) ) )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeValue:= '';
  FPublicId:= pubId;
  FSystemId:= sysId;
  FNodeType:= ctNotationDeclaration;
  FAllowedChildTypes:= [];
end;

procedure TdomCMNotationDeclaration.SetNodeValue(const value: wideString);
begin
end;

procedure TdomCMNotationDeclaration.writeCode(stream: TStream);  
begin
  writeWideStrings(stream, ['<!NOTATION ', NodeName, ' ',
    XMLAnalysePubSysId(publicId,systemId,''), '>']);
end;

function TdomCMNotationDeclaration.GetPublicId: wideString;
begin
  Result:= FPublicId;
end;

function TdomCMNotationDeclaration.GetSystemId: wideString;
begin
  Result:= FSystemId;
end;

function TdomCMNotationDeclaration.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



// +++++++++++++++++ TdomCMElementTypeDeclaration +++++++++++++++++++++++
constructor TdomCMElementTypeDeclaration.create(const aOwner: TdomCustomCMObject;
                                                const name: wideString;
                                                const contspecType: TdomContentspecType);
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeType:= ctElementTypeDeclaration;
  FContentspec:= contspecType;
  case contspecType of
    ctEmpty,ctAny: FAllowedChildTypes:= [];
    ctMixed:       FAllowedChildTypes:= [ctPcdataChoiceParticle];
    ctChildren:    FAllowedChildTypes:= [ctSequenceParticle,
                                         ctChoiceParticle];
  end;
end;

function TdomCMElementTypeDeclaration.GetContentspec: wideString;  
var
  XMLStream: TdomWideStringStream;
begin
  XMLStream := TdomWideStringStream.create;
  try
    WriteContentspec(XMLStream);
    Result := XMLStream.DataString;
  finally
    XMLStream.Free;
  end;
end;

procedure TdomCMElementTypeDeclaration.WriteContentspec(stream: TStream);  
begin
  case ContentSpecType of
    ctEmpty: writeWideString(stream, 'EMPTY ');
    ctAny:   writeWideString(stream, 'ANY ');
    ctMixed, ctChildren: ChildNodes.Item(0).writeCode(stream);
  end; {case ...}
end;

function TdomCMElementTypeDeclaration.GetContentspecType: TdomContentspecType;
begin
  Result:= FContentspec;
end;

procedure TdomCMElementTypeDeclaration.writeCode(stream: TStream); 
begin
  if (ContentspecType <> ctEmpty) and (ContentspecType <> ctAny) and not hasChildNodes
    then raise ENot_Supported_Err.create('Not supported error.');
  writeWideStrings(stream, ['<!ELEMENT ', NodeName, ' ']);
  WriteContentspec(stream);
  writeWideChars(stream, [' ', '>']);
end;

procedure TdomCMElementTypeDeclaration.SetNodeValue(const value: wideString);
begin
end;

function TdomCMElementTypeDeclaration.appendChild(const newChild: TdomCMNode): TdomCMNode;
begin
  if (contentspecType = ctEmpty) or (contentspecType = ctAny)
    or (hasChildNodes and (FirstChild <> newChild))
      then raise ENot_Supported_Err.create('Not supported error.');
  result:= inherited appendChild(newChild);
end;

function TdomCMElementTypeDeclaration.insertBefore(const newChild,
                                                         refChild: TdomCMNode): TdomCMNode;
begin
  if (contentspecType = ctEmpty) or (contentspecType = ctAny)
    or (hasChildNodes and (FirstChild <> newChild))
      then raise ENot_Supported_Err.create('Not supported error.');
  result:= inherited insertBefore(newChild,refChild);
end;

function TdomCMElementTypeDeclaration.validate(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i: integer;
begin
  result:= true;
  for i:= 0 to pred(childnodes.length) do begin
    if not childnodes.item(i).validate(errorHandler) then begin
      result:= false;
      exit;
    end;
  end;
end;



// +++++++++++++++++++++++ TdomCMAttrList ++++++++++++++++++++++++++++++
constructor TdomCMAttrList.create(const aOwner: TdomCustomCMObject;
                                  const name: wideString);
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeType:= ctAttributeList;
  FAllowedChildTypes:= [ctAttributeDefinition];
end;

procedure TdomCMAttrList.writeCode(stream: TStream);
var
  i: integer;
begin
  writeWideStrings(stream, ['<!ATTLIST ', NodeName]);
  for i:= 0 to pred(childNodes.length) do
  begin
    writeWideChars(stream, [#$A, #$9]); // Line Feed + Horizontal Tabulation
    childNodes.item(i).writeCode(stream);
  end;
  writeWideChars(stream, ['>']);
end;

function TdomCMAttrList.validate(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i: integer;
begin
  result:= true;
  for i:= 0 to pred(childnodes.length) do begin
    if not childnodes.item(i).validate(errorHandler) then begin
      result:= false;
      exit;
    end;
  end;
end;


// ++++++++++++++++++++ TdomCMAttrDefinition ++++++++++++++++++++++++++
constructor TdomCMAttrDefinition.create(const aOwner: TdomCustomCMObject;
                                        const name,
                                              attType,
                                              defaultDecl,
                                              attValue: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( (attType='') or (attType='NOTATION') or
    IsXmlStringType(attType) or IsXmlTokenizedType(attType) )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( (defaultDecl = '#REQUIRED') or (defaultDecl = '#IMPLIED') or
           (defaultDecl = '#FIXED') or (defaultDecl = '') )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if ((defaultDecl = '#REQUIRED') or (defaultDecl = '#IMPLIED'))
    and (attValue <> '')
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if ((defaultDecl = '#FIXED') or (defaultDecl = ''))
    and (attValue = '')
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLAttValue(concat(dQuote,attValue,dQuote)) or
    IsXMLAttValue(concat(sQuote,attValue,sQuote)) )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FAttributeType:= attType;
  FDefaultDeclaration:= defaultDecl;
  FNodeValue:= attValue;
  FNodeType:= ctAttributeDefinition;
  FParentAttributeList:= nil;
  FAllowedChildTypes:= [];
  if attType = ''
    then FAllowedChildTypes:= [ctNmtokenParticle];
  if attType = 'NOTATION'
    then FAllowedChildTypes:= [ctNameParticle];
end;

function TdomCMAttrDefinition.validate(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i: integer;
  particleNames: TStringList;
  e1: EParserId_Neither_Implied_Nor_Required_Err;
  e2: EParserDuplicate_Tokens_Err;
begin
  result:= true;

  // VC: ID Attribute Default (XML 1.0, � 3.3.1)
  if (AttributeType = 'ID') and not
    ( (DefaultDeclaration = '#REQUIRED') or (DefaultDeclaration = '#IMPLIED') ) then begin
    result:= false;
    e1:= EParserId_Neither_Implied_Nor_Required_Err.create('Id_Neither_Implied_Nor_Required_Err');
    try
      if assigned(errorHandler) then errorhandler.error(nil,nil,e1,'');
    finally
      e1.free;
    end;
  end;

  // VC: No Duplicate Tokens (XML 1.0, 2nd Ed., Erratum 2)
  if hasChildNodes then begin
    particleNames:= TStringList.create;
    particleNames.Sorted:= true;
    particleNames.Duplicates:= dupError;
    try
      for i:= 0 to pred(childnodes.length) do begin
        try
          particleNames.Add(childnodes.item(i).nodeName);
        except  // xxx not elegant
          result:= false;
          e2:= EParserDuplicate_Tokens_Err.create('Duplicate_Tokens_Err');
          try
            if assigned(errorHandler) then errorhandler.error(nil,nil,e2,'');
          finally
            e2.free;
          end; {try ... finally ...}
          break;
        end; {try ... except ...}
      end; {for ...}
    finally
      particleNames.free;
    end;
  end;
  
end;

function TdomCMAttrDefinition.GetAttributeType: wideString;
begin
  Result:= FAttributeType;
end;

function TdomCMAttrDefinition.GetDefaultDeclaration: wideString;
begin
  Result:= FDefaultDeclaration;
end;

procedure TdomCMAttrDefinition.SetNodeValue(const value: wideString);
begin
end;

procedure TdomCMAttrDefinition.writeCode(stream: TStream);
const
  sQuote: WideChar  = #$0027;
  dQuote: WideChar  = '"';
var
  i: integer;
  defDecl, ndVal: wideString;
  Quote: WideChar;
begin
  writeWideString(stream, NodeName);
  writeWideChars(stream, [#9]);
  if Length(AttributeType) > 0 then
  begin
    writeWideString(stream, AttributeType);
    writeWideChars(stream, [#9]);
  end;
  if HasChildNodes then
  begin
    writeWideChars(stream, ['(']);
    for i:= 0 to ChildNodes.Length -1 do begin
      if i > 0 then writeWideChars(stream, [' ', '|', ' ']);
      ChildNodes.item(i).writeCode(stream);
    end;
    writeWideChars(stream, [')']);
  end;
  defDecl := DefaultDeclaration;
  if Length(defDecl) > 0 then
  begin
    writeWideChars(stream, [#9]);
    writeWideString(stream, defDecl);
  end;
  if (Length(defDecl) = 0) or (defDecl = wideString('#FIXED')) then
  begin
    ndVal := NodeValue;
    if Pos(dQuote, ndVal) > 0 then Quote := sQuote else Quote := dQuote;
    writeWideChars(stream, [#9, Quote]);
    writeWideString(stream, ndVal);
    writeWideChars(stream, [Quote]);
  end;
end;



// +++++++++++++++++++++++++ TdomCMParticle ++++++++++++++++++++++++++++
constructor TdomCMParticle.create(const aOwner: TdomCustomCMObject;
                                  const freq: wideString);
begin
  if not ( (freq = '') or (freq = wideString('?')) or (freq = '*') or (freq = '+') )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeType:= ctUnknown;
  FAllowedChildTypes:= [];
  FFrequency:= freq;
end;

function TdomCMParticle.contentModelTest2(const source,
                                                rest: TStringList;
                                          const freq: wideString): boolean;
begin
  raise EInternalParserException.create('Internal Parser Exception in TdomCMParticle.contentModelTest');
end;

function TdomCMParticle.contentModelTest(const source,
                                               rest: TStringList): boolean;
var
  rest2: TStringList;
begin
  result:= false;
  if Frequency = '' then begin
    result:= contentModelTest2(source,rest,'');
  end else if Frequency = '?' then begin
    result:= contentModelTest2(source,rest,'?');
  end else if Frequency = '+' then begin
    result:= contentModelTest2(source,rest,'');
    if result then begin
      rest2:= TStringList.create;
      try
        while rest.Count > 0 do begin
          if not contentModelTest2(rest,rest2,'') then break;
          rest.assign(rest2);
        end;
      finally
        rest2.free;
      end;
    end;
  end else if Frequency = '*' then begin
    result:= contentModelTest2(source,rest,'?');
    if result then begin
      rest2:= TStringList.create;
      try
        while rest.Count > 0 do begin
          if not contentModelTest2(rest,rest2,'') then break;
          rest.assign(rest2);
        end;
      finally
        rest2.free;
      end;
    end;
  end;
end;

function TdomCMParticle.GetFrequency: wideString;
begin
  Result:= FFrequency;
end;

procedure TdomCMParticle.SetFrequency(const freq: wideString);
begin
  if not ( (freq = '') or (freq = wideString('?')) or (freq = '*') or (freq = '+') )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  FFrequency:= freq;
end;

procedure TdomCMParticle.SetNodeValue(const value: wideString);
begin
end;



// ++++++++++++++++++++++ TdomCMSequenceParticle +++++++++++++++++++++++
constructor TdomCMSequenceParticle.create(const aOwner: TdomCustomCMObject;
                                          const freq: wideString);
begin
  inherited create(aOwner,freq);
  FNodeName:= '#sequence-particle';
  FNodeType:= ctSequenceParticle;
  FAllowedChildTypes:= [ctSequenceParticle,
                        ctChoiceParticle,
                        ctElementParticle];
end;

function TdomCMSequenceParticle.contentModelTest2(const source,
                                                        rest: TStringList;
                                                  const freq: wideString): boolean;
var
  i: integer;
  source2,rest2: TStringList;
  ok: boolean;
begin
  rest.Assign(source);
  result:= false;
  source2:= TStringList.create;
  rest2:= TStringList.create;
  try
    source2.Assign(source);
    ok:= false;
    for i:= 0 to pred(childnodes.length) do begin
      ok:= (childnodes.item(i) as TdomCMParticle).contentModelTest(source2,rest2);
      if not ok then break;
      source2.Assign(rest2);
    end;
    if freq = '' then begin
      if ok then begin
        rest.assign(rest2);
        result:= true;
      end else result:= false;
    end else if freq = '?' then begin
      if ok then rest.assign(rest2);
      result:= true;
    end;
  finally
    source2.free;
    rest2.free;
  end;
end;

procedure TdomCMSequenceParticle.writeCode(stream: TStream);
var
  i: integer;
begin
  if not HasChildNodes
    then raise ENot_Supported_Err.create('Not supported error.');
  writeWideChars(stream, ['(']);
  for i:= 0 to childnodes.length-1 do begin
    if i > 0 then writeWideChars(stream, [',', ' ']);
    ChildNodes.item(i).writeCode(stream);
  end;
  writeWideChars(stream, [')']);
  writeWideString(stream, Frequency);
end;

function TdomCMSequenceParticle.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



//++++++++++++++++++++++ TdomChoiceParticle ++++++++++++++++++++++++++++
constructor TdomCMChoiceParticle.create(const aOwner: TdomCustomCMObject;
                                        const freq: wideString);
begin
  inherited create(aOwner,freq);
  FNodeName:= '#choice-particle';
  FNodeType:= ctChoiceParticle;
  FAllowedChildTypes:= [ctSequenceParticle,
                        ctChoiceParticle,
                        ctElementParticle];
end;

function TdomCMChoiceParticle.contentModelTest2(const source,
                                                      rest: TStringList;
                                                const freq: wideString): boolean;
var
  i: integer;
  rest3,rest2: TStringList;
  okNumber: integer;
begin
  rest.Assign(source);
  result:= false;
  rest3:= TStringList.create;
  rest2:= TStringList.create;
  try
    okNumber:= 0;
    for i:= 0 to pred(childnodes.length) do begin
      if (childnodes.item(i) as TdomCMParticle).contentModelTest(source,rest2) then begin
        inc(okNumber);
        if okNumber > 1 then
          raise EParserNondeterministic_Element_Content_Model_Err.create('Nondeterministic_Element_Content_Model_Err');  // xxx replace this with errorHandler call?
        rest3.assign(rest2);
      end;
    end;
    if freq = '' then begin
      if okNumber = 1 then begin
        rest.assign(rest3);
        result:= true;
      end else result:= false;
    end else if freq = '?' then begin
      if okNumber = 1 then rest.assign(rest3);
      result:= true;
    end;
  finally
    rest3.free;
    rest2.free;
  end;
end;

procedure TdomCMChoiceParticle.writeCode(stream: TStream);
var
  i: integer;
begin
  if not HasChildNodes
    then raise ENot_Supported_Err.create('Not supported error.');
  writeWideChars(stream, ['(']);
  for i:= 0 to childnodes.length-1 do begin
    if i > 0 then writeWideChars(stream, [' ', '|', ' ']);
    ChildNodes.item(i).writeCode(stream);
  end;
  writeWideChars(stream, [')']);
  writeWideString(stream, Frequency);
end;

function TdomCMChoiceParticle.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



// +++++++++++++++++++ TdomCMPcdataChoiceParticle ++++++++++++++++++++++
constructor TdomCMPcdataChoiceParticle.create(const aOwner: TdomCustomCMObject;
                                              const freq: wideString);
begin
  if freq <> '*'
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner,freq);
  FNodeName:= '#pcdata-choice-particle';
  FNodeType:= ctPcdataChoiceParticle;
  FAllowedChildTypes:= [ctElementParticle];
end;

function TdomCMPcdataChoiceParticle.contentModelTest(const source,
                                                           rest: TStringList): boolean;
begin
  raise EInternalParserException.create('Internal Parser Exception in TdomCMParticle.contentModelTest');
end;

procedure TdomCMPcdataChoiceParticle.writeCode(stream: TStream);
var
  i: integer;
begin
  writeWideString(stream, '( #PCDATA');
  for i:= 0 to childnodes.length-1 do begin
    writeWideChars(stream, [' ', '|', ' ']);
    ChildNodes.item(i).writeCode(stream);
  end;
  writeWideChars(stream, [' ', ')']);
  writeWideString(stream, Frequency);
end;

procedure TdomCMPcdataChoiceParticle.SetFrequency(const freq: wideString);
begin
  if freq <> '*'
    then raise EInvalid_Character_Err.create('Invalid character error.');
  FFrequency:= freq;
end;

function TdomCMPcdataChoiceParticle.elementDefined(const elementName: wideString): boolean;
var
  i: integer;
begin
  if not IsXmlName(elementName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  result:= false;
  for i:= 0 to pred(childnodes.length) do begin
    if childnodes.item(i).nodeName = elementName then begin
      result:= true;
      exit;
    end;
  end;
end;

function TdomCMPcdataChoiceParticle.validate(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i: integer;
  particleNames: TStringList;
  e: EParserDuplicate_Name_In_Mixed_Content_Err;
begin
  result:= true;
  particleNames:= TStringList.create;
  particleNames.Sorted:= true;
  particleNames.Duplicates:= dupError;
  try
    for i:= 0 to pred(childnodes.length) do begin
      try
        particleNames.Add(childnodes.item(i).nodeName);
      except  // xxx not elegant
        result:= false;
        e:= EParserDuplicate_Name_In_Mixed_Content_Err.create('Duplicate_Name_In_Mixed_Content_Err');
        try
          if assigned(errorHandler) then errorhandler.error(nil,nil,e,code);
        finally
          e.free;
        end; {try ... finally ...}
        break;
      end; {try ... except ...}
    end; {for ...}
  finally
    particleNames.free;
  end;
end;



// +++++++++++++++++++++ TdomCMElementParticle +++++++++++++++++++++++++
constructor TdomCMElementParticle.create(const aOwner: TdomCustomCMObject;
                                         const name,
                                               freq: wideString);
begin
  if not isXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner,freq);
  FNodeName:= name;
  FNodeType:= ctElementParticle;
  FAllowedChildTypes:= [];
end;

function TdomCMElementParticle.contentModelTest2(const source,
                                                       rest: TStringList;
                                                 const freq: wideString): boolean;
begin
  result:= false;
  rest.Assign(source);
  if freq = '' then begin
    if rest.Count = 0 then exit;
    if rest[0] = nodeName then begin
      rest.delete(0);
      result:= true;
    end else result:= false;
  end else if freq = '?' then begin
    result:= true;
    if rest.Count = 0 then exit;
    if rest[0] = nodeName then rest.delete(0);
  end;
end;

procedure TdomCMElementParticle.writeCode(stream: TStream);
begin
  writeWideStrings(stream, [NodeName, Frequency]);
end;

function TdomCMElementParticle.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



// +++++++++++++++++++++++ TdomCMNameParticle ++++++++++++++++++++++++++
constructor TdomCMNameParticle.create(const aOwner: TdomCustomCMObject;
                                      const name: wideString);
begin
  if not isXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeType:= ctNameParticle;
  FAllowedChildTypes:= [];
end;

procedure TdomCMNameParticle.SetNodeValue(const value: wideString);
begin
end;

procedure TdomCMNameParticle.writeCode(stream: TStream);
begin
  writeWideStrings(stream, [NodeName]);
end;

function TdomCMNameParticle.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



// +++++++++++++++++++++ TdomCMNmtokenParticle +++++++++++++++++++++++++
constructor TdomCMNmtokenParticle.create(const aOwner: TdomCustomCMObject;
                                         const name: wideString);
begin
  if not isXmlNmtoken(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeType:= ctNmtokenParticle;
  FAllowedChildTypes:= [];
end;

procedure TdomCMNmtokenParticle.SetNodeValue(const value: wideString);
begin
end;

procedure TdomCMNmtokenParticle.writeCode(stream: TStream);
begin
  writeWideStrings(stream, [NodeName]);
end;

function TdomCMNmtokenParticle.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



// ++++++++++++++++++++++++++ TdomCMAttribute ++++++++++++++++++++++++++
constructor TdomCMAttribute.create(const aOwner: TdomCustomCMObject;
                                   const elementName,
                                         attributeName,
                                         attType,
                                         defaultDecl,
                                         attValue: wideString);

  procedure FurtherAttrNormalization(var S: wideString);
  const
    DOUBLESPACE: wideString = #$20#$20;
  var
    dummy: wideString;
    nPos: integer;
  begin
    repeat
      nPos := Pos(DOUBLESPACE, S);
      if nPos > 0 then
        Delete(S, nPos, 1);
    until nPos = 0;
    dummy:= S;
    s:= XMLTruncSpace(dummy);
  end;

const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
var
  normalizedAttValue: wideString;
begin
  if not IsXmlName(attributeName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not IsXmlName(elementName)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( (attType='') or (attType='NOTATION') or
    IsXmlStringType(attType) or IsXmlTokenizedType(attType) )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( (defaultDecl = '#REQUIRED') or (defaultDecl = '#IMPLIED') or
           (defaultDecl = '#FIXED') or (defaultDecl = '') )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if ((defaultDecl = '#REQUIRED') or (defaultDecl = '#IMPLIED'))
    and (attValue <> '')
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if ((defaultDecl = '#FIXED') or (defaultDecl = ''))
    and (attValue = '')
    then raise EInvalid_Character_Err.create('Invalid character error.');
  normalizedAttValue:= attValue;
  if not IsXmlStringType(attType)
    then FurtherAttrNormalization(normalizedAttValue);
  if not ( IsXMLAttValue(concat(dQuote,normalizedAttValue,dQuote)) or
    IsXMLAttValue(concat(sQuote,normalizedAttValue,sQuote)) )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FAttributeName:= attributeName;
  FElementName:= elementName;
  FNodeName:= '#cm-attribute';
  FNodeType:= ctAttribute;
  FAttributeType:= attType;
  FDefaultDeclaration:= defaultDecl;
  FNodeValue:= normalizedAttValue;
  FAllowedChildTypes:= [];
  if attType = ''
    then FAllowedChildTypes:= [ctNmtokenParticle];
  if attType = 'NOTATION'
    then FAllowedChildTypes:= [ctNameParticle];
end;

procedure TdomCMAttribute.setNodeValue(const value: wideString);
begin
end;




// ++++++++++++++++++++++++++ TdomCMNotation ++++++++++++++++++++++++++
constructor TdomCMNotation.create(const aOwner: TdomCustomCMObject;
                                  const name,
                                        pubId,
                                        sysId: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if ( not ( IsXMLSystemLiteral(concat(dQuote,systemId,dQuote)) or
    IsXMLSystemLiteral(concat(sQuote,sysId,sQuote)) ) )
    and ( not ( IsXMLPubidLiteral(concat(dQuote,publicId,dQuote)) or
    IsXMLPubidLiteral(concat(sQuote,pubId,sQuote)) ) )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeValue:= '';
  FPublicId:= pubId;
  FSystemId:= sysId;
  FNodeType:= ctNotation;
  FAllowedChildTypes:= [];
end;



// +++++++++++++++++++++++++++ TdomCMEntity +++++++++++++++++++++++++++
constructor TdomCMEntity.create(const aOwner: TdomCustomCMObject;
                                const name,
                                      literalValue,
                                      pubId,
                                      sysId,
                                      versionNumber,
                                      notaName: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLSystemLiteral(concat(dQuote,sysId,dQuote)) or
           IsXMLSystemLiteral(concat(sQuote,sysId,sQuote))    )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLPubidLiteral(concat(dQuote,pubId,dQuote)) or
           IsXMLPubidLiteral(concat(sQuote,pubId,sQuote))     )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not (IsXmlVersionNum(versionNumber) or (versionNumber = ''))
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeValue:= '';
  FNotationName:= notaName;
  FIsParsedEntity:= (notaName = '');
  FNodeType:= ctEntity;
  FIsUnusable:= false;
  FPublicId:= pubId;
  FSystemId:= sysId;
  FVersion:= Versionnumber;
  if (pubId = '') and (sysId = '')
    then FIsInternalEntity:= true
    else FIsInternalEntity:= false;
  FEncoding:= '';
  FVersion:= '';
  FAllowedChildTypes:= [];
  if FIsParsedEntity then begin
    FLiteralValue:= literalValue;
    FReplacementText:= CalculateReplacementText(FLiteralValue);
  end else begin
    FLiteralValue:= '';
    FReplacementText:= '';
  end;
end;

function TdomCMEntity.refersToXyz(const allowUnresolvableEntities: boolean;
                                  const previousEntities: TStringList;
                                  const whatToTest: integer): boolean;
// Recursivly tests, whether the TdomCMEntity is an external entity
// (whatToTest = 1), or an unparsed entity (whatToTest = 2), or is
// unusable (whatToTest = 3).  To just traverse through all resolved
// entity references in order to test for circular references,
// 'whatToTest' must be set to 0.
const
  AMP:       WideChar = #$26;  // '&'
  SEMICOLON: WideChar = #$3B;  // ';'
var
  i,j: integer;
  SChar, SChar2: widechar;
  ref,refName,S: wideString;
  dereferencedEntity: TdomCMEntity;
  updatedEntities: TStringList;
begin
  case whatToTest of
    0: Result:= false;
    1: result:= not FIsInternalEntity;
    2: result:= not FIsParsedEntity;
    3: result:= FIsUnusable;
  else
    raise ESyntax_Err.create('Syntax error in TdomCMEntity.refersToXyz');
  end;
  if result then exit;
  S:= ReplacementText;
  i:= 1;
  while i <= length(S) do begin
    SChar:= WideChar((PWideChar(S)+i-1)^);
    if SChar = AMP then begin {Reference?}
      for j:= i+1 to length(S) do begin
        SChar2:= WideChar((PWideChar(S)+j-1)^);
        if SChar2 = SEMICOLON then break;
      end;
      ref:= copy(S,i,j-i+1);
      if IsXmlEntityRef(ref) then begin
        refName:= copy(ref,2,length(ref)-2);
        if not (previousEntities.indexOf(refName) = -1)
          then raise EConvertError.create('Circular reference found.');
        dereferencedEntity:= (ownerCMObject as TdomCMObject).Entities.getNamedItem(refName);
        if not assigned(dereferencedEntity) then begin
          if not allowUnresolvableEntities
            then if not ( (refName='lt') or (refName='gt') or (refName='amp') or (refName='apos') or (refName='quot'))
              then raise EConvertError.CreateFmt('&%S; cannot be resolved.',[ref]);
        end else begin
          updatedEntities:= TStringList.create;
          updatedEntities.Assign(previousEntities);
          updatedEntities.Add(refName);
          try
            Result:= dereferencedEntity.refersToXyz(allowUnresolvableEntities,updatedEntities,whatToTest);
          finally
            updatedEntities.free;
          end;
        end;
        if result then exit;
      end; // Test for IsXmlCharRef is not necessary here, because of the previous test in calculateReplacementText().
      i:= j;
    end;
    inc(i);
  end; {while ...}
end;

function TdomCMEntity.refersToExternalEntity(const allowUnresolvableEntities: boolean): boolean;
// This function returns 'true', if a node refers directly or
// indirectly to an external Entity.
var
  previousEntities: TStringList;
begin
  result:= false;
  previousEntities:= TStringList.create;
  try
    try
      result:= refersToXyz(allowUnresolvableEntities,previousEntities,1);
    except
      raise EInvalid_Entity_Reference_Err.create('Invalid entity reference error.');
    end;
  finally
    previousEntities.free;
  end;
end;

function TdomCMEntity.refersToUnparsedEntity(const allowUnresolvableEntities: boolean): boolean;
// This function returns 'true', if a node refers directly or
// indirectly to an unparsed Entity.
var
  previousEntities: TStringList;
begin
  result:= false;
  previousEntities:= TStringList.create;
  try
    try
      result:= refersToXyz(allowUnresolvableEntities,previousEntities,2);
    except
      raise EInvalid_Entity_Reference_Err.create('Invalid entity reference error.');
    end;
  finally
    previousEntities.free;
  end;
end;

function TdomCMEntity.refersToUnusableEntity(const allowUnresolvableEntities: boolean): boolean;
// This function returns 'true', if a node refers directly or
// indirectly to an Entity marked as unusable (such as declared
// e.g. by <!ENTITY foo "<">), or if the node itself is unusable.
var
  previousEntities: TStringList;
begin
  result:= false;
  previousEntities:= TStringList.create;
  try
    try
      result:= refersToXyz(allowUnresolvableEntities,previousEntities,3);
    except
      raise EInvalid_Entity_Reference_Err.create('Invalid entity reference error.');
    end;
  finally
    previousEntities.free;
  end;
end;

procedure TdomCMEntity.testForCircularReference(const allowUnresolvableEntities: boolean);
// This procedure just traverses through all entity references in
// order to test for circular references.  If a circular reference is
// found, the called subroutine 'refersToXyz' raises an EConvertError.
var
  previousEntities: TStringList;
begin
  previousEntities:= TStringList.create;
  try
    refersToXyz(allowUnresolvableEntities,previousEntities,0);
  finally
    previousEntities.free;
  end;
end;

function TdomCMEntity.calculateReplacementText(S: wideString): wideString;
const
  TAB:       WideChar = #$9;   // Horizontal Tabulation
  LF:        WideChar = #$A;   // Line Feed
  CR:        WideChar = #$D;   // Carriage Return
  SPACE:     WideChar = #$20;  // ' '
  AMP:       WideChar = #$26;  // '&'
  SEMICOLON: WideChar = #$3B;  // ';'
var
  i,j,indexpos: integer;
  SChar, SChar2: widechar;
  ref: wideString;
  content: TdomCustomStr;
  parser: TXmlToDomParser;
  dummyDoc: TdomDocument;
begin
  if not isParsedEntity
    then raise EConvertError.CreateFmt('&%S; is an unparsed entity.',[Nodename]);
  Result:= '';
  content:= TdomCustomStr.create;
  try
    i:= 1;
    while i <= length(S) do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if IsUtf16LowSurrogate(sChar)
        then raise EInvalid_Character_Err.CreateFmt('%S must not start with a UTF-16 low surrogate.',[S]);
      if IsUtf16HighSurrogate(SChar) then begin
        if i+1 > length(s)
          then raise EInvalid_Character_Err.CreateFmt('%S must not end with a UTF-16 high surrogate.',[S]);
        inc(i);
        SChar:= WideChar((PWideChar(S)+i-1)^);
        if not IsUtf16LowSurrogate(SChar)
          then raise EInvalid_Character_Err.CreateFmt('%S contains an UTF-16 high surrogate without its corresponding low surrogate.',[S]);
      end;
      if not IsXmlChar(sChar)
        then raise EInvalid_Character_Err.CreateFmt('%S contains an invalid character.',[S]);
      if SChar = AMP then begin {Reference?}
        indexpos:= -1;
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = SEMICOLON then begin indexpos:= j; break; end;
        end;
        if indexpos = -1
          then raise EInvalid_Character_Err.CreateFmt('%S contains an ''&'' without a '';''.',[S]);
        ref:= copy(S,i,j-i+1);
        if not (IsXmlEntityRef(ref) or IsXmlCharRef(ref))
          then raise EInvalid_Character_Err.CreateFmt('%S contains an invalid reference.',[S]);
        if IsXmlCharRef(ref)
          then content.addWideString(XmlCharRefToStr(ref))
          else content.addWideString(ref);
        i:= j;
      end else content.addWideChar(SChar);
      inc(i);
    end; {while ...}
    Result:= content.value;
  finally
    content.free;
  end;

  // IsUnusable?
  parser:= TXmlToDomParser.create(nil);
  parser.domImpl:= OwnerCMObject.domImplementation;
  dummyDoc:= OwnerCMObject.domImplementation.createDocument('dummy',nil);
  try
    parser.docWideStringToDom(result,'','',dummyDoc.documentElement);
  except
    FIsUnusable:= true;
  end; {try ...}
  OwnerCMObject.domImplementation.FreeDocument(dummyDoc);
  parser.free;
end;

function TdomCMEntity.getIsUnusable: boolean;
begin
  result:= refersToUnusableEntity(true);
end;

function TdomCMEntity.getNormalizedValue: wideString;
const
  TAB:       WideChar = #$9;   // Horizontal Tabulation
  LF:        WideChar = #$A;   // Line Feed
  CR:        WideChar = #$D;   // Carriage Return
  SPACE:     WideChar = #$20;  // ' '
  AMP:       WideChar = #$26;  // '&'
  SEMICOLON: WideChar = #$3B;  // ';'
var
  i,j: integer;
  SChar, SChar2: widechar;
  ref,derefText,S: wideString;
  content: TdomCustomStr;
  dereferencedEntity: TdomCMEntity;
begin
  if not isParsedEntity
    then raise EConvertError.CreateFmt('&%S; is an unparsed entity.',[Nodename]);
  if refersToUnparsedEntity(false)  // This simultaniously test for circular and unresolvable references, too.
    then raise EConvertError.CreateFmt('&%S; refers to an unparsed entity.',[Nodename]);
  Result:= '';
  S:= ReplacementText;
  content:= TdomCustomStr.create;
  try
    i:= 1;
    while i <= length(S) do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if (SChar = TAB) or (SChar = LF) or (SChar = CR) // White space?
        then content.addWideChar(SPACE)
      else if SChar = AMP then begin                   // Reference?
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = SEMICOLON then break;            // End of Reference?
        end;
        // Test for indexpos = -1 is not necessary here, because of the previous test in calculateReplacementText().
        ref:= copy(S,i,j-i+1);
        if IsXmlEntityRef(ref) then begin
          dereferencedEntity:= (ownerCMObject as TdomCMObject).Entities.getNamedItem(copy(ref,2,length(ref)-2));
          derefText:= dereferencedEntity.normalizedValue; // Whether dereferencedEntity is assigned was tested in 'refersToUnparsedEntity'
          content.addWideString(derefText);
        end else // Test for IsXmlCharRef is not necessary here, because of the previous test in calculateReplacementText().
          content.addWideString(XmlCharRefToStr(ref));
        i:= j;
      end else content.addWideChar(SChar);
      inc(i);
    end; {while ...}
    Result:= content.value;
  finally
    content.free;
  end;
end;

function TdomCMEntity.getResolvedValue: wideString;
const
  TAB:       WideChar = #$9;   // Horizontal Tabulation
  LF:        WideChar = #$A;   // Line Feed
  CR:        WideChar = #$D;   // Carriage Return
  SPACE:     WideChar = #$20;  // ' '
  AMP:       WideChar = #$26;  // '&'
  SEMICOLON: WideChar = #$3B;  // ';'
var
  i,j: integer;
  SChar, SChar2: widechar;
  ref,derefText,S: wideString;
  content: TdomCustomStr;
  dereferencedEntity: TdomCMEntity;
begin
  if not isParsedEntity
    then raise EConvertError.CreateFmt('&%S; is an unparsed entity.',[Nodename]);
  if refersToUnparsedEntity(false)  // This simultaniously test for circular and unresolvable references, too.
    then raise EConvertError.CreateFmt('&%S; refers to an unparsed entity.',[Nodename]);
  Result:= '';
  S:= ReplacementText;
  content:= TdomCustomStr.create;
  try
    i:= 1;
    while i <= length(S) do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if SChar = AMP then begin                   // Reference?
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = SEMICOLON then break;            // End of Reference?
        end;
        // Test for indexpos = -1 is not necessary here, because of the previous test in calculateReplacementText().
        ref:= copy(S,i,j-i+1);
        if IsXmlEntityRef(ref) then begin
          dereferencedEntity:= (ownerCMObject as TdomCMObject).Entities.getNamedItem(copy(ref,2,length(ref)-2));
          derefText:= dereferencedEntity.resolvedValue; // Whether dereferencedEntity is assigned was tested in 'refersToUnparsedEntity'
          content.addWideString(derefText);
        end else // Test for IsXmlCharRef is not necessary here, because of the previous test in calculateReplacementText().
          content.addWideString(XmlCharRefToStr(ref));
        i:= j;
      end else content.addWideChar(SChar);
      inc(i);
    end; {while ...}
    Result:= content.value;
  finally
    content.free;
  end;
end;

procedure TdomCMEntity.setNodeValue(const value: wideString);
begin
end;

procedure TdomCMEntity.setIsUnusable(const value: boolean);
begin
  FIsUnusable:= value;
end;



// +++++++++++++++++++++ TdomCMParameterEntity ++++++++++++++++++++++++
constructor TdomCMParameterEntity.create(const aOwner: TdomCustomCMObject;
                                         const name,
                                               entityValue,
                                               pubId,
                                               sysId,
                                               versionNumber: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLSystemLiteral(concat(dQuote,sysId,dQuote)) or
           IsXMLSystemLiteral(concat(sQuote,sysId,sQuote))    )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLPubidLiteral(concat(dQuote,pubId,dQuote)) or
           IsXMLPubidLiteral(concat(sQuote,pubId,sQuote))     )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not (IsXmlVersionNum(versionNumber) or (versionNumber = ''))
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeType:= ctParameterEntity;
  FNodeValue:= entityValue;
  FEncoding:= '';
  FVersion:= Versionnumber;
  FPublicId:= pubId;
  FSystemId:= sysId;
  if (pubId = '') and (sysId = '')
    then FIsInternalEntity:= true
    else FIsInternalEntity:= false;
  FAllowedChildTypes:= [];
  FIsReadonly:= true;
end;

function  TdomCMParameterEntity.getIsUnusable: boolean;
begin
  Result:= FIsUnusable;
end;

procedure TdomCMParameterEntity.setIsUnusable(const value: boolean);
begin
  FIsUnusable:= value;
end;



// ++++++++++++++++++++++++ TdomCustomCMEntDecl ++++++++++++++++++++++++++
constructor TdomCustomCMEntDecl.create(const aOwner: TdomCustomCMObject;
                                       const name,
                                             pubId,
                                             sysId: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLSystemLiteral(concat(dQuote,sysId,dQuote)) or
           IsXMLSystemLiteral(concat(sQuote,sysId,sQuote))    )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if not ( IsXMLPubidLiteral(concat(dQuote,pubId,dQuote)) or
           IsXMLPubidLiteral(concat(sQuote,pubId,sQuote))     )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FPublicId:= pubId;
  FSystemId:= sysId;
  if (pubId = '') and (sysId = '')
    then FIsInternalEntity:= true
    else FIsInternalEntity:= false;
end;

function TdomCustomCMEntDecl.insertBefore(const newChild,
                                               refChild: TdomCMNode): TdomCMNode;
begin
  if (publicId <> '') or (systemId <> '')
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= inherited insertBefore(newChild,refChild);
end;

function TdomCustomCMEntDecl.replaceChild(const newChild,
                                                oldChild: TdomCMNode): TdomCMNode;
begin
  if (publicId <> '') or (systemId <> '')
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= inherited replaceChild(newChild,oldChild);
end;

function TdomCustomCMEntDecl.appendChild(const newChild: TdomCMNode): TdomCMNode;
begin
  if (publicId <> '') or (systemId <> '')
    then raise ENo_Modification_Allowed_Err.create('No modification allowed error.');
  Result:= inherited appendChild(newChild);
end;

function TdomCustomCMEntDecl.GetPublicId: wideString;
begin
  Result:= FPublicId;
end;

function TdomCustomCMEntDecl.GetSystemId: wideString;
begin
  Result:= FSystemId;
end;

function TdomCustomCMEntDecl.GetIsInternalEntity: boolean;
begin
  Result:= FIsInternalEntity;
end;



// +++++++++++++++++++++ TdomCMEntityDeclaration +++++++++++++++++++++++
constructor TdomCMEntityDeclaration.create(const aOwner: TdomCustomCMObject;
                                           const name,
                                                 entityValue,
                                                 pubId,
                                                 sysId,
                                                 notaName: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if not (IsXMLName(notaName) or (notaName = '') )
    then raise EInvalid_Character_Err.create('Invalid character error.');
  if (entityValue <> '') then begin
    if not ( IsXmlEntityValue(concat(dQuote,systemId,dQuote)) or
             IsXmlEntityValue(concat(sQuote,sysId,sQuote)) )
      then raise EInvalid_Character_Err.create('Invalid character error.');
    if not ( (pubId = '') and (sysId = '') and (notaName = '') )
      then raise EInvalid_Character_Err.create('Invalid character error.');
  end;
  inherited create(aOwner,name,pubId,sysId);
  FNotationName:= notaName;
  FIsParsedEntity:= (notaName = '');
  FNodeType:= ctEntityDeclaration;
  FNodeValue:= entityValue;
  FAllowedChildTypes:= [];
  FIsReadonly:= true;
end;

procedure TdomCMEntityDeclaration.writeCode(stream: TStream);
const
  sQuote: WideChar  = #$0027;
  dQuote: WideChar  = '"';
var
  pubId, sysId, ndVal: wideString;
  Quote: WideChar;
begin
  writeWideStrings(stream, ['<!ENTITY ', NodeName]);
  writeWideChars(stream, [' ']);
  pubId := publicId;
  sysId := systemId;
  ndVal := NodeValue;
  if (pubId = '') and (sysId = '') then begin
    if Pos(dQuote,ndVal) > 0 then Quote := sQuote else Quote := dQuote;
    writeWideChars(stream, [#9, Quote]);
    writeWideString(stream, ndVal);
    writeWideChars(stream, [Quote]);
  end else
    writeWideString(stream, XMLAnalysePubSysId(pubId,sysId,notationName));
  writeWideChars(stream, ['>']);
end;

function TdomCMEntityDeclaration.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



// ++++++++++++++++ TdomCMParameterEntityDeclaration +++++++++++++++++++
constructor TdomCMParameterEntityDeclaration.create(const aOwner: TdomCustomCMObject;
                                                    const name,
                                                          entityValue,
                                                          pubId,
                                                          sysId: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if (entityValue <> '') then begin
    if not ( IsXmlEntityValue(concat(dQuote,systemId,dQuote)) or
             IsXmlEntityValue(concat(sQuote,sysId,sQuote)) )
      then raise EInvalid_Character_Err.create('Invalid character error.');
    if not ( (pubId = '') and (sysId = '') )
      then raise EInvalid_Character_Err.create('Invalid character error.');
  end;
  inherited create(aOwner,name,pubId,sysId);
  FNodeType:= ctParameterEntityDeclaration;
  FNodeValue:= entityValue;
  FAllowedChildTypes:= [];
  FISReadonly:= true;
end;

procedure TdomCMParameterEntityDeclaration.writeCode(stream: TStream);
const
  sQuote: WideChar  = #$0027;
  dQuote: WideChar  = '"';
var
  pubId, sysId, ndVal: wideString;
  Quote: WideChar;
begin
  writeWideStrings(stream, ['<!ENTITY % ', NodeName]);
  writeWideChars(stream, [' ']);
  pubId := publicId;
  sysId := systemId;
  ndVal := NodeValue;
  if (pubId = '') and (sysId = '') then begin
    if Pos(dQuote,ndVal) > 0 then Quote := sQuote else Quote := dQuote;
    writeWideChars(stream, [#9, Quote]);
    writeWideString(stream, ndVal);
    writeWideChars(stream, [Quote]);
  end else
    writeWideString(stream, XMLAnalysePubSysId(pubId,sysId,''));
  writeWideChars(stream, ['>']);
end;

function TdomCMParameterEntityDeclaration.validate(const errorHandler: TdomCustomErrorHandler): boolean;
begin
  result:= true;
end;



// +++++++++++++++++++ TdomCMParameterEntityReference +++++++++++++++++++
constructor TdomCMParameterEntityReference.create(const aOwner: TdomCustomCMObject;
                                                  const name: wideString);
begin
  if not IsXmlName(name)
    then raise EInvalid_Character_Err.create('Invalid character error.');
  inherited create(aOwner);
  FNodeName:= name;
  FNodeValue:= '';
  FNodeType:= ctParameterEntityReference;
  FAllowedChildTypes:= [];
end;

procedure TdomCMParameterEntityReference.writeCode(stream: TStream);
begin
  writeWideChars(stream, ['%']);
  writeWideString(stream, NodeName);
  writeWideChars(stream, [';']);
end;

procedure TdomCMParameterEntityReference.SetNodeValue(const value: wideString);
begin
end;

function TdomCMParameterEntityReference.validate(const errorHandler: TdomCustomErrorHandler): boolean;
var
  i: integer;
begin
  result:= true;
  for i:= 0 to pred(childnodes.length) do begin  // xxx necessary?
    if not childnodes.item(i).validate(errorHandler) then begin
      result:= false;
      exit;
    end;
  end;
end;



// ++++++++++++++++++++++++ TdomCMFragment +++++++++++++++++++++++++++++
constructor TdomCMFragment.create(const aOwner: TdomCustomCMObject);
begin
  inherited create(aOwner);
  FNodeName:= '#cm-fragment';
  FNodeValue:= '';
  FNodeType:= ctFragment;
end;

procedure TdomCMFragment.SetNodeValue(const value: wideString);
begin
end;



// +++++++++++++++++++++++++++ TXmlSourceCode ++++++++++++++++++++++++++
procedure TXmlSourceCode.calculatePieceOffset(const startItem: integer);
var
  os, i: integer;
begin
  if (startItem < count) and (startItem >= 0) then begin
    if startItem = 0
      then os:= 0
      else begin
        if not assigned(Items[startItem-1])
          then begin
            pack;
            exit;
          end else with TXmlSourceCodePiece(Items[startItem-1]) do
            os:= FOffset + length(FText);
      end;
    for i:= startItem to count -1 do
      if not assigned(Items[i])
        then begin
          pack;
          exit;
        end else with TXmlSourceCodePiece(Items[i]) do begin
          FOffset:= os;
          os:= os + length(FText);
        end;
  end; {if ...}
end;

function TXmlSourceCode.getNameOfFirstTag: wideString;
var
  i,j,k: integer;
begin
  Result:= '';
  for i:= 0 to count -1 do
    if assigned(Items[i]) then
      with TXmlSourceCodePiece(Items[i]) do
        if (pieceType = xmlStartTag) or (pieceType = xmlEmptyElementTag) then begin
          if pieceType = xmlStartTag
            then k:= length(text)-1
            else k:= length(text)-2;
          j:= 1;
          while j < k do begin
            inc(j);
            if IsXmlWhiteSpace(text[j]) then break;
            Result:= concat(Result,wideString(WideChar(text[j])));
          end;
          exit;
        end;
end;

function TXmlSourceCode.Add(Item: pointer): Integer;
begin
  if assigned(Item) then begin
    if not assigned(TXmlSourceCodePiece(Item).FOwner)
      then TXmlSourceCodePiece(Item).FOwner:= self
      else Error('Inuse source code piece error.',-1);
  end else Error('Item not assigned error.',-1);
  Result:= inherited Add(Item);
  calculatePieceOffset(Result);
end;

procedure TXmlSourceCode.Clear;
var
  i: integer;
begin
  for i:= 0 to count -1 do
    if assigned(Items[i]) then
      with TXmlSourceCodePiece(Items[i]) do begin
        FOffset:= 0;
        FOwner:= nil;
      end;
  inherited clear;
end;

procedure TXmlSourceCode.ClearAndFree;
var
  i: integer;
begin
  for i:= 0 to count -1 do
    if assigned(Items[i]) then TXmlSourceCodePiece(Items[i]).free;
  inherited clear;
end;

procedure TXmlSourceCode.Delete(Index: Integer);
begin
  if assigned(Items[index]) then
    with TXmlSourceCodePiece(Items[index]) do begin
      FOffset:= 0;
      FOwner:= nil;
    end;
  inherited delete(index);
  calculatePieceOffset(Index);
end;

procedure TXmlSourceCode.Exchange(Index1, Index2: Integer);
var
  nr: integer;
begin
  nr:= MinIntValue([Index1,Index2]);
  inherited Exchange(Index1,Index2);
  calculatePieceOffset(nr);
end;

function TXmlSourceCode.GetPieceAtPos(pos: integer): TXmlSourceCodePiece;
// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// xxx   This search is not optimized.  Anybody out there, who   xxx
// xxx   wants to do it?  Please email me: service@philo.de.     xxx
// xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
var
  i: integer;
begin
  Result:= nil;
  if pos < 1 then exit;
  for i:= 0 to count -1 do
    if not assigned(Items[i]) then begin
      pack;
      Result:= getPieceAtPos(pos);
    end else with TXmlSourceCodePiece(Items[i]) do begin
      if (FOffset + length(FText)) >= pos then begin
        Result:= TXmlSourceCodePiece(Items[i]);
        exit;
      end;
    end;
end;

procedure TXmlSourceCode.Insert(Index: Integer; Item: pointer);
begin
  if assigned(Item) then begin
    if not assigned(TXmlSourceCodePiece(Item).FOwner)
      then TXmlSourceCodePiece(Item).FOwner:= self
      else Error('Inuse source code piece error.',-1);
  end else Error('Item not assigned error.',-1);
  inherited Insert(Index,item);
  calculatePieceOffset(index);
end;

procedure TXmlSourceCode.Move(CurIndex, NewIndex: Integer);
var
  nr: integer;
begin
  nr:= MinIntValue([CurIndex,NewIndex]);
  inherited Move(CurIndex, NewIndex);
  calculatePieceOffset(nr);
end;

procedure TXmlSourceCode.Pack;
begin
  inherited pack;
  calculatePieceOffset(0);
end;

function TXmlSourceCode.Remove(Item: pointer): Integer;
var
  nr: integer;
begin
  nr:= IndexOf(Item);
  result:= inherited Remove(Item);
  if assigned(Items[nr]) then
    with TXmlSourceCodePiece(Item) do begin
      FOffset:= 0;
      FOwner:= nil;
    end;
  calculatePieceOffset(nr);
end;

procedure TXmlSourceCode.Sort(Compare: TListSortCompare);
begin
  inherited Sort(Compare);
  calculatePieceOffset(0);
end;



// ++++++++++++++++++++++++ TXmlSourceCodePiece ++++++++++++++++++++++++
constructor TXmlSourceCodePiece.create(const pt: TdomPieceType);
begin
  FPieceType:= pt;
  Ftext:= '';
  FOffset:= 0;
  FOwner:= nil;
end;



// ++++++++++++++++++++++++++ TXmlInputSource ++++++++++++++++++++++++++
constructor TXmlInputSource.create(const stream: TStream;
                                   const publicId,
                                         systemId: wideString);
begin
  if not assigned(stream)
    then raise EStreamError.create('Stream not specified.');
  inherited create;
  FLastUcs4:= 0;
  FLastCharWasCR:= false;
  FStream:= stream;
  FPublicId:= publicId;
  FSystemId:= systemId;
  FEncoding:= getEncodingType;
  FLocator:= TdomStandardLocator.create(self);
  FRootName:= getRootName;
end;

destructor TXmlInputSource.destroy;
begin
  // October 16, 2001 - Borland Change - iconv cleanup code.
{$IFDEF LINUX}
  if FEncoding = etsystem then iconv_close(FIConv);
{$ENDIF}
  FLocator.free;
  inherited destroy;
end;

function TXmlInputSource.getEncodingType: TdomEncodingType;
var
  Str1: WideChar;
  str0: char;
  dummyDoc: TdomDocument;
  EncodingAttr: TdomAttr;
  newElement: TdomElement;
  AttrSequence: TdomCustomStr;
  encoding: wideString;
begin
  FStream.seek(0,soFromBeginning);
  try
    FStream.ReadBuffer(Str1,2);
    if ord(str1) = $feff then begin
      result:= etUTF16BE
    end else begin
      if ord(str1) = $fffe then begin
        result:= etUTF16LE
      end else begin
        result:= etUTF8;
        if ord(str1) = $3f3c then begin
          FStream.ReadBuffer(Str1,2);
          if ord(str1) = $6d78 then begin
            FStream.ReadBuffer(Str0,1);
            if ord(str0) = $6c then begin
              FStream.ReadBuffer(Str0,1);
              Str1:= WideChar(ord(str0));
              if IsXmlWhiteSpace(Str1) then begin
                dummyDoc:= TdomDocument.create(nil);
                NewElement:= dummyDoc.CreateElement('dummy');
                AttrSequence:= TdomCustomStr.create;
                try
                  FStream.ReadBuffer(Str0,1);
                  Str1:= WideChar(ord(str0));
                  while Str1 <> #$003f do begin  // Test for '?'
                    AttrSequence.addWideChar(Str1);
                    FStream.ReadBuffer(Str0,1);
                    Str1:= WideChar(ord(str0));
                  end;
                  XMLAnalyseAttrSequence(AttrSequence.value,NewElement);
                  EncodingAttr:= (NewElement.Attributes.getNamedItem('encoding') as TdomAttr);
                  if assigned(EncodingAttr)
                    then encoding:= EncodingAttr.value
                    else encoding:= '';
                  if (CompareText(encoding,'ISO-8859-1') = 0)
                    or (CompareText(encoding,'Latin-1') = 0) then
                    result:= etLatin1
                  else if (CompareText(encoding,'ISO-8859-2') = 0)
                    or (CompareText(encoding,'Latin-2') = 0) then
                    result:= etLatin2
                  else if (CompareText(encoding,'ISO-8859-3') = 0)
                    or (CompareText(encoding,'Latin-3') = 0) then
                    result:= etLatin3
                  else if (CompareText(encoding,'ISO-8859-4') = 0)
                    or (CompareText(encoding,'Latin-4') = 0) then
                    result:= etLatin4
                  else if (CompareText(encoding,'ISO-8859-5') = 0)
                    or (CompareText(encoding,'Cyrillic') = 0) then
                    result:= etCyrillic
                  else if (CompareText(encoding,'ISO-8859-6') = 0)
                    or (CompareText(encoding,'Arabic') = 0) then
                    result:= etArabic
                  else if (CompareText(encoding,'ISO-8859-7') = 0)
                    or (CompareText(encoding,'Greek') = 0) then
                    result:= etGreek
                  else if (CompareText(encoding,'ISO-8859-8') = 0)
                    or (CompareText(encoding,'Hebrew') = 0) then
                    result:= etHebrew
                  else if (CompareText(encoding,'ISO-8859-9') = 0)
                    or (CompareText(encoding,'Latin-5') = 0) then
                    result:= etLatin5
                  else if (CompareText(encoding,'ISO-8859-10') = 0)
                    or (CompareText(encoding,'Latin-6') = 0) then
                    result:= etLatin6
                  else if (CompareText(encoding,'ISO-8859-13') = 0)
                    or (CompareText(encoding,'Latin-7') = 0) then
                    result:= etLatin7
                  else if (CompareText(encoding,'ISO-8859-14') = 0)
                    or (CompareText(encoding,'Latin-8') = 0) then
                    result:= etLatin8
                  else if (CompareText(encoding,'ISO-8859-15') = 0)
                    or (CompareText(encoding,'Latin-9') = 0) then
                    result:= etLatin9
                  else if (CompareText(encoding,'KOI8-R') = 0) then
                    result:= etKOI8R
                  else if (CompareText(encoding,'cp10000_MacRoman') = 0) then
                    result:= etcp10000_MacRoman
                  else if (CompareText(encoding,'Windows-1250') = 0)
                    or (CompareText(encoding,'cp1250') = 0) then
                    result:= etcp1250
                  else if (CompareText(encoding,'Windows-1251') = 0)
                    or (CompareText(encoding,'cp1251') = 0) then
                    result:= etcp1251
                  else if (CompareText(encoding,'Windows-1252') = 0)
                    or (CompareText(encoding,'cp1252') = 0) then
                    result:= etcp1250
// October 16, 2001 - Borland Change - Try to use iconv
{$IFDEF LINUX}
                  else begin
                    FIConv := iconv_openW('UCS-4', encoding);
                    if Integer(FIConv) <> -1 then result := etsystem
                  end;
{$ENDIF}
                finally
                  AttrSequence.free;
                  dummyDoc.free;
                end;
              end;
            end;
          end;
        end;
        FStream.seek(0,soFromBeginning);
      end;
    end;
  except
    on EReadError do begin
      result:= etUTF8;
      FStream.seek(0,soFromBeginning);
    end;
    on EdomException do begin
      result:= etUTF8;
      FStream.seek(0,soFromBeginning);
    end;
    on EParserException do begin
      result:= etUTF8;
      FStream.seek(0,soFromBeginning);
    end;
  end; {try ...}
end;

function TXmlInputSource.getRootName: wideString;
// This function performes no complete well-formedness test, so it
// might return a root name even if there is a well-formedness error
// before or in the root element, or before or in a document type
// declaration.
const
  LT: WideChar  = #60;  // '<'
  GT: WideChar  = #62;  // '>'
  QM: WideChar  = #63;  // '?'
  EM: WideChar  = #33;  // '!'
  MI: WideChar  = #45;  // '-'
  SL: WideChar  = #47;  // '/'
  LB: WideChar  = #91;  // '['
var
  Str1: WideChar;
  currentPieceType: TdomPieceType;
  lastChars: wideString;
begin
  result:= '';
  reset;
  currentPieceType:= xmlUnknown;
  try
    repeat
      repeat
        if not getNextWideChar(Str1)
          then begin reset; exit; end;
      until str1 = LT;
      if not getNextWideChar(Str1)
        then begin reset; exit; end;
      if str1 = QM then begin
        currentPieceType:= xmlProcessingInstruction;
      end else begin
        if str1 = EM then begin
          if not getNextWideChar(Str1)
            then begin reset; exit; end;
          if str1 = MI then begin
            if not getNextWideChar(Str1)
              then begin reset; exit; end;
            if str1 = MI
              then currentPieceType:= xmlComment
              else break;
          end else begin
            if str1 = 'D' then begin
              if not getNextWideChar(Str1)
                then begin reset; exit; end;
              if str1 = 'O' then begin
                if not getNextWideChar(Str1)
                  then begin reset; exit; end;
                if str1 = 'C' then begin
                  if not getNextWideChar(Str1)
                    then begin reset; exit; end;
                  if str1 = 'T' then begin
                    if not getNextWideChar(Str1)
                      then begin reset; exit; end;
                    if str1 = 'Y' then begin
                      if not getNextWideChar(Str1)
                        then begin reset; exit; end;
                      if str1 = 'P' then begin
                        if not getNextWideChar(Str1)
                          then begin reset; exit; end;
                        if str1 = 'E' then begin
                          if not getNextWideChar(Str1)
                            then begin reset; exit; end;
                          if isXmlWhiteSpace(str1) then begin
                            currentPieceType:= xmlDoctype;
                            repeat
                              if not getNextWideChar(Str1)
                                then begin reset; exit; end;
                            until not isXmlWhiteSpace(str1);
                          end else break;
                        end else break;
                      end else break;
                    end else break;
                  end else break;
                end else break;
              end else break;
            end else break;
          end; {if str1 = MI ... else ...}
        end else currentPieceType:= xmlStartTag; {if str1 = EM ...}
      end; {if str1 = QM ... else ...}
      case currentPieceType of
      xmlProcessingInstruction: begin
        lastChars:= '';
        repeat
          if not getNextWideChar(Str1)
            then begin reset; exit; end;
          if Str1 = QM then begin
            lastChars:= QM
          end else begin
            if Str1 = GT then begin
              lastChars:= concat(lastChars,wideString('>'));
            end else lastChars:= '';
          end;
        until lastChars = wideString('?>');
        currentPieceType:= xmlUnknown;
        end;
      xmlComment: begin
        lastChars:= '';
        repeat
          if not getNextWideChar(Str1)
            then begin reset; exit; end;
          if (Str1 = MI) and (length(lastChars) < 2) then begin
            lastChars:= concat(lastChars,wideString('-'));  // BTW: This ignores malformed comments
          end else begin
            if (Str1 = GT) and (lastChars = wideString('--'))
              then break // '-->' detected
              else lastChars:= '';
          end;
        until lastChars = wideString('-->');
        currentPieceType:= xmlUnknown;
        end;
      xmlDoctype,xmlStartTag: begin
        lastChars:= '';
        repeat
          lastChars:= concat(lastChars,wideString(Str1));
          if not getNextWideChar(Str1)
            then begin reset; exit; end;
        until isXmlWhiteSpace(Str1) or (Str1 = GT) or (Str1 = SL) or (Str1 = LB);
        if isXmlName(lastChars) then result:= lastChars;
        end;
      end; // case ...
    until currentPieceType <> xmlUnknown;
    reset;
  except
    result:= '';
    reset;
  end;
end;

function TXmlInputSource.getNextWideChar2(var dest: wideChar;
                                          const locator: TdomStandardLocator): boolean;
const
  CR: WideChar  = #13;
  LF: WideChar  = #10;
  MaxCode: array[1..6] of integer = ($7F,$7FF,$FFFF,$1FFFFF,$3FFFFFF,$7FFFFFFF);
var
  str0, first: Char;
  CharSize, ucs4, mask: integer;
// October 16, 2001 - Borland Change - iconv variable declarations
{$IFDEF LINUX}
  src : array[0..9] of Char;
  dst : array[0..9] of Char;
  psrc, pdst : PChar;
  nsrc, ndst, srclen : size_t;
  convResult : Integer;
{$ENDIF}
begin
  if stream.Position < stream.size
    then result:= true
    else begin result:= false; exit; end;
  case Encoding of
    etLatin1: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_1ToUTF16Char(str0);
      end;
    etLatin2: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_2ToUTF16Char(str0);
      end;
    etLatin3: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_3ToUTF16Char(str0);
      end;
    etLatin4: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_4ToUTF16Char(str0);
      end;
    etCyrillic: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_5ToUTF16Char(str0);
      end;
    etArabic: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_6ToUTF16Char(str0);
      end;
    etGreek: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_7ToUTF16Char(str0);
      end;
    etHebrew: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_8ToUTF16Char(str0);
      end;
    etLatin5: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_9ToUTF16Char(str0);
      end;
    etLatin6: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_10ToUTF16Char(str0);
      end;
    etLatin7: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_13ToUTF16Char(str0);
      end;
    etLatin8: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_14ToUTF16Char(str0);
      end;
    etLatin9: begin
        stream.ReadBuffer(str0,1);
        dest:= Iso8859_15ToUTF16Char(str0);
      end;
    etKOI8R: begin
        stream.ReadBuffer(str0,1);
        dest:= KOI8_RToUTF16Char(str0);
      end;
    etcp10000_MacRoman: begin
        stream.ReadBuffer(str0,1);
        dest:= cp10000_MacRomanToUTF16Char(str0);
      end;
    etcp1250: begin
        stream.ReadBuffer(str0,1);
        dest:= cp1250ToUTF16Char(str0);
      end;
    etcp1251: begin
        stream.ReadBuffer(str0,1);
        dest:= cp1251ToUTF16Char(str0);
      end;
    etcp1252: begin
        stream.ReadBuffer(str0,1);
        dest:= cp1252ToUTF16Char(str0);
      end;
// October 16, 2001 - Borland Change - Use iconv conversion
{$IFDEF LINUX}
    etsystem: begin
        if FLastUcs4>=$10000 then begin
          dest:=Utf16LowSurrogate(FLastUcs4);
          FLastUcs4:= 0;
        end else begin
          srclen := 0;
          repeat
            if srclen >= sizeof(src) then
              raise EConvertError.CreateFmt(
                'Too long MBCS sequence at position %d', [stream.Position]);
            stream.ReadBuffer(src[srclen],1);
            Inc(srclen);
            psrc := src;
            nsrc := srclen;
            pdst := dst;
            ndst := Sizeof(dst);
            convResult := iconv(FIConv, psrc, nsrc, Pointer(pdst), ndst);
            if convResult = -1 then begin
              if GetLastError <> EINVAL then
                raise EConvertError.CreateFmt('Invalid MBCS sequence at position %d',[stream.Position-1]);
            end else if dst = pdst then 
              convResult := -1
          until convResult <> -1;

          // big endian
          ucs4 := (Ord(dst[0]) shl 8 + Ord(dst[1])) shl 16 + (Ord(dst[2]) shl 8 + Ord(dst[3]));
          if ucs4 >= $10000 then begin
            FLastUcs4:= ucs4;
            dest:=Utf16HighSurrogate(ucs4);
          end else begin
            dest:= WideChar(ord(ucs4));
          end
        end
      end;
{$ENDIF}
    etUTF8: begin
      if FLastUcs4>=$10000 then begin
        // Output low surrogate
        dest:=Utf16LowSurrogate(FLastUcs4);
        FLastUcs4:= 0;
      end else begin
        stream.ReadBuffer(str0,1);
        if ord(str0)>=$80 then	// UTF-8 sequence
        begin
          CharSize:=1;
          first:=str0; mask:=$40; ucs4:=ord(str0);
          if (ord(str0) and $C0<>$C0) then
            raise EConvertError.CreateFmt('Invalid UTF-8 sequence at position %d',[stream.Position-1]);
          while (mask and ord(first)<>0) do
          begin
            // read next character of stream
            if stream.Position=stream.size then
              raise EConvertError.CreateFmt('Aborted UTF-8 sequence at position %d',[stream.Position]);
            stream.ReadBuffer(str0,1);
            if (ord(str0) and $C0<>$80) then
              raise EConvertError.CreateFmt('Invalid UTF-8 sequence at position %d',[stream.Position-1]);
            ucs4:=(ucs4 shl 6) or (ord(str0) and $3F); // add bits to result
            Inc(CharSize);	// increase sequence length
            mask:=mask shr 1;	// adjust mask
          end;
          if (CharSize>6) then	// no 0 bit in sequence header 'first'
              raise EConvertError.CreateFmt('Invalid UTF-8 sequence at position %d',[stream.Position-1]);
          ucs4:=ucs4 and MaxCode[CharSize];	// dispose of header bits
          // check for invalid sequence as suggested by RFC2279
          if ((CharSize>1) and (ucs4<=MaxCode[CharSize-1])) then
              raise EConvertError.CreateFmt('Invalid UTF-8 encoding at position %d',[stream.Position-1]);
          if (ucs4>=$10000) then
          begin
            // Buffer storage of the ucs4 value for output of the
            // low surrogate at the next function call
            FLastUcs4:= ucs4;
            // Output high surrogate
            dest:=Utf16HighSurrogate(ucs4);
          end
          else
            dest:= WideChar(ord(ucs4));
        end
        else
          dest:= WideChar(ord(str0));
      end; {if FLastUcs4 ... else ...}
    end;
    etUTF16BE: begin
      stream.ReadBuffer(dest,2);
    end;
    etUTF16LE: begin
      stream.ReadBuffer(dest,2);
      dest:= wideChar(Swap(ord(dest)));
    end;
  end; {case ...}

  if (dest = LF) and FLastCharWasCR then begin
    FLastCharWasCR:= false;
    result:= getNextWideChar2(dest,locator);
  end else begin
    if dest = CR then begin
      FLastCharWasCR:= true;
      dest:= LF;
    end else FLastCharWasCR:= false;
  end;
  if assigned(locator) then locator.evaluate(dest);
end;

function TXmlInputSource.getNextWideChar(var dest: wideChar): boolean;
begin
  result:= getNextWideChar2(dest,FLocator);
end;

procedure TXmlInputSource.reset2(const locator: TdomStandardLocator);
begin
  FLastUcs4:= 0;
  FLastCharWasCR:= false;
  case encoding of
    etUTF16BE,etUTF16LE:
      FStream.seek(2,soFromBeginning);
  else
      FStream.seek(0,soFromBeginning);
  end; {case ...}
  if assigned(locator) then locator.reset;
end;

procedure TXmlInputSource.reset;
begin
  reset2(FLocator);
end;

function TXmlInputSource.getStreamAsWideString: wideString;
var
  oldPosition: longint;
  oldFLastUcs4: integer;
  oldFLastCharWasCR: boolean;
  content: TdomCustomStr;
  str1: WideChar;
begin
  oldPosition:= FStream.Position;
  oldFLastUcs4:= FLastUcs4;
  oldFLastCharWasCR:= FLastCharWasCR;
  content:= TdomCustomStr.create;
  try
    skipTextDecl(nil);
    while getNextWideChar2(str1,nil) do begin
      content.addWideChar(str1)
    end;
    result:= content.value;
  finally
    content.free;
    FLastUcs4:= oldFLastUcs4;
    FLastCharWasCR:= oldFLastCharWasCR;
    FStream.seek(oldPosition,soFromBeginning);
  end;
end;

procedure TXmlInputSource.skipTextDecl(const locator: TdomStandardLocator);
// This procedure was provided by Tor Helland.
// xxx No wellformedness test ist performed.
const
  chStart1: WideChar = '<';
  chStart2: WideChar = '?';
  chStart3a: WideChar = 'x';
  chStart3b: WideChar = 'X';
  chStart4a: WideChar = 'm';
  chStart4b: WideChar = 'M';
  chStart5a: WideChar = 'l';
  chStart5b: WideChar = 'L';
  chEnd1: WideChar = '?';
  chEnd2: WideChar = '>';
var
  bFound: boolean;
  ch: WideChar;
begin
  reset2(locator);
  bFound := False;
  try

    // Skip white space:
    repeat
      if not getNextWideChar(ch) then exit;
    until not isXmlWhiteSpace(ch);

    // Check if we have '<?xml' and a white space:
    if (ch = chStart1)
      and getNextWideChar(ch)
      and (ch = chStart2)
      and getNextWideChar(ch)
      and ((ch = chStart3a) or (ch = chStart3b))
      and getNextWideChar(ch)
      and ((ch = chStart4a) or (ch = chStart4b))
      and getNextWideChar(ch)
      and ((ch = chStart5a) or (ch = chStart5b))
      and getNextWideChar(ch)
      and isXmlWhiteSpace(ch) then
    begin
      // Skip till '?':
      repeat
        if not getNextWideChar(ch) then exit;
      until ch = chEnd1;

      if not getNextWideChar(ch) then exit;
      if ch = chEnd2
        then bFound := True; // Found and skipped the text declaration.
    end;

  finally
    if not bFound
      then reset2(locator);
  end;
end;


// ++++++++++++++++++++++++++ TXmlParserError ++++++++++++++++++++++++++
constructor TXmlParserError.create(const e: EParserException;
                                   const startLine,
                                         startColumn,
                                         endLine,
                                         endColumn: integer;
                                   const pubId,
                                         sysId,
                                         code: wideString);
begin
  FErrorClass:= e.classname;
  if e is EParserFatalError
    then FErrorType:= xetFatalError
  else if e is EParserError
    then FErrorType:= xetError
  else if e is EParserWarning
    then FErrorType:= xetWarning;
  FStartLine:= startLine;
  FStartColumn:= startColumn;
  FEndColumn:= endColumn;
  FEndLine:= endLine;
  FPubId:= pubId;
  FSysId:= sysId;
  FCode:= Code;
  inherited create;
end;

function TXmlParserError.getDutchErrorStr: wideString;
// - This function was provided by Erik van der Poll,
// Incore Automatisering b.v., Amsterdam -
var
  ErrorTypeStr,DocStr,ErrorStr1,ErrorStr2: string;
begin
  case errorType of
    xetFatalError: ErrorTypeStr:='FATALE FOUT ';
    xetError: ErrorTypeStr:='FOUT ';
    xetWarning: ErrorTypeStr:='WAARSCHUWING: ';
  end;

  if publicId = '' then begin
    if systemId = ''
      then DocStr:= ''
      else DocStr:= concat('in lokaal document ',systemId,' ');
  end else begin
    if systemId = ''
      then DocStr:= concat('in publiek document ',publicId,' ')
      else DocStr:= concat('in document ',publicId,' (',systemId,') ');
  end;

  if EndLine = 0 then ErrorStr1:= ''
  else if StartLine = EndLine then begin
    if StartColumn = EndColumn
      then FmtStr(ErrorStr1,'in regel %d, positie %d',[EndLine,EndColumn])
      else FmtStr(ErrorStr1,'in regel %d, tussen positie %d en %d',[EndLine,StartColumn,EndColumn]);
  end else begin
    FmtStr(ErrorStr1,'tussen regel %d, positie %d en regel %d, positie %d',[StartLine,StartColumn,EndLine,EndColumn]);
  end;

  if FErrorClass = 'EParserInvalidElementName_Err'
    then ErrorStr2:= 'Onjuiste element naam'
  else if FErrorClass = 'EParserDoubleRootElement_Err'
    then ErrorStr2:= 'Dubbel begin element'
  else if FErrorClass = 'EParserRootNotFound_Err'
    then ErrorStr2:= 'Geen begin element gevonden'
  else if FErrorClass = 'EParserDoubleDoctype_Err'
    then ErrorStr2:= 'Dubbele document type declaratie (DTD)'
  else if FErrorClass = 'EParserInvalidAttributeName_Err'
    then ErrorStr2:= 'Onjuiste attribuut name'
  else if FErrorClass = 'EParserInvalidAttributeValue_Err'
    then ErrorStr2:= 'Onjuiste attribuut waarde'
  else if FErrorClass = 'EParserDoubleAttributeName_Err'
    then ErrorStr2:= 'Dubbele attribuut name in een element'
  else if FErrorClass = 'EParserInvalidEntityName_Err'
    then ErrorStr2:= 'Onjuiste entiteit naam'
  else if FErrorClass = 'EParserInvalidProcessingInstruction_Err'
    then ErrorStr2:= 'Onjuiste verwerkings code'
  else if FErrorClass = 'EParserInvalidXmlDeclaration_Err'
    then ErrorStr2:= 'Onuiste XML declaratie'
  else if FErrorClass = 'EParserInvalidCharRef_Err'
    then ErrorStr2:= 'Onjuiste karakter referentie'
  else if FErrorClass = 'EParserMissingQuotationMark_Err'
    then ErrorStr2:= 'Aanhalingstekens ontbreken'
  else if FErrorClass = 'EParserMissingEqualitySign_Err'
    then ErrorStr2:= 'Is-teken ontbreekt'
  else if FErrorClass = 'EParserDoubleEqualitySign_Err'
    then ErrorStr2:= 'Dubbel is-teken'
  else if FErrorClass = 'EParserMissingWhiteSpace_Err'
    then ErrorStr2:= 'Ontbrekende spaties'
  else if FErrorClass = 'EParserMissingStartTag_Err'
    then ErrorStr2:= 'Eind-tag zonder begin-tag'
  else if FErrorClass = 'EParserMissingEndTag_Err'
    then ErrorStr2:= 'Eind-tag ontbreekt'
  else if FErrorClass = 'EParserInvalidEndTag_Err'
    then ErrorStr2:= 'Onjuiste eind-tag'
  else if FErrorClass = 'EParserInvalidCharacter_Err'
    then ErrorStr2:= 'Onjuist karakter'
  else if FErrorClass = 'EParserNotInRoot_Err'
    then ErrorStr2:= 'Tekst buiten het begin element'
  else if FErrorClass = 'EParserInvalidDoctype_Err'
    then ErrorStr2:= 'Onjuiste documenttype declaratie'
  else if FErrorClass = 'EParserWrongOrder_Err'
    then ErrorStr2:= 'Volgorde fout'
  else if FErrorClass = 'EParserUnknownDeclarationType_Err'
    then ErrorStr2:= 'Onbekend declaratie type'
  else if FErrorClass = 'EParserInvalidEntityDeclaration_Err'
    then ErrorStr2:= 'Onjuiste entiteits declaratie'
  else if FErrorClass = 'EParserInvalidElementDeclaration_Err'
    then ErrorStr2:= 'Onjuiste element declaratie'
  else if FErrorClass = 'EParserInvalidAttributeDeclaration_Err'
    then ErrorStr2:= 'Onjuiste attribuut declaratie'
  else if FErrorClass = 'EParserInvalidNotationDeclaration_Err'
    then ErrorStr2:= 'Onjuiste notatie declaratie'
  else if FErrorClass = 'EParserInvalidConditionalSection_Err'
    then ErrorStr2:= 'Onjuiste conditionele sectie'
  else if FErrorClass = 'EParserInvalidTextDeclaration_Err'
    then ErrorStr2:= 'Onjuiste tekst declaratie'
  else if FErrorClass = 'EParserLtInAttributeValue_Err'
    then ErrorStr2:= '''<'' in de vervangingstekst van een attribuut waarde'
  else if FErrorClass = 'EParserAttributeValueRefersToExternalEntity_Err'
    then ErrorStr2:= 'Attribuut waarde verwijst naar externe entiteit'
  else if FErrorClass = 'EParserReferenceToUnparsedEntity_Err'
    then ErrorStr2:= 'Referentie naar een niet ingelezen entiteit'
  else if FErrorClass = 'EParserNoProperMarkupReferenced_Err'
    then ErrorStr2:= 'Referentie naar een entiteit zonder juiste opmaak'
  else if FErrorClass = 'EParserInvalidComment_Err'
    then ErrorStr2:= 'Fout in commentaar'
  else if FErrorClass = 'EParserInvalidCDATASection_Err'
    then ErrorStr2:= 'Onjuiste CDATA sectie'
  else if FErrorClass = 'EParserInvalidSystemLiteral_Err'
    then ErrorStr2:= 'Onjuiste systeem tekst'
  else if FErrorClass = 'EParserInvalidPubidLiteral_Err'
    then ErrorStr2:= 'Onjuiste publieke tekst'
  else if FErrorClass = 'EParserInvalidDoctypeName_Err'
    then ErrorStr2:= 'Document type declaratie (DTD) heeft een onjuiste naam'
  else if FErrorClass = 'EParserInvalidQualifiedName_Err'
    then ErrorStr2:= 'EParserInvalidQualifiedName_Err'
  else if FErrorClass = 'EParserInvalidPrefix_Err'
    then ErrorStr2:= 'EParserInvalidPrefix_Err'
  else if FErrorClass = 'EParserInvalidNamespaceURI_Err'
    then ErrorStr2:= 'EParserInvalidNamespaceURI_Err'
  else if FErrorClass = 'EParserNamespaceURINotFound_Err'
    then ErrorStr2:= 'EParserNamespaceURINotFound_Err'
  else if FErrorClass = 'EParserWrongPrefixMappingNesting_Err'
    then ErrorStr2:= 'EParserWrongPrefixMappingNesting_Err'
  else if FErrorClass = 'EParserDouble_AttDef_Warning'
    then ErrorStr2:= 'Dubbele attribuut definitie'
  else if FErrorClass = 'EParserDouble_Entity_Decl_Warning'
    then ErrorStr2:= 'Dubbele entiteit declaratie'
  else if FErrorClass = 'EParserDouble_Parameter_Entity_Decl_Warning'
    then ErrorStr2:= 'Dubbele parameter entiteit declaratie'
  else if FErrorClass = 'EParserUnusable_Entity_Decl_Warning'
    then ErrorStr2:= 'Onbruikbare entiteit gedefinieerd'
  else if FErrorClass = 'EParserMissing_Entity_Declaration_Err'
    then ErrorStr2:= 'Ontbrekende entiteit declaratie'
  else if FErrorClass = 'EParserDouble_Element_Type_Declaration_Err'
    then ErrorStr2:= 'Dubbele element type declaratie'
  else if FErrorClass = 'EParserDuplicate_Name_In_Mixed_Content_Err'
    then ErrorStr2:= 'Naam komt meer keren voor in gemengde inhoud'
  else if FErrorClass = 'EParserDuplicate_ID_On_Element_Type_Err'
    then ErrorStr2:= 'Dubbel ID attribuut binnen hetzelfde element type'
  else if FErrorClass = 'EParserUndeclared_Notation_Name_Err'
    then ErrorStr2:= 'Niet gedefinieerde notatie naam'
  else if FErrorClass = 'EParserDuplicate_Notation_On_Element_Type_Err'
    then ErrorStr2:= 'Dubbel notatie attribuut binnen hetzelfde element type'
  else if FErrorClass = 'EParserDuplicate_Notation_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Notation_Token_Err'
  else if FErrorClass = 'EParserNotation_On_Empty_Element_Err'
    then ErrorStr2:= 'Notatie attribuut definitie voor een leeg element type'
  else if FErrorClass = 'EParserDuplicate_Enumeration_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Enumeration_Token_Err'
  else if FErrorClass = 'EParserAttribute_Type_Mismatch_Err'
    then ErrorStr2:= 'Attribuut type en attribuut waarde komen niet overeen'
  else if FErrorClass = 'EParserDuplicate_Tokens_Err'
    then ErrorStr2:= 'Tokens meermalen gedefinieerd'
  else if FErrorClass = 'EParserId_Neither_Implied_Nor_Required_Err'
    then ErrorStr2:= 'ID attribuut is niet gedefinieerd als #IMPLIED of #REQUIRED'
  else if FErrorClass = 'EParserWrong_Root_Element_Type_Err'
    then ErrorStr2:= 'Type van begin element komt niet overeen met de naam van de document type declaratie'
  else if FErrorClass = 'EParserElement_Type_Declaration_Not_Found_Err'
    then ErrorStr2:= 'Element type declaratie niet gevonden'
  else if FErrorClass = 'EParserElement_Declared_Empty_Has_Content_Err'
    then ErrorStr2:= 'Element met definitie EMPTY is niet leeg'
  else if FErrorClass = 'EParserElement_With_Illegal_Mixed_Content_Err'
    then ErrorStr2:= 'Inhoud van een element met gemengde inhoud komt niet overeen met de declaratie'
  else if FErrorClass = 'EParserElement_With_Illegal_Element_Content_Err'
    then ErrorStr2:= 'Inhoud van een element met element inhoud komt niet overeen met de declaratie'
  else if FErrorClass = 'EParserNondeterministic_Element_Content_Model_Err'
    then ErrorStr2:= 'Inhoud element model is niet deterministisch'
  else if FErrorClass = 'EParserDuplicate_Notation_Decl_Err'
    then ErrorStr2:= 'Dubbele notatie declaratie'
  else if FErrorClass = 'EParserAttribute_Definition_Not_Found_Err'
    then ErrorStr2:= 'Attribuut definitie niet gevonden'
  else if FErrorClass = 'EParserRequired_Attribute_Not_Found_Err'
    then ErrorStr2:= 'Verplicht attribuut niet gevonden'
  else if FErrorClass = 'EParserFixed_Attribute_Mismatch_Err'
    then ErrorStr2:= 'Gedefinieerde waarde en werkelijke waarde van een vast attribuut komen niet overeen'
  else if FErrorClass = 'EParserAttribute_Default_Type_Mismatch_Err'
    then ErrorStr2:= 'Attribuut type en attribuut default waarde komen niet overeen'
  else if FErrorClass = 'EParserDuplicate_ID_Value_Err'
    then ErrorStr2:= 'Dubbele ID waarde'
  else if FErrorClass = 'EParserTarget_ID_Value_Not_Found_Err'
    then ErrorStr2:= 'IDREF of IDREFS waarde verwijst naar een niet bestaande ID waarde'
  else if FErrorClass = 'EParserTarget_Unparsed_Entity_Not_Found_Err'
    then ErrorStr2:= 'ENTITY of ENTITIES waarde verwijst naar een niet bestaande entiteit'
  else if FErrorClass = 'EParserWrong_Declaration_Of_Predefined_Entity_Err'
    then ErrorStr2:= 'Foute declaratie voor een voorgedefinieerde entiteit'
  else if FErrorClass = 'EParserUnresolvable_Entity_Reference_Err'
    then ErrorStr2:= 'Niet oplosbare entiteit referentie'
  else if FErrorClass = 'EParserUnresolvable_Parameter_Entity_Reference_Err'
    then ErrorStr2:= 'Niet oplosbare parameter entiteit referentie'
  else if FErrorClass = 'EParserExternal_Subset_Not_Found_Err'
    then ErrorStr2:= 'Externe subset van de DTD niet gevonden'
  else if FErrorClass = 'EParserExternal_Entity_Not_Found_Err'
    then ErrorStr2:= 'Externe entiteit niet gevonden'
  else ErrorStr2:= 'Fout in broncode';

  result:= Iso8859_1ToUTF16Str(concat(ErrorTypeStr,DocStr,ErrorStr1,' -- ',ErrorStr2));
end;

function TXmlParserError.GetEnglishErrorStr: wideString;
var
  ErrorTypeStr,DocStr,ErrorStr1,ErrorStr2: string;
begin
  case errorType of
    xetFatalError: ErrorTypeStr:='FATAL ERROR ';
    xetError: ErrorTypeStr:='ERROR ';
    xetWarning: ErrorTypeStr:='WARNING: ';
  end;

  if publicId = '' then begin
    if systemId = ''
      then DocStr:= ''
      else DocStr:= concat('in local document ',systemId,' ');
  end else begin
    if systemId = ''
      then DocStr:= concat('in public document ',publicId,' ')
      else DocStr:= concat('in document ',publicId,' (',systemId,') ');
  end;

  if EndLine = 0 then ErrorStr1:= ''
  else if StartLine = EndLine then begin
    if StartColumn = EndColumn
      then FmtStr(ErrorStr1,'in line %d, position %d',[EndLine,EndColumn])
      else FmtStr(ErrorStr1,'in line %d, between position %d and %d',[EndLine,StartColumn,EndColumn]);
  end else begin
    FmtStr(ErrorStr1,'between line %d, position %d and line %d, position %d',[StartLine,StartColumn,EndLine,EndColumn]);
  end;

  if FErrorClass = 'EParserInvalidElementName_Err'
    then ErrorStr2:= 'Invalid element name'
  else if FErrorClass = 'EParserDoubleRootElement_Err'
    then ErrorStr2:= 'Double root element'
  else if FErrorClass = 'EParserRootNotFound_Err'
    then ErrorStr2:= 'No root element found'
  else if FErrorClass = 'EParserDoubleDoctype_Err'
    then ErrorStr2:= 'Double document type declaration (DTD)'
  else if FErrorClass = 'EParserInvalidAttributeName_Err'
    then ErrorStr2:= 'Invalid attribute name'
  else if FErrorClass = 'EParserInvalidAttributeValue_Err'
    then ErrorStr2:= 'Invalid attribute value'
  else if FErrorClass = 'EParserDoubleAttributeName_Err'
    then ErrorStr2:= 'Double attribute name in one element'
  else if FErrorClass = 'EParserInvalidEntityName_Err'
    then ErrorStr2:= 'Invalid entity name'
  else if FErrorClass = 'EParserInvalidProcessingInstruction_Err'
    then ErrorStr2:= 'Invalid processing instruction'
  else if FErrorClass = 'EParserInvalidXmlDeclaration_Err'
    then ErrorStr2:= 'Invalid XML declaration'
  else if FErrorClass = 'EParserInvalidCharRef_Err'
    then ErrorStr2:= 'Invalid character reference'
  else if FErrorClass = 'EParserMissingQuotationMark_Err'
    then ErrorStr2:= 'Missing quotation marks'
  else if FErrorClass = 'EParserMissingEqualitySign_Err'
    then ErrorStr2:= 'Missing equality sign'
  else if FErrorClass = 'EParserDoubleEqualitySign_Err'
    then ErrorStr2:= 'Double equality sign'
  else if FErrorClass = 'EParserMissingWhiteSpace_Err'
    then ErrorStr2:= 'Missing white-space'
  else if FErrorClass = 'EParserMissingStartTag_Err'
    then ErrorStr2:= 'End-tag without start-tag'
  else if FErrorClass = 'EParserMissingEndTag_Err'
    then ErrorStr2:= 'Missing end-tag'
  else if FErrorClass = 'EParserInvalidEndTag_Err'
    then ErrorStr2:= 'Invalid end-tag'
  else if FErrorClass = 'EParserInvalidCharacter_Err'
    then ErrorStr2:= 'Invalid character'
  else if FErrorClass = 'EParserNotInRoot_Err'
    then ErrorStr2:= 'Character(s) outside the root-element'
  else if FErrorClass = 'EParserInvalidDoctype_Err'
    then ErrorStr2:= 'Invalid doctype declaration'
  else if FErrorClass = 'EParserWrongOrder_Err'
    then ErrorStr2:= 'Wrong order'
  else if FErrorClass = 'EParserUnknownDeclarationType_Err'
    then ErrorStr2:= 'Unknown declaration type'
  else if FErrorClass = 'EParserInvalidEntityDeclaration_Err'
    then ErrorStr2:= 'Invalid entity declaration'
  else if FErrorClass = 'EParserInvalidElementDeclaration_Err'
    then ErrorStr2:= 'Invalid element declaration'
  else if FErrorClass = 'EParserInvalidAttributeDeclaration_Err'
    then ErrorStr2:= 'Invalid attribute declaration'
  else if FErrorClass = 'EParserInvalidNotationDeclaration_Err'
    then ErrorStr2:= 'Invalid notation declaration'
  else if FErrorClass = 'EParserInvalidConditionalSection_Err'
    then ErrorStr2:= 'Invalid conditional section'
  else if FErrorClass = 'EParserInvalidTextDeclaration_Err'
    then ErrorStr2:= 'Invalid text declaration'
  else if FErrorClass = 'EParserLtInAttributeValue_Err'
    then ErrorStr2:= '''<'' in the replacement text of an attribute value'
  else if FErrorClass = 'EParserAttributeValueRefersToExternalEntity_Err'
    then ErrorStr2:= 'Attribute value refers to external entity'
  else if FErrorClass = 'EParserReferenceToUnparsedEntity_Err'
    then ErrorStr2:= 'Reference to an unparsed entity'
  else if FErrorClass = 'EParserNoProperMarkupReferenced_Err'
    then ErrorStr2:= 'Reference to an entity containing no proper markup'
  else if FErrorClass = 'EParserInvalidComment_Err'
    then ErrorStr2:= 'Invalid comment'
  else if FErrorClass = 'EParserInvalidCDATASection_Err'
    then ErrorStr2:= 'Invalid CDATA section'
  else if FErrorClass = 'EParserInvalidSystemLiteral_Err'
    then ErrorStr2:= 'Invalid system literal'
  else if FErrorClass = 'EParserInvalidPubidLiteral_Err'
    then ErrorStr2:= 'Invalid pubid literal'
  else if FErrorClass = 'EParserInvalidDoctypeName_Err'
    then ErrorStr2:= 'Invalid document type declaration name'
  else if FErrorClass = 'EParserInvalidQualifiedName_Err'
    then ErrorStr2:= 'Invalid qualified name'
  else if FErrorClass = 'EParserInvalidPrefix_Err'
    then ErrorStr2:= 'Invalid prefix'
  else if FErrorClass = 'EParserInvalidNamespaceURI_Err'
    then ErrorStr2:= 'Invalid namespace URI'
  else if FErrorClass = 'EParserNamespaceURINotFound_Err'
    then ErrorStr2:= 'Namespace URI not found'
  else if FErrorClass = 'EParserWrongPrefixMappingNesting_Err'
    then ErrorStr2:= 'Wrong prefix mapping nesting'
  else if FErrorClass = 'EParserDouble_AttDef_Warning'
    then ErrorStr2:= 'Double attribute defintion'
  else if FErrorClass = 'EParserDouble_Entity_Decl_Warning'
    then ErrorStr2:= 'Double entity declaration'
  else if FErrorClass = 'EParserDouble_Parameter_Entity_Decl_Warning'
    then ErrorStr2:= 'Double parameter entity declaration'
  else if FErrorClass = 'EParserUnusable_Entity_Decl_Warning'
    then ErrorStr2:= 'Unusable entity declared'
  else if FErrorClass = 'EParserMissing_Entity_Declaration_Err'
    then ErrorStr2:= 'Missing entity declaration'
  else if FErrorClass = 'EParserDouble_Element_Type_Declaration_Err'
    then ErrorStr2:= 'Double element type declaration'
  else if FErrorClass = 'EParserDuplicate_Name_In_Mixed_Content_Err'
    then ErrorStr2:= 'Duplicate name in mixed content'
  else if FErrorClass = 'EParserDuplicate_ID_On_Element_Type_Err'
    then ErrorStr2:= 'Duplicate ID attribute on the same element type declared'
  else if FErrorClass = 'EParserUndeclared_Notation_Name_Err'
    then ErrorStr2:= 'Undeclared notation name'
  else if FErrorClass = 'EParserDuplicate_Notation_On_Element_Type_Err'
    then ErrorStr2:= 'Duplicate notation attribute on the same element type declared'
  else if FErrorClass = 'EParserDuplicate_Notation_Token_Err'
    then ErrorStr2:= 'Duplicate notation token'
  else if FErrorClass = 'EParserNotation_On_Empty_Element_Err'
    then ErrorStr2:= 'Notation attribute on an empty element type declared'
  else if FErrorClass = 'EParserDuplicate_Enumeration_Token_Err'
    then ErrorStr2:= 'Duplicate enumeration token'
  else if FErrorClass = 'EParserAttribute_Type_Mismatch_Err'
    then ErrorStr2:= 'Attribute type and attribute value do not match'
  else if FErrorClass = 'EParserDuplicate_Tokens_Err'
    then ErrorStr2:= 'Duplicate tokens declared'
  else if FErrorClass = 'EParserId_Neither_Implied_Nor_Required_Err'
    then ErrorStr2:= 'ID attribute is neither declared as #IMPLIED nor as #REQUIRED'
  else if FErrorClass = 'EParserWrong_Root_Element_Type_Err'
    then ErrorStr2:= 'Type of root element does not match name of document type declaration'
  else if FErrorClass = 'EParserElement_Type_Declaration_Not_Found_Err'
    then ErrorStr2:= 'Element type declaration not found'
  else if FErrorClass = 'EParserElement_Declared_Empty_Has_Content_Err'
    then ErrorStr2:= 'Element declared EMPTY is not empty'
  else if FErrorClass = 'EParserElement_With_Illegal_Mixed_Content_Err'
    then ErrorStr2:= 'Content of an element with mixed content does not match the declaration'
  else if FErrorClass = 'EParserElement_With_Illegal_Element_Content_Err'
    then ErrorStr2:= 'Content of an element with element content does not match the declaration'
  else if FErrorClass = 'EParserNondeterministic_Element_Content_Model_Err'
    then ErrorStr2:= 'Content model of an element is not deterministic'
  else if FErrorClass = 'EParserDuplicate_Notation_Decl_Err'
    then ErrorStr2:= 'Duplicate notation declaration'
  else if FErrorClass = 'EParserAttribute_Definition_Not_Found_Err'
    then ErrorStr2:= 'Attribute definition not found'
  else if FErrorClass = 'EParserRequired_Attribute_Not_Found_Err'
    then ErrorStr2:= 'Required attribute not found'
  else if FErrorClass = 'EParserFixed_Attribute_Mismatch_Err'
    then ErrorStr2:= 'Declared value and actual value of a fixed attribute do not match'
  else if FErrorClass = 'EParserAttribute_Default_Type_Mismatch_Err'
    then ErrorStr2:= 'Attribute type and attribute default do not match'
  else if FErrorClass = 'EParserDuplicate_ID_Value_Err'
    then ErrorStr2:= 'Duplicate ID value'
  else if FErrorClass = 'EParserTarget_ID_Value_Not_Found_Err'
    then ErrorStr2:= 'IDREF or IDREFS value refers to a non-existent target ID value'
  else if FErrorClass = 'EParserTarget_Unparsed_Entity_Not_Found_Err'
    then ErrorStr2:= 'ENTITY or ENTITIES value refers to a non-existent target unparsed entity'
  else if FErrorClass = 'EParserWrong_Declaration_Of_Predefined_Entity_Err'
    then ErrorStr2:= 'Wrong declaration of a predefined entity'
  else if FErrorClass = 'EParserUnresolvable_Entity_Reference_Err'
    then ErrorStr2:= 'Unresolvable entity reference'
  else if FErrorClass = 'EParserUnresolvable_Parameter_Entity_Reference_Err'
    then ErrorStr2:= 'Unresolvable parameter entity reference'
  else if FErrorClass = 'EParserExternal_Subset_Not_Found_Err'
    then ErrorStr2:= 'External subset of the DTD not found'
  else if FErrorClass = 'EParserExternal_Entity_Not_Found_Err'
    then ErrorStr2:= 'External entity not found'
  else ErrorStr2:= 'Invalid source-code';

  result:= Iso8859_1ToUTF16Str(concat(ErrorTypeStr,DocStr,ErrorStr1,' -- ',ErrorStr2));
end;

function TXmlParserError.GetFrenchErrorStr: wideString;
// - This function was provided by Bernard Eblin -
var
  ErrorTypeStr,DocStr,ErrorStr1,ErrorStr2: string;
begin
  case errorType of
    xetFatalError: ErrorTypeStr:='ERREUR FATALE ';
    xetError: ErrorTypeStr:='ERREUR ';
    xetWarning: ErrorTypeStr:='ATTENTION: ';
  end;

  if publicId = '' then begin
    if systemId = ''
      then DocStr:= ''
      else DocStr:= concat('dans le document local ',systemId,' ');
  end else begin
    if systemId = ''
      then DocStr:= concat('dans le document public ',publicId,' ')
      else DocStr:= concat('dans le document ',publicId,' (',systemId,') ');
  end;

  if EndLine = 0 then ErrorStr1:= ''
  else if StartLine = EndLine then begin
    if StartColumn = EndColumn
      then FmtStr(ErrorStr1,'� la ligne %d, position %d',[EndLine,EndColumn])
      else FmtStr(ErrorStr1,'� la ligne %d, entre la position %d et %d',[EndLine,StartColumn,EndColumn]);
  end else begin
    FmtStr(ErrorStr1,'entre la ligne %d, position %d et la ligne %d, position %d',[StartLine,StartColumn,EndLine,EndColumn]);
  end;

  if FErrorClass = 'EParserInvalidElementName_Err'
    then ErrorStr2:= 'Nom d''�l�ment invalide'
  else if FErrorClass = 'EParserDoubleRootElement_Err'
    then ErrorStr2:= 'Double �l�ment racine'
  else if FErrorClass = 'EParserRootNotFound_Err'
    then ErrorStr2:= 'Pas d''�l�ment racine trouv�'
  else if FErrorClass = 'EParserDoubleDoctype_Err'
    then ErrorStr2:= 'Double d�claration de type de document (DTD)'
  else if FErrorClass = 'EParserInvalidAttributeName_Err'
    then ErrorStr2:= 'Nom d''attribut invalide'
  else if FErrorClass = 'EParserInvalidAttributeValue_Err'
    then ErrorStr2:= 'Valeur d''attribut invalide'
  else if FErrorClass = 'EParserDoubleAttributeName_Err'
    then ErrorStr2:= 'Double nom d''atribut dans un �l�ment'
  else if FErrorClass = 'EParserInvalidEntityName_Err'
    then ErrorStr2:= 'Nom d''entit� invalide'
  else if FErrorClass = 'EParserInvalidProcessingInstruction_Err'
    then ErrorStr2:= 'Instruction de commande invalide'
  else if FErrorClass = 'EParserInvalidXmlDeclaration_Err'
    then ErrorStr2:= 'D�claration XML invalide'
  else if FErrorClass = 'EParserInvalidCharRef_Err'
    then ErrorStr2:= 'R�f�rence de caract�re invalide'
  else if FErrorClass = 'EParserMissingQuotationMark_Err'
    then ErrorStr2:= 'Apostrophe ('') manquant'
  else if FErrorClass = 'EParserMissingEqualitySign_Err'
    then ErrorStr2:= 'Signe �gale manquant'
  else if FErrorClass = 'EParserDoubleEqualitySign_Err'
    then ErrorStr2:= 'Double signe �gale'
  else if FErrorClass = 'EParserMissingWhiteSpace_Err'
    then ErrorStr2:= 'Espace manquant'
  else if FErrorClass = 'EParserMissingStartTag_Err'
    then ErrorStr2:= 'Tag de fin sans tag de d�but'
  else if FErrorClass = 'EParserMissingEndTag_Err'
    then ErrorStr2:= 'Tag de fin manquant'
  else if FErrorClass = 'EParserInvalidEndTag_Err'
    then ErrorStr2:= 'Tag de fin invalide'
  else if FErrorClass = 'EParserInvalidCharacter_Err'
    then ErrorStr2:= 'Caract�re invalide'
  else if FErrorClass = 'EParserNotInRoot_Err'
    then ErrorStr2:= 'Caract�re(s) en dehors de l''�l�ment racine'
  else if FErrorClass = 'EParserInvalidDoctype_Err'
    then ErrorStr2:= 'D�claration de type de document invalide'
  else if FErrorClass = 'EParserWrongOrder_Err'
    then ErrorStr2:= 'Mauvais ordre'
  else if FErrorClass = 'EParserUnknownDeclarationType_Err'
    then ErrorStr2:= 'D�claration de type inconnue'
  else if FErrorClass = 'EParserInvalidEntityDeclaration_Err'
    then ErrorStr2:= 'D�claration d''entit� invalide'
  else if FErrorClass = 'EParserInvalidElementDeclaration_Err'
    then ErrorStr2:= 'D�claration d''�l�ment invalide'
  else if FErrorClass = 'EParserInvalidAttributeDeclaration_Err'
    then ErrorStr2:= 'D�claration d''attribut invalide'
  else if FErrorClass = 'EParserInvalidNotationDeclaration_Err'
    then ErrorStr2:= 'D�claration de notation invalide'
  else if FErrorClass = 'EParserInvalidConditionalSection_Err'
    then ErrorStr2:= 'Section conditionnelle invalide'
  else if FErrorClass = 'EParserInvalidTextDeclaration_Err'
    then ErrorStr2:= 'D�claration de texte invalide'
  else if FErrorClass = 'EParserLtInAttributeValue_Err'
    then ErrorStr2:= 'EParserLtInAttributeValue_Err'
  else if FErrorClass = 'EParserAttributeValueRefersToExternalEntity_Err'
    then ErrorStr2:= 'EParserAttributeValueRefersToExternalEntity_Err'
  else if FErrorClass = 'EParserReferenceToUnparsedEntity_Err'
    then ErrorStr2:= 'EParserReferenceToUnparsedEntity_Err'
  else if FErrorClass = 'EParserNoProperMarkupReferenced_Err'
    then ErrorStr2:= 'EParserNoProperMarkupReferenced_Err'
  else if FErrorClass = 'EParserInvalidComment_Err'
    then ErrorStr2:= 'EParserInvalidComment_Err'
  else if FErrorClass = 'EParserInvalidCDATASection_Err'
    then ErrorStr2:= 'EParserInvalidCDATASection_Err'
  else if FErrorClass = 'EParserInvalidSystemLiteral_Err'
    then ErrorStr2:= 'EParserInvalidSystemLiteral_Err'
  else if FErrorClass = 'EParserInvalidPubidLiteral_Err'
    then ErrorStr2:= 'EParserInvalidPubidLiteral_Err'
  else if FErrorClass = 'EParserInvalidDoctypeName_Err'
    then ErrorStr2:= 'EParserInvalidDoctypeName_Err'
  else if FErrorClass = 'EParserInvalidQualifiedName_Err'
    then ErrorStr2:= 'EParserInvalidQualifiedName_Err'
  else if FErrorClass = 'EParserInvalidPrefix_Err'
    then ErrorStr2:= 'EParserInvalidPrefix_Err'
  else if FErrorClass = 'EParserInvalidNamespaceURI_Err'
    then ErrorStr2:= 'EParserInvalidNamespaceURI_Err'
  else if FErrorClass = 'EParserNamespaceURINotFound_Err'
    then ErrorStr2:= 'EParserNamespaceURINotFound_Err'
  else if FErrorClass = 'EParserWrongPrefixMappingNesting_Err'
    then ErrorStr2:= 'EParserWrongPrefixMappingNesting_Err'
  else if FErrorClass = 'EParserDouble_AttDef_Warning'
    then ErrorStr2:= 'EParserDouble_AttDef_Warning'
  else if FErrorClass = 'EParserDouble_Entity_Decl_Warning'
    then ErrorStr2:= 'Double d�claration d''entit�'
  else if FErrorClass = 'EParserDouble_Parameter_Entity_Decl_Warning'
    then ErrorStr2:= 'Double d�claration d''entit� param�tre'
  else if FErrorClass = 'EParserUnusable_Entity_Decl_Warning'
    then ErrorStr2:= 'EParserUnusable_Entity_Decl_Warning'
  else if FErrorClass = 'EParserMissing_Entity_Declaration_Err'
    then ErrorStr2:= 'EParserMissing_Entity_Declaration_Err'
  else if FErrorClass = 'EParserDouble_Element_Type_Declaration_Err'
    then ErrorStr2:= 'EParserDouble_Element_Type_Declaration_Err'
  else if FErrorClass = 'EParserDuplicate_Name_In_Mixed_Content_Err'
    then ErrorStr2:= 'EParserDuplicate_Name_In_Mixed_Content_Err'
  else if FErrorClass = 'EParserDuplicate_ID_On_Element_Type_Err'
    then ErrorStr2:= 'EParserDuplicate_ID_On_Element_Type_Err'
  else if FErrorClass = 'EParserUndeclared_Notation_Name_Err'
    then ErrorStr2:= 'EParserUndeclared_Notation_Name_Err'
  else if FErrorClass = 'EParserDuplicate_Notation_On_Element_Type_Err'
    then ErrorStr2:= 'EParserDuplicate_Notation_On_Element_Type_Err'
  else if FErrorClass = 'EParserDuplicate_Notation_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Notation_Token_Err'
  else if FErrorClass = 'EParserNotation_On_Empty_Element_Err'
    then ErrorStr2:= 'EParserNotation_On_Empty_Element_Err'
  else if FErrorClass = 'EParserDuplicate_Enumeration_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Enumeration_Token_Err'
  else if FErrorClass = 'EParserAttribute_Type_Mismatch_Err'
    then ErrorStr2:= 'EParserAttribute_Type_Mismatch_Err'
  else if FErrorClass = 'EParserDuplicate_Tokens_Err'
    then ErrorStr2:= 'EParserDuplicate_Tokens_Err'
  else if FErrorClass = 'EParserId_Neither_Implied_Nor_Required_Err'
    then ErrorStr2:= 'EParserId_Neither_Implied_Nor_Required_Err'
  else if FErrorClass = 'EParserWrong_Root_Element_Type_Err'
    then ErrorStr2:= 'EParserWrong_Root_Element_Type_Err'
  else if FErrorClass = 'EParserElement_Type_Declaration_Not_Found_Err'
    then ErrorStr2:= 'EParserElement_Type_Declaration_Not_Found_Err'
  else if FErrorClass = 'EParserElement_Declared_Empty_Has_Content_Err'
    then ErrorStr2:= 'EParserElement_Declared_Empty_Has_Content_Err'
  else if FErrorClass = 'EParserElement_With_Illegal_Mixed_Content_Err'
    then ErrorStr2:= 'EParserElement_With_Illegal_Mixed_Content_Err'
  else if FErrorClass = 'EParserElement_With_Illegal_Element_Content_Err'
    then ErrorStr2:= 'EParserElement_With_Illegal_Element_Content_Err'
  else if FErrorClass = 'EParserNondeterministic_Element_Content_Model_Err'
    then ErrorStr2:= 'EParserNondeterministic_Element_Content_Model_Err'
  else if FErrorClass = 'EParserDuplicate_Notation_Decl_Err'
    then ErrorStr2:= 'Double d�claration de notation'
  else if FErrorClass = 'EParserAttribute_Definition_Not_Found_Err'
    then ErrorStr2:= 'EParserAttribute_Definition_Not_Found_Err'
  else if FErrorClass = 'EParserRequired_Attribute_Not_Found_Err'
    then ErrorStr2:= 'EParserRequired_Attribute_Not_Found_Err'
  else if FErrorClass = 'EParserFixed_Attribute_Mismatch_Err'
    then ErrorStr2:= 'EParserFixed_Attribute_Mismatch_Err'
  else if FErrorClass = 'EParserAttribute_Default_Type_Mismatch_Err'
    then ErrorStr2:= 'EParserAttribute_Default_Type_Mismatch_Err'
  else if FErrorClass = 'EParserDuplicate_ID_Value_Err'
    then ErrorStr2:= 'EParserDuplicate_ID_Value_Err'
  else if FErrorClass = 'EParserTarget_ID_Value_Not_Found_Err'
    then ErrorStr2:= 'EParserTarget_ID_Value_Not_Found_Err'
  else if FErrorClass = 'EParserTarget_Unparsed_Entity_Not_Found_Err'
    then ErrorStr2:= 'EParserTarget_Unparsed_Entity_Not_Found_Err'
  else if FErrorClass = 'EParserWrong_Declaration_Of_Predefined_Entity_Err'
    then ErrorStr2:= 'EParserWrong_Declaration_Of_Predefined_Entity_Err'
  else if FErrorClass = 'EParserUnresolvable_Entity_Reference_Err'
    then ErrorStr2:= 'EParserUnresolvable_Entity_Reference_Err'
  else if FErrorClass = 'EParserUnresolvable_Parameter_Entity_Reference_Err'
    then ErrorStr2:= 'EParserUnresolvable_Parameter_Entity_Reference_Err'
  else if FErrorClass = 'EParserExternal_Subset_Not_Found_Err'
    then ErrorStr2:= 'EParserExternal_Subset_Not_Found_Err'
  else if FErrorClass = 'EParserExternal_Entity_Not_Found_Err'
    then ErrorStr2:= 'EParserExternal_Entity_Not_Found_Err'
  else ErrorStr2:= 'Code source invalide';

  result:= Iso8859_1ToUTF16Str(concat(ErrorTypeStr,DocStr,ErrorStr1,' -- ',ErrorStr2));
end;

function TXmlParserError.GetGermanErrorStr: wideString;
var
  DocStr,ErrorTypeStr,ErrorStr1,ErrorStr2: string;
begin
  case errorType of
    xetFatalError: ErrorTypeStr:='KRITISCHER FEHLER ';
    xetError: ErrorTypeStr:='FEHLER ';
    xetWarning: ErrorTypeStr:='WARNUNG: ';
  end;

  if publicId = '' then begin
    if systemId = ''
      then DocStr:= ''
      else DocStr:= concat('im lokalen Dokument ',systemId,' ');
  end else begin
    if systemId = ''
      then DocStr:= concat('im �ffentlichen Dokument ',publicId,' ')
      else DocStr:= concat('im Dokument ',publicId,' (',systemId,') ');
  end;

  if EndLine = 0 then ErrorStr1:= ''
  else if StartLine = EndLine then begin
    if StartColumn = EndColumn
      then FmtStr(ErrorStr1,'in Zeile %d, Position %d',[EndLine,EndColumn])
      else FmtStr(ErrorStr1,'in Zeile %d, zwischen Position %d und %d',[EndLine,StartColumn,EndColumn]);
  end else begin
    FmtStr(ErrorStr1,'zwischen Zeile %d, Position %d und Zeile %d, Position %d',[StartLine,StartColumn,EndLine,EndColumn]);
  end;

  if FErrorClass = 'EParserInvalidElementName_Err'
    then ErrorStr2:= 'Ung�ltiger Element-name'
  else if FErrorClass = 'EParserDoubleRootElement_Err'
    then ErrorStr2:= 'Doppeltes Wurzel-Element'
  else if FErrorClass = 'EParserRootNotFound_Err'
    then ErrorStr2:= 'Kein Wurzel-Element gefunden'
  else if FErrorClass = 'EParserDoubleDoctype_Err'
    then ErrorStr2:= 'Doppelte Dokument-Typ-Deklaration (DTD)'
  else if FErrorClass = 'EParserInvalidAttributeName_Err'
    then ErrorStr2:= 'Ung�ltiger Attribut-name'
  else if FErrorClass = 'EParserInvalidAttributeValue_Err'
    then ErrorStr2:= 'Ung�ltiger Attribut-Wert'
  else if FErrorClass = 'EParserDoubleAttributeName_Err'
    then ErrorStr2:= 'Doppelter Attributname in einem Element'
  else if FErrorClass = 'EParserInvalidEntityName_Err'
    then ErrorStr2:= 'Ung�ltiger Entit�t-name'
  else if FErrorClass = 'EParserInvalidProcessingInstruction_Err'
    then ErrorStr2:= 'Ung�ltige Processing-Instruction'
  else if FErrorClass = 'EParserInvalidXmlDeclaration_Err'
    then ErrorStr2:= 'Ung�ltige XML-Deklaration'
  else if FErrorClass = 'EParserInvalidCharRef_Err'
    then ErrorStr2:= 'Ung�ltige Zeichen-Referenz'
  else if FErrorClass = 'EParserMissingQuotationMark_Err'
    then ErrorStr2:= 'Fehlende Anf�hrungszeichen'
  else if FErrorClass = 'EParserMissingEqualitySign_Err'
    then ErrorStr2:= 'Fehlendes Gleichheitszeichen'
  else if FErrorClass = 'EParserDoubleEqualitySign_Err'
    then ErrorStr2:= 'Doppeltes Gleichheitszeichen'
  else if FErrorClass = 'EParserMissingWhiteSpace_Err'
    then ErrorStr2:= 'Fehlender Leerraum'
  else if FErrorClass = 'EParserMissingStartTag_Err'
    then ErrorStr2:= 'End-Tag ohne Start-Tag'
  else if FErrorClass = 'EParserMissingEndTag_Err'
    then ErrorStr2:= 'Fehlendes End-Tag'
  else if FErrorClass = 'EParserInvalidEndTag_Err'
    then ErrorStr2:= 'Ung�ltiges End-Tag'
  else if FErrorClass = 'EParserInvalidCharacter_Err'
    then ErrorStr2:= 'Ung�ltiges Zeichen'
  else if FErrorClass = 'EParserNotInRoot_Err'
    then ErrorStr2:= 'Zeichen au�erhalb des Wurzel-Elements'
  else if FErrorClass = 'EParserInvalidDoctype_Err'
    then ErrorStr2:= 'Ung�ltige Dokumenttyp-Deklaration'
  else if FErrorClass = 'EParserWrongOrder_Err'
    then ErrorStr2:= 'Falsche Reihenfolge'
  else if FErrorClass = 'EParserUnknownDeclarationType_Err'
    then ErrorStr2:= 'Unbekannter Deklarationstyp'
  else if FErrorClass = 'EParserInvalidEntityDeclaration_Err'
    then ErrorStr2:= 'Ung�ltige Entit�t-Deklaration'
  else if FErrorClass = 'EParserInvalidElementDeclaration_Err'
    then ErrorStr2:= 'Ung�ltige Element-Deklaration'
  else if FErrorClass = 'EParserInvalidAttributeDeclaration_Err'
    then ErrorStr2:= 'Ung�ltige Attribut-Deklaration'
  else if FErrorClass = 'EParserInvalidNotationDeclaration_Err'
    then ErrorStr2:= 'Ung�ltige Notations-Deklaration'
  else if FErrorClass = 'EParserInvalidConditionalSection_Err'
    then ErrorStr2:= 'Ung�ltiger bedingter Abschnitt'
  else if FErrorClass = 'EParserInvalidTextDeclaration_Err'
    then ErrorStr2:= 'Ung�ltige Text-Deklaration'
  else if FErrorClass = 'EParserLtInAttributeValue_Err'
    then ErrorStr2:= '''<'' im Ersetzungstext eines Attributwertes'
  else if FErrorClass = 'EParserAttributeValueRefersToExternalEntity_Err'
    then ErrorStr2:= 'Attribut-Wert verweist auf eine externe Entit�t'
  else if FErrorClass = 'EParserReferenceToUnparsedEntity_Err'
    then ErrorStr2:= 'Referenz auf eine nicht analysierte Entit�t'
  else if FErrorClass = 'EParserNoProperMarkupReferenced_Err'
    then ErrorStr2:= 'Referenz auf eine Entit�t mit ung�ltigen Markierunszeichen'
  else if FErrorClass = 'EParserInvalidComment_Err'
    then ErrorStr2:= 'Ung�ltiger Kommentar'
  else if FErrorClass = 'EParserInvalidCDATASection_Err'
    then ErrorStr2:= 'Ung�ltiger CDATA-Abschnitt'
  else if FErrorClass = 'EParserInvalidSystemLiteral_Err'
    then ErrorStr2:= 'Ung�ltiges System-Literal'
  else if FErrorClass = 'EParserInvalidPubidLiteral_Err'
    then ErrorStr2:= 'Ung�ltiges Pubid-Literal'
  else if FErrorClass = 'EParserInvalidDoctypeName_Err'
    then ErrorStr2:= 'Dokument-Typ-Deklaration (DTD) mit ung�ltigem Namen'
  else if FErrorClass = 'EParserInvalidQualifiedName_Err'
    then ErrorStr2:= 'Ung�ltiger qualifizierter Name'
  else if FErrorClass = 'EParserInvalidPrefix_Err'
    then ErrorStr2:= 'Ung�ltiges Prefix'
  else if FErrorClass = 'EParserInvalidNamespaceURI_Err'
    then ErrorStr2:= 'Ung�ltiger Namensraum-URI'
  else if FErrorClass = 'EParserNamespaceURINotFound_Err'
    then ErrorStr2:= 'Namensraum-URI nicht gefunden'
  else if FErrorClass = 'EParserWrongPrefixMappingNesting_Err'
    then ErrorStr2:= 'Falsche Prefix-Verschachtelung'
  else if FErrorClass = 'EParserDouble_AttDef_Warning'
    then ErrorStr2:= 'Doppelte Attribut-Defintion'
  else if FErrorClass = 'EParserDouble_Entity_Decl_Warning'
    then ErrorStr2:= 'Doppelte Entit�t-Deklaration'
  else if FErrorClass = 'EParserDouble_Parameter_Entity_Decl_Warning'
    then ErrorStr2:= 'Doppelte Parameter-Entit�t-Deklaration'
  else if FErrorClass = 'EParserUnusable_Entity_Decl_Warning'
    then ErrorStr2:= 'Unbrauchbare Entit�t deklariert'
  else if FErrorClass = 'EParserMissing_Entity_Declaration_Err'
    then ErrorStr2:= 'Fehlende Entit�t-Declaration'
  else if FErrorClass = 'EParserDouble_Element_Type_Declaration_Err'
    then ErrorStr2:= 'Doppelte Element-Typ-Deklaration'
  else if FErrorClass = 'EParserDuplicate_Name_In_Mixed_Content_Err'
    then ErrorStr2:= 'Doppelter Name in gemischtem Inhalt'
  else if FErrorClass = 'EParserDuplicate_ID_On_Element_Type_Err'
    then ErrorStr2:= 'ID-Attribut mehrfach f�r denselben Element-Typ deklariert'
  else if FErrorClass = 'EParserUndeclared_Notation_Name_Err'
    then ErrorStr2:= 'Notationsname nicht deklariert'
  else if FErrorClass = 'EParserDuplicate_Notation_On_Element_Type_Err'
    then ErrorStr2:= 'Notationsattribut mehrfach f�r denselben Element-Typ deklariert'
  else if FErrorClass = 'EParserDuplicate_Notation_Token_Err'
    then ErrorStr2:= 'Doppelte Notationstokens'
  else if FErrorClass = 'EParserNotation_On_Empty_Element_Err'
    then ErrorStr2:= 'Notationsattribut f�r einen leeren Element-Typ deklariert'
  else if FErrorClass = 'EParserDuplicate_Enumeration_Token_Err'
    then ErrorStr2:= 'Doppeltes Aufz�hlungstoken'
  else if FErrorClass = 'EParserAttribute_Type_Mismatch_Err'
    then ErrorStr2:= 'Attribut-Typ und Attribut-Wert stimmen nicht �berein'
  else if FErrorClass = 'EParserDuplicate_Tokens_Err'
    then ErrorStr2:= 'Token mehrfach deklariert'
  else if FErrorClass = 'EParserId_Neither_Implied_Nor_Required_Err'
    then ErrorStr2:= 'ID-Attribut ist weder als #IMPLIED noch als #REQUIRED deklariert'
  else if FErrorClass = 'EParserWrong_Root_Element_Type_Err'
    then ErrorStr2:= 'Typ des Wurzelelements entspricht nicht der Angabe in der Dokumenttyp-Deklaration'
  else if FErrorClass = 'EParserElement_Type_Declaration_Not_Found_Err'
    then ErrorStr2:= 'Elementtyp-Deklaration nicht gefunden'
  else if FErrorClass = 'EParserElement_Declared_Empty_Has_Content_Err'
    then ErrorStr2:= 'Als EMPTY deklariertes Element ist nicht leer'
  else if FErrorClass = 'EParserElement_With_Illegal_Mixed_Content_Err'
    then ErrorStr2:= 'Inhalt eines Elements gemischten Inhalts entspricht nicht der Deklaration'
  else if FErrorClass = 'EParserElement_With_Illegal_Element_Content_Err'
    then ErrorStr2:= 'Inhalt eines Elements mit Element-Inhalt entspricht nicht der Deklaration'
  else if FErrorClass = 'EParserNondeterministic_Element_Content_Model_Err'
    then ErrorStr2:= 'Inhaltsmodell eines Elements ist nicht deterministisch'
  else if FErrorClass = 'EParserDuplicate_Notation_Decl_Err'
    then ErrorStr2:= 'Doppelte Notationsdeklaration'
  else if FErrorClass = 'EParserAttribute_Definition_Not_Found_Err'
    then ErrorStr2:= 'Attribut-Definition nicht gefunden'
  else if FErrorClass = 'EParserRequired_Attribute_Not_Found_Err'
    then ErrorStr2:= 'Als "#REQUIRED" deklariertes Attribut nicht gefunden'
  else if FErrorClass = 'EParserFixed_Attribute_Mismatch_Err'
    then ErrorStr2:= 'Werte eines als "#FIXED" deklarierten Attributs entspricht nicht der Deklaration'
  else if FErrorClass = 'EParserAttribute_Default_Type_Mismatch_Err'
    then ErrorStr2:= 'Attribut-Typ und Attribut-Vorgabe stimmen nicht �berein'
  else if FErrorClass = 'EParserDuplicate_ID_Value_Err'
    then ErrorStr2:= 'ID-Wert mehrfach verwendet'
  else if FErrorClass = 'EParserTarget_ID_Value_Not_Found_Err'
    then ErrorStr2:= 'Ein IDREF- bzw. IDREFS-Attribute verweist auf ein nicht vorhandenes Ziel'
  else if FErrorClass = 'EParserTarget_Unparsed_Entity_Not_Found_Err'
    then ErrorStr2:= 'Ein ENTITY- bzw. ENTITIES-Attribute verweist auf eine nicht analysierte Entit�t, die nicht deklariert wurde'
  else if FErrorClass = 'EParserWrong_Declaration_Of_Predefined_Entity_Err'
    then ErrorStr2:= 'Falsche Deklaration einer vordefinierten Entit�t'
  else if FErrorClass = 'EParserUnresolvable_Entity_Reference_Err'
    then ErrorStr2:= 'Nicht aufl�sbare Entit�ten-Referenz'
  else if FErrorClass = 'EParserUnresolvable_Parameter_Entity_Reference_Err'
    then ErrorStr2:= 'Nicht aufl�sbare Parameter-Entit�ten-Referenz'
  else if FErrorClass = 'EParserExternal_Subset_Not_Found_Err'
    then ErrorStr2:= 'Externe Teilmenge der DTD nicht gefunden'
  else if FErrorClass = 'EParserExternal_Entity_Not_Found_Err'
    then ErrorStr2:= 'Externe Entit�t nicht gefunden'
  else ErrorStr2:= 'Ung�ltiger Quellcode';

  result:= Iso8859_1ToUTF16Str(concat(ErrorTypeStr,DocStr,ErrorStr1,' -- ',ErrorStr2));
end;

function TXmlParserError.GetItalianErrorStr: wideString;
// - This function was provided by Massimo Maria Ghisalberti -
var
  ErrorTypeStr,DocStr,ErrorStr1,ErrorStr2: string;
begin
  case errorType of
    xetFatalError: ErrorTypeStr:='ERRORE CRITICO ';
    xetError: ErrorTypeStr:='ERRORE ';
    xetWarning: ErrorTypeStr:='ATTENZIONE: ';
  end;

  if publicId = '' then begin
    if systemId = ''
      then DocStr:= ''
      else DocStr:= concat('nel documento locale ',systemId,' ');
  end else begin
    if systemId = ''
      then DocStr:= concat('nel documento pubblico ',publicId,' ')
      else DocStr:= concat('nel documento ',publicId,' (',systemId,') ');
  end;

  if EndLine = 0 then ErrorStr1:= ''
  else if StartLine = EndLine then begin
    if StartColumn = EndColumn
      then FmtStr(ErrorStr1,'nella linea %d, posizione %d',[EndLine,EndColumn])
      else FmtStr(ErrorStr1,'nella linea %d, tra la posizione %d e %d',[EndLine,StartColumn,EndColumn]);
  end else begin
    FmtStr(ErrorStr1,'tra la linea %d, posizione %d e la linea %d, posizione %d',[StartLine,StartColumn,EndLine,EndColumn]);
  end;

  if FErrorClass = 'EParserInvalidElementName_Err'
    then ErrorStr2:= 'Nome elemento non valido'
  else if FErrorClass = 'EParserDoubleRootElement_Err'
    then ErrorStr2:= 'Elemento radice duplicato'
  else if FErrorClass = 'EParserRootNotFound_Err'
    then ErrorStr2:= 'Elemento radice non trovato'
  else if FErrorClass = 'EParserDoubleDoctype_Err'
    then ErrorStr2:= 'Dichiarazione del tipo di documento (DTD) duplicata'
  else if FErrorClass = 'EParserInvalidAttributeName_Err'
    then ErrorStr2:= 'Nome attributo non valido'
  else if FErrorClass = 'EParserInvalidAttributeValue_Err'
    then ErrorStr2:= 'Valore attributo non valido'
  else if FErrorClass = 'EParserDoubleAttributeName_Err'
    then ErrorStr2:= 'Nome dell''attributo duplicato in un elemento'
  else if FErrorClass = 'EParserInvalidEntityName_Err'
    then ErrorStr2:= 'Nome entit� non valido'
  else if FErrorClass = 'EParserInvalidProcessingInstruction_Err'
    then ErrorStr2:= 'Istruzione di processo non valida'
  else if FErrorClass = 'EParserInvalidXmlDeclaration_Err'
    then ErrorStr2:= 'Dichiarazione XML non valida'
  else if FErrorClass = 'EParserInvalidCharRef_Err'
    then ErrorStr2:= 'Riferimento a carattere non valida'
  else if FErrorClass = 'EParserMissingQuotationMark_Err'
    then ErrorStr2:= 'Virgolette mancanti'
  else if FErrorClass = 'EParserMissingEqualitySign_Err'
    then ErrorStr2:= 'Segno di uguale mancante'
  else if FErrorClass = 'EParserDoubleEqualitySign_Err'
    then ErrorStr2:= 'Segno di uguale duplicato'
  else if FErrorClass = 'EParserMissingWhiteSpace_Err'
    then ErrorStr2:= 'Spazio mancante'
  else if FErrorClass = 'EParserMissingStartTag_Err'
    then ErrorStr2:= 'Tag finale senza tag iniziale'
  else if FErrorClass = 'EParserMissingEndTag_Err'
    then ErrorStr2:= 'Tag finale mancante'
  else if FErrorClass = 'EParserInvalidEndTag_Err'
    then ErrorStr2:= 'Tag finale non valido'
  else if FErrorClass = 'EParserInvalidCharacter_Err'
    then ErrorStr2:= 'Carattere non valido'
  else if FErrorClass = 'EParserNotInRoot_Err'
    then ErrorStr2:= 'Carattere(i) oltre l''elemento radice'
  else if FErrorClass = 'EParserInvalidDoctype_Err'
    then ErrorStr2:= 'Dichiarazione del tipo di documento non valida'
  else if FErrorClass = 'EParserWrongOrder_Err'
    then ErrorStr2:= 'Ordine errato'
  else if FErrorClass = 'EParserUnknownDeclarationType_Err'
    then ErrorStr2:= 'Dichiarazione di tipo sconosciuta'
  else if FErrorClass = 'EParserInvalidEntityDeclaration_Err'
    then ErrorStr2:= 'Dichiarazione di entit� non valida'
  else if FErrorClass = 'EParserInvalidElementDeclaration_Err'
    then ErrorStr2:= 'Dichiarazione di elemento non valida'
  else if FErrorClass = 'EParserInvalidAttributeDeclaration_Err'
    then ErrorStr2:= 'Dichiarazione di attributo non valida'
  else if FErrorClass = 'EParserInvalidNotationDeclaration_Err'
    then ErrorStr2:= 'Dichiarazione di notazione non valida'
  else if FErrorClass = 'EParserInvalidConditionalSection_Err'
    then ErrorStr2:= 'Sezione condizionale non valida'
  else if FErrorClass = 'EParserInvalidTextDeclaration_Err'
    then ErrorStr2:= 'Dichiarazione di testo non valida'
  else if FErrorClass = 'EParserLtInAttributeValue_Err'
    then ErrorStr2:= 'Tovato il carattere ''<'' nel valore di un attributo'
  else if FErrorClass = 'EParserAttributeValueRefersToExternalEntity_Err'
    then ErrorStr2:= 'Il valore dell''attributo si riferisce ad un''entit� esterna'
  else if FErrorClass = 'EParserReferenceToUnparsedEntity_Err'
    then ErrorStr2:= 'Riferimento ad una entit� non analizzata'
  else if FErrorClass = 'EParserNoProperMarkupReferenced_Err'
    then ErrorStr2:= 'Riferimento ad una entit� senza un marcatore adeguato'
  else if FErrorClass = 'EParserInvalidComment_Err'
    then ErrorStr2:= 'EParserInvalidComment_Err'
  else if FErrorClass = 'EParserInvalidCDATASection_Err'
    then ErrorStr2:= 'EParserInvalidCDATASection_Err'
  else if FErrorClass = 'EParserInvalidSystemLiteral_Err'
    then ErrorStr2:= 'EParserInvalidSystemLiteral_Err'
  else if FErrorClass = 'EParserInvalidPubidLiteral_Err'
    then ErrorStr2:= 'EParserInvalidPubidLiteral_Err'
  else if FErrorClass = 'EParserInvalidDoctypeName_Err'
    then ErrorStr2:= 'EParserInvalidDoctypeName_Err'
  else if FErrorClass = 'EParserInvalidQualifiedName_Err'
    then ErrorStr2:= 'EParserInvalidQualifiedName_Err'
  else if FErrorClass = 'EParserInvalidPrefix_Err'
    then ErrorStr2:= 'EParserInvalidPrefix_Err'
  else if FErrorClass = 'EParserInvalidNamespaceURI_Err'
    then ErrorStr2:= 'EParserInvalidNamespaceURI_Err'
  else if FErrorClass = 'EParserNamespaceURINotFound_Err'
    then ErrorStr2:= 'EParserNamespaceURINotFound_Err'
  else if FErrorClass = 'EParserWrongPrefixMappingNesting_Err'
    then ErrorStr2:= 'EParserWrongPrefixMappingNesting_Err'
  else if FErrorClass = 'EParserDouble_AttDef_Warning'
    then ErrorStr2:= 'Definizione di attibuto duplicata'
  else if FErrorClass = 'EParserDouble_Entity_Decl_Warning'
    then ErrorStr2:= 'Dichiarazione di entit� duplicata'
  else if FErrorClass = 'EParserDouble_Parameter_Entity_Decl_Warning'
    then ErrorStr2:= 'Dichiarazione di entit� con parametri duplicati'
  else if FErrorClass = 'EParserUnusable_Entity_Decl_Warning'
    then ErrorStr2:= 'Entit� dichiarata non utilizzabile'
  else if FErrorClass = 'EParserMissing_Entity_Declaration_Err'
    then ErrorStr2:= 'Dichiarazione di entit� non trovata'
  else if FErrorClass = 'EParserDouble_Element_Type_Declaration_Err'
    then ErrorStr2:= 'Dichiarazione di tipo dell''elemento duplicata'
  else if FErrorClass = 'EParserDuplicate_Name_In_Mixed_Content_Err'
    then ErrorStr2:= 'Nome duplicato in un contenuto misto'
  else if FErrorClass = 'EParserDuplicate_ID_On_Element_Type_Err'
    then ErrorStr2:= 'Attributo ID duplicato nella stessa dichiarazione di tipo di elemento'
  else if FErrorClass = 'EParserUndeclared_Notation_Name_Err'
    then ErrorStr2:= 'Nome di notazione non dichiarato'
  else if FErrorClass = 'EParserDuplicate_Notation_On_Element_Type_Err'
    then ErrorStr2:= 'Attributo di notazione duplicato nello stessa dichiarazione di tipo di elemento'
  else if FErrorClass = 'EParserDuplicate_Notation_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Notation_Token_Err'
  else if FErrorClass = 'EParserNotation_On_Empty_Element_Err'
    then ErrorStr2:= 'Attributo di notazione nella dichiarazione di tipo di elemento vuoto'
  else if FErrorClass = 'EParserDuplicate_Enumeration_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Enumeration_Token_Err'
  else if FErrorClass = 'EParserAttribute_Type_Mismatch_Err'
    then ErrorStr2:= 'L''attributo di tipo e il valore non coincidono'
  else if FErrorClass = 'EParserDuplicate_Tokens_Err'
    then ErrorStr2:= 'Dichiarazione duplicata di token'
  else if FErrorClass = 'EParserId_Neither_Implied_Nor_Required_Err'
    then ErrorStr2:= 'L''attributo ID non � stato dichiarato come #IMPLIED n� come #REQUIRED'
  else if FErrorClass = 'EParserWrong_Root_Element_Type_Err'
    then ErrorStr2:= 'Il tipo dell''elemento radice non coincide con il nome della dichiarazione di tipo del documento'
  else if FErrorClass = 'EParserElement_Type_Declaration_Not_Found_Err'
    then ErrorStr2:= 'Dichiarazione del tipo dell''elemento non trovata'
  else if FErrorClass = 'EParserElement_Declared_Empty_Has_Content_Err'
    then ErrorStr2:= 'L''elemento dichiarato vuoto non lo �'
  else if FErrorClass = 'EParserElement_With_Illegal_Mixed_Content_Err'
    then ErrorStr2:= 'Il contenuto di un elemento con contenuto misto non coincide con la dichiarazione'
  else if FErrorClass = 'EParserElement_With_Illegal_Element_Content_Err'
    then ErrorStr2:= 'Il contenuto di un elemento che contiene elementi non coincide con la dichiarazione'
  else if FErrorClass = 'EParserNondeterministic_Element_Content_Model_Err'
    then ErrorStr2:= 'Il modello di contenuto di un elemento non � deterministico'
  else if FErrorClass = 'EParserDuplicate_Notation_Decl_Err'
    then ErrorStr2:= 'Dichiarazione di notazione duplicata'
  else if FErrorClass = 'EParserAttribute_Definition_Not_Found_Err'
    then ErrorStr2:= 'Definizione di attributo non trovata'
  else if FErrorClass = 'EParserRequired_Attribute_Not_Found_Err'
    then ErrorStr2:= 'Attributo richiesto non trovato'
  else if FErrorClass = 'EParserFixed_Attribute_Mismatch_Err'
    then ErrorStr2:= 'Il valore dichiarato e quello attuale di un attributo fisso non coincidono'
  else if FErrorClass = 'EParserAttribute_Default_Type_Mismatch_Err'
    then ErrorStr2:= 'Il tipo di un attributo ed il suo predefinito non coincidono'
  else if FErrorClass = 'EParserDuplicate_ID_Value_Err'
    then ErrorStr2:= 'Valore ID duplicato'
  else if FErrorClass = 'EParserTarget_ID_Value_Not_Found_Err'
    then ErrorStr2:= 'Il valore IDREF o IDREFS si riferisce ad un valore ID inesistente'
  else if FErrorClass = 'EParserTarget_Unparsed_Entity_Not_Found_Err'
    then ErrorStr2:= 'Il valore ENTITY o ENTITIES si riferisce ad una entit� non analizzata non esistente'
  else if FErrorClass = 'EParserWrong_Declaration_Of_Predefined_Entity_Err'
    then ErrorStr2:= 'Dichiarazione di entit� predefinita errata'
  else if FErrorClass = 'EParserUnresolvable_Entity_Reference_Err'
    then ErrorStr2:= 'Riferimento non risolvibile ad una entit�'
  else if FErrorClass = 'EParserUnresolvable_Parameter_Entity_Reference_Err'
    then ErrorStr2:= 'Riferimento non risolvibile ad una entit� con parametri'
  else if FErrorClass = 'EParserExternal_Subset_Not_Found_Err'
    then ErrorStr2:= 'EParserExternal_Subset_Not_Found_Err'
  else if FErrorClass = 'EParserExternal_Entity_Not_Found_Err'
    then ErrorStr2:= 'EParserExternal_Entity_Not_Found_Err'
  else ErrorStr2:= 'Codice sorgente non valido';

  result:= Iso8859_1ToUTF16Str(concat(ErrorTypeStr,DocStr,ErrorStr1,' -- ',ErrorStr2));
end;

function TXmlParserError.GetPolishErrorStr: wideString;
// - This function was provided by Piotr Kuczynski -
var
  ErrorTypeStr,DocStr,ErrorStr1,ErrorStr2: string;
begin
  case errorType of
    xetFatalError: ErrorTypeStr:='FATALNY B��D ';
    xetError: ErrorTypeStr:='B��D ';
    xetWarning: ErrorTypeStr:='OSTRZE�ENIE: ';
  end;

  if publicId = '' then begin
    if systemId = ''
      then DocStr:= ''
      else DocStr:= concat('w lokalnym dokumencie ',systemId,' ');
  end else begin
    if systemId = ''
      then DocStr:= concat('w publicznym dokumencie ',publicId,' ')
      else DocStr:= concat('w dokumencie ',publicId,' (',systemId,') ');
  end;

  if EndLine = 0 then ErrorStr1:= ''
  else if StartLine = EndLine then begin
    if StartColumn = EndColumn
      then FmtStr(ErrorStr1,'w linii %d, znak %d',[EndLine,EndColumn])
      else FmtStr(ErrorStr1,'w linii %d, pomi�dzy znakiem %d i %d',[EndLine,StartColumn,EndColumn]);
  end else begin
    FmtStr(ErrorStr1,'pomi�dzy lini� %d, znak %d i lini� %d, znak %d',[StartLine,StartColumn,EndLine,EndColumn]);
  end;

  if FErrorClass = 'EParserInvalidElementName_Err'
    then ErrorStr2:= 'Niew�a�ciwa nazwa elementu'
  else if FErrorClass = 'EParserDoubleRootElement_Err'
    then ErrorStr2:= 'Podw�jnie zdefiniowany korze�'
  else if FErrorClass = 'EParserRootNotFound_Err'
    then ErrorStr2:= 'Nie znaleziono korzenia'
  else if FErrorClass = 'EParserDoubleDoctype_Err'
    then ErrorStr2:= 'Podw�jna deklaracja typu dokumentu (DTD)'
  else if FErrorClass = 'EParserInvalidAttributeName_Err'
    then ErrorStr2:= 'Niew�a�ciwa nazwa atrybutu'
  else if FErrorClass = 'EParserInvalidAttributeValue_Err'
    then ErrorStr2:= 'Niew�a�ciwa warto�� atrybutu'
  else if FErrorClass = 'EParserDoubleAttributeName_Err'
    then ErrorStr2:= 'Powtarzaj�ca si� nazwa atrybutu'
  else if FErrorClass = 'EParserInvalidEntityName_Err'
    then ErrorStr2:= 'Niew�a�ciwa nazwa encji'
  else if FErrorClass = 'EParserInvalidProcessingInstruction_Err'
    then ErrorStr2:= 'Niew�a�ciwa instrukcja przetwarzania'
  else if FErrorClass = 'EParserInvalidXmlDeclaration_Err'
    then ErrorStr2:= 'Niew�a�ciwa deklaracja XML'
  else if FErrorClass = 'EParserInvalidCharRef_Err'
    then ErrorStr2:= 'Niew�a�ciwy znak w odwo�aniu'
  else if FErrorClass = 'EParserMissingQuotationMark_Err'
    then ErrorStr2:= 'Brakuj�cy cudzys��w'
  else if FErrorClass = 'EParserMissingEqualitySign_Err'
    then ErrorStr2:= 'Brakuj�cy znak r�wno�ci'
  else if FErrorClass = 'EParserDoubleEqualitySign_Err'
    then ErrorStr2:= 'Podw�jny znak r�wno�ci'
  else if FErrorClass = 'EParserMissingWhiteSpace_Err'
    then ErrorStr2:= 'Brakuj�cy znak spacji'
  else if FErrorClass = 'EParserMissingStartTag_Err'
    then ErrorStr2:= 'Znacznik zamykaj�cy bez znacznika otwieraj�cego'
  else if FErrorClass = 'EParserMissingEndTag_Err'
    then ErrorStr2:= 'Brakuj�cy znacznik zamykaj�cy'
  else if FErrorClass = 'EParserInvalidEndTag_Err'
    then ErrorStr2:= 'Niew�a�ciwy znacznik zamykaj�cy'
  else if FErrorClass = 'EParserInvalidCharacter_Err'
    then ErrorStr2:= 'Niew�a�ciwy znak'
  else if FErrorClass = 'EParserNotInRoot_Err'
    then ErrorStr2:= 'Znak(i) umieszczone poza zasi�giem korzenia'
  else if FErrorClass = 'EParserInvalidDoctype_Err'
    then ErrorStr2:= 'Niew�a�ciwa deklaracja typu dokumentu'
  else if FErrorClass = 'EParserWrongOrder_Err'
    then ErrorStr2:= 'Niew�a�ciwa kolejno��'
  else if FErrorClass = 'EParserUnknownDeclarationType_Err'
    then ErrorStr2:= 'Nieznany typ deklaracji'
  else if FErrorClass = 'EParserInvalidEntityDeclaration_Err'
    then ErrorStr2:= 'Niew�a�ciwa deklaracja encji'
  else if FErrorClass = 'EParserInvalidElementDeclaration_Err'
    then ErrorStr2:= 'Niew�a�ciwa deklaracja elementu'
  else if FErrorClass = 'EParserInvalidAttributeDeclaration_Err'
    then ErrorStr2:= 'Niew�a�ciwa deklaracja atrybutu'
  else if FErrorClass = 'EParserInvalidNotationDeclaration_Err'
    then ErrorStr2:= 'Niew�a�ciwa deklaracja notacji'
  else if FErrorClass = 'EParserInvalidConditionalSection_Err'
    then ErrorStr2:= 'Niew�a�ciwa sekcja warunkowa'
  else if FErrorClass = 'EParserInvalidTextDeclaration_Err'
    then ErrorStr2:= 'Niew�a�ciwa deklaracja tekstu'
  else if FErrorClass = 'EParserLtInAttributeValue_Err'
    then ErrorStr2:= 'Znak ''<'' wyst�puj�cy w zmienianej warto�ci atrybutu'
  else if FErrorClass = 'EParserAttributeValueRefersToExternalEntity_Err'
    then ErrorStr2:= 'Warto�� atrybutu odwo�uje si� do zewn�trznej encji'
  else if FErrorClass = 'EParserReferenceToUnparsedEntity_Err'
    then ErrorStr2:= 'Odwo�anie do encji, kt�ra nie by�a jeszcze parsowana'
  else if FErrorClass = 'EParserNoProperMarkupReferenced_Err'
    then ErrorStr2:= 'Odwo�anie do encji zawieraj�cej niew�a�ciwy znacznik'
  else if FErrorClass = 'EParserInvalidComment_Err'
    then ErrorStr2:= 'EParserInvalidComment_Err'
  else if FErrorClass = 'EParserInvalidCDATASection_Err'
    then ErrorStr2:= 'EParserInvalidCDATASection_Err'
  else if FErrorClass = 'EParserInvalidSystemLiteral_Err'
    then ErrorStr2:= 'EParserInvalidSystemLiteral_Err'
  else if FErrorClass = 'EParserInvalidPubidLiteral_Err'
    then ErrorStr2:= 'EParserInvalidPubidLiteral_Err'
  else if FErrorClass = 'EParserInvalidDoctypeName_Err'
    then ErrorStr2:= 'EParserInvalidDoctypeName_Err'
  else if FErrorClass = 'EParserInvalidQualifiedName_Err'
    then ErrorStr2:= 'EParserInvalidQualifiedName_Err'
  else if FErrorClass = 'EParserInvalidPrefix_Err'
    then ErrorStr2:= 'EParserInvalidPrefix_Err'
  else if FErrorClass = 'EParserInvalidNamespaceURI_Err'
    then ErrorStr2:= 'EParserInvalidNamespaceURI_Err'
  else if FErrorClass = 'EParserNamespaceURINotFound_Err'
    then ErrorStr2:= 'EParserNamespaceURINotFound_Err'
  else if FErrorClass = 'EParserWrongPrefixMappingNesting_Err'
    then ErrorStr2:= 'EParserWrongPrefixMappingNesting_Err'
  else if FErrorClass = 'EParserDouble_AttDef_Warning'
    then ErrorStr2:= 'Podw�jna definicja atrybutu'
  else if FErrorClass = 'EParserDouble_Entity_Decl_Warning'
    then ErrorStr2:= 'Podw�jna deklaracja encji'
  else if FErrorClass = 'EParserDouble_Parameter_Entity_Decl_Warning'
    then ErrorStr2:= 'Podw�jna deklaracja encji parametrycznej'
  else if FErrorClass = 'EParserUnusable_Entity_Decl_Warning'
    then ErrorStr2:= 'Nieu�ywana deklaracja encji'
  else if FErrorClass = 'EParserMissing_Entity_Declaration_Err'
    then ErrorStr2:= 'Brakuj�ca deklaracja encji'
  else if FErrorClass = 'EParserDouble_Element_Type_Declaration_Err'
    then ErrorStr2:= 'Podw�jna deklaracja typu elementu'
  else if FErrorClass = 'EParserDuplicate_Name_In_Mixed_Content_Err'
    then ErrorStr2:= 'Podw�jna nazwa w mieszanej zawarto�ci'
  else if FErrorClass = 'EParserDuplicate_ID_On_Element_Type_Err'
    then ErrorStr2:= 'Zadeklarowany podw�jny atrybut ID dla element�w tego samego typu'
  else if FErrorClass = 'EParserUndeclared_Notation_Name_Err'
    then ErrorStr2:= 'Nie zadeklarowana nazwa notacji'
  else if FErrorClass = 'EParserDuplicate_Notation_On_Element_Type_Err'
    then ErrorStr2:= 'Zadeklarowany podw�jny atrybut notacji dla element�w tego samego typu'
  else if FErrorClass = 'EParserDuplicate_Notation_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Notation_Token_Err'
  else if FErrorClass = 'EParserNotation_On_Empty_Element_Err'
    then ErrorStr2:= 'Atrybut notacji zadeklarowany dla elementu typu pusty'
  else if FErrorClass = 'EParserDuplicate_Enumeration_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Enumeration_Token_Err'
  else if FErrorClass = 'EParserAttribute_Type_Mismatch_Err'
    then ErrorStr2:= 'Typ atrybutu i warto�� atrybutu nie pasuj� do siebie'
  else if FErrorClass = 'EParserDuplicate_Tokens_Err'
    then ErrorStr2:= 'Zadeklarowane dwa identyczne tokeny'
  else if FErrorClass = 'EParserId_Neither_Implied_Nor_Required_Err'
    then ErrorStr2:= 'Atrybut ID nie jest zadeklarowany ani jako #IMPLIED ani #REQUIRED'
  else if FErrorClass = 'EParserWrong_Root_Element_Type_Err'
    then ErrorStr2:= 'Typ korzenia nie pasuje do nazwy z deklaracji typu dokumentu'
  else if FErrorClass = 'EParserElement_Type_Declaration_Not_Found_Err'
    then ErrorStr2:= 'Nie znaleziona deklaracja typu elementu'
  else if FErrorClass = 'EParserElement_Declared_Empty_Has_Content_Err'
    then ErrorStr2:= 'Element zadeklarowany jako EMPTY nie jest pusty'
  else if FErrorClass = 'EParserElement_With_Illegal_Mixed_Content_Err'
    then ErrorStr2:= 'Zawarto�� elementu o mieszanej zawarto�ci nie pasuje do deklaracji'
  else if FErrorClass = 'EParserElement_With_Illegal_Element_Content_Err'
    then ErrorStr2:= 'Zawarto�� elementu, zawieraj�cego element, nie pasuje do deklaracji'
  else if FErrorClass = 'EParserNondeterministic_Element_Content_Model_Err'
    then ErrorStr2:= 'Model zawarto�ci elementu jest niedeterministyczny'
  else if FErrorClass = 'EParserDuplicate_Notation_Decl_Err'
    then ErrorStr2:= 'Podw�jna deklaracja notacji'
  else if FErrorClass = 'EParserAttribute_Definition_Not_Found_Err'
    then ErrorStr2:= 'Definicja atrybutu nie zosta�a znaleziona'
  else if FErrorClass = 'EParserRequired_Attribute_Not_Found_Err'
    then ErrorStr2:= 'Wymagany atrybut nie zosta� znaleziony'
  else if FErrorClass = 'EParserFixed_Attribute_Mismatch_Err'
    then ErrorStr2:= 'Zadeklarowana i bie��ca warto�� sta�ego atrybutu nie pasuja do siebie'
  else if FErrorClass = 'EParserAttribute_Default_Type_Mismatch_Err'
    then ErrorStr2:= 'Typ atrybutu i jego warto�� domy�lna nie pasuj� do siebie'
  else if FErrorClass = 'EParserDuplicate_ID_Value_Err'
    then ErrorStr2:= 'Podw�jna warto�� ID'
  else if FErrorClass = 'EParserTarget_ID_Value_Not_Found_Err'
    then ErrorStr2:= 'Warto�� IDREF lub IDREFS odwo�uje si� do warto�ci ID nieistniej�cego elementu'
  else if FErrorClass = 'EParserTarget_Unparsed_Entity_Not_Found_Err'
    then ErrorStr2:= 'Warto�� ENTITY lub ENTITIES odwo�uje si� do niesparsowanej encji, kt�ra nie istnieje'
  else if FErrorClass = 'EParserWrong_Declaration_Of_Predefined_Entity_Err'
    then ErrorStr2:= 'Niew�a�ciwa deklaracja predefiniowanej encji'
  else if FErrorClass = 'EParserUnresolvable_Entity_Reference_Err'
    then ErrorStr2:= 'Nierozwi�zywalna referencja do encji'
  else if FErrorClass = 'EParserUnresolvable_Parameter_Entity_Reference_Err'
    then ErrorStr2:= 'Nierozwi�zywalna referencja encji parametrycznej'
  else if FErrorClass = 'EParserExternal_Subset_Not_Found_Err'
    then ErrorStr2:= 'Zewn�trzny podzbi�r DTD nie zosta� znaleziony'
  else if FErrorClass = 'EParserExternal_Entity_Not_Found_Err'
    then ErrorStr2:= 'Encja zewn�trzna nie zosta�a znaleziona'
  else ErrorStr2:= 'Niew�a�ciwy kod �r�d�owy';

  result:= cp1250ToUTF16Str(concat(ErrorTypeStr,DocStr,ErrorStr1,' -- ',ErrorStr2));
end;

function TXmlParserError.GetSpanishErrorStr: wideString;
// - This function was provided by Pedro de Paz -
var
  ErrorTypeStr,DocStr,ErrorStr1,ErrorStr2: string;
begin
  case errorType of
    xetFatalError: ErrorTypeStr:='ERROR FATAL ';
    xetError: ErrorTypeStr:='ERROR ';
    xetWarning: ErrorTypeStr:='AVISO: ';
  end;

  if publicId = '' then begin
    if systemId = ''
      then DocStr:= ''
      else DocStr:= concat('en el documento local ',systemId,' ');
  end else begin
    if systemId = ''
      then DocStr:= concat('en el documento publico ',publicId,' ')
      else DocStr:= concat('en el documento ',publicId,' (',systemId,') ');
  end;

  if EndLine = 0 then ErrorStr1:= ''
  else if StartLine = EndLine then begin
    if StartColumn = EndColumn
      then FmtStr(ErrorStr1,'en la linea %d, posici�n %d',[EndLine,EndColumn])
      else FmtStr(ErrorStr1,'en la linea %d, entre las posiciones %d y %d',[EndLine,StartColumn,EndColumn]);
  end else begin
    FmtStr(ErrorStr1,'entre la linea %d, posici�n %d y la linea %d, posici�n %d',[StartLine,StartColumn,EndLine,EndColumn]);
  end;

  if FErrorClass = 'EParserInvalidElementName_Err'
    then ErrorStr2:= 'Nombre de elemento no v�lido'
  else if FErrorClass = 'EParserDoubleRootElement_Err'
    then ErrorStr2:= 'Elemento raiz duplicado'
  else if FErrorClass = 'EParserRootNotFound_Err'
    then ErrorStr2:= 'Elemento raiz no encontrado'
  else if FErrorClass = 'EParserDoubleDoctype_Err'
    then ErrorStr2:= 'Declaraci�n de tipo de documento (DTD) duplicada'
  else if FErrorClass = 'EParserInvalidAttributeName_Err'
    then ErrorStr2:= 'Nombre de atributo no v�lido'
  else if FErrorClass = 'EParserInvalidAttributeValue_Err'
    then ErrorStr2:= 'Valor de atributo no v�lido'
  else if FErrorClass = 'EParserDoubleAttributeName_Err'
    then ErrorStr2:= 'Atributo duplicado en un elemento'
  else if FErrorClass = 'EParserInvalidEntityName_Err'
    then ErrorStr2:= 'Nombre de entidad no v�lida'
  else if FErrorClass = 'EParserInvalidProcessingInstruction_Err'
    then ErrorStr2:= 'Instrucci�n de proceso no v�lida'
  else if FErrorClass = 'EParserInvalidXmlDeclaration_Err'
    then ErrorStr2:= 'Declaraci�n XML no v�lida'
  else if FErrorClass = 'EParserInvalidCharRef_Err'
    then ErrorStr2:= 'Referencia a caracter no v�lida'
  else if FErrorClass = 'EParserMissingQuotationMark_Err'
    then ErrorStr2:= 'No se encontraron comillas'
  else if FErrorClass = 'EParserMissingEqualitySign_Err'
    then ErrorStr2:= 'No se encontr� simbolo de igualdad'
  else if FErrorClass = 'EParserDoubleEqualitySign_Err'
    then ErrorStr2:= 'Signo de igualdad duplicado'
  else if FErrorClass = 'EParserMissingWhiteSpace_Err'
    then ErrorStr2:= 'No se encontr� espacio en blanco'
  else if FErrorClass = 'EParserMissingStartTag_Err'
    then ErrorStr2:= 'Tag final sin tag de inicio'
  else if FErrorClass = 'EParserMissingEndTag_Err'
    then ErrorStr2:= 'Tag de inicio sin tag final'
  else if FErrorClass = 'EParserInvalidEndTag_Err'
    then ErrorStr2:= 'Tag final no v�lido'
  else if FErrorClass = 'EParserInvalidCharacter_Err'
    then ErrorStr2:= 'Caracter no v�lido'
  else if FErrorClass = 'EParserNotInRoot_Err'
    then ErrorStr2:= 'Caracter(es) fuera del elemento raiz'
  else if FErrorClass = 'EParserInvalidDoctype_Err'
    then ErrorStr2:= 'Declaraci�n de tipo de documento no v�lida'
  else if FErrorClass = 'EParserWrongOrder_Err'
    then ErrorStr2:= 'Orden equivocado'
  else if FErrorClass = 'EParserUnknownDeclarationType_Err'
    then ErrorStr2:= 'Tipo de declaraci�n desconocida'
  else if FErrorClass = 'EParserInvalidEntityDeclaration_Err'
    then ErrorStr2:= 'Declaraci�n de entidad no v�lida'
  else if FErrorClass = 'EParserInvalidElementDeclaration_Err'
    then ErrorStr2:= 'Declaraci�n de elemento no v�lida'
  else if FErrorClass = 'EParserInvalidAttributeDeclaration_Err'
    then ErrorStr2:= 'Declaraci�n de atributo no v�lida'
  else if FErrorClass = 'EParserInvalidNotationDeclaration_Err'
    then ErrorStr2:= 'Declaraci�n de anotaci�n no v�lida'
  else if FErrorClass = 'EParserInvalidConditionalSection_Err'
    then ErrorStr2:= 'Secci�n condicional no v�lida'
  else if FErrorClass = 'EParserInvalidTextDeclaration_Err'
    then ErrorStr2:= 'Declaraci�n de texto no v�lida'
  else if FErrorClass = 'EParserLtInAttributeValue_Err'
    then ErrorStr2:= 'Encontrado caracter ''<'' en valor de atributo'
  else if FErrorClass = 'EParserAttributeValueRefersToExternalEntity_Err'
    then ErrorStr2:= 'Valor de atributo apuntando a una entidad externa'
  else if FErrorClass = 'EParserReferenceToUnparsedEntity_Err'
    then ErrorStr2:= 'Referencia a una entidad no analizada'
  else if FErrorClass = 'EParserNoProperMarkupReferenced_Err'
    then ErrorStr2:= 'Referencia a una entidad que contiene un ''markup'' no adecuado'
  else if FErrorClass = 'EParserInvalidComment_Err'
    then ErrorStr2:= 'EParserInvalidComment_Err'
  else if FErrorClass = 'EParserInvalidCDATASection_Err'
    then ErrorStr2:= 'EParserInvalidCDATASection_Err'
  else if FErrorClass = 'EParserInvalidSystemLiteral_Err'
    then ErrorStr2:= 'EParserInvalidSystemLiteral_Err'
  else if FErrorClass = 'EParserInvalidPubidLiteral_Err'
    then ErrorStr2:= 'EParserInvalidPubidLiteral_Err'
  else if FErrorClass = 'EParserInvalidDoctypeName_Err'
    then ErrorStr2:= 'EParserInvalidDoctypeName_Err'
  else if FErrorClass = 'EParserInvalidQualifiedName_Err'
    then ErrorStr2:= 'EParserInvalidQualifiedName_Err'
  else if FErrorClass = 'EParserInvalidPrefix_Err'
    then ErrorStr2:= 'EParserInvalidPrefix_Err'
  else if FErrorClass = 'EParserInvalidNamespaceURI_Err'
    then ErrorStr2:= 'EParserInvalidNamespaceURI_Err'
  else if FErrorClass = 'EParserNamespaceURINotFound_Err'
    then ErrorStr2:= 'EParserNamespaceURINotFound_Err'
  else if FErrorClass = 'EParserWrongPrefixMappingNesting_Err'
    then ErrorStr2:= 'EParserWrongPrefixMappingNesting_Err'
  else if FErrorClass = 'EParserDouble_AttDef_Warning'
    then ErrorStr2:= 'Definici�n de atributo duplicada'
  else if FErrorClass = 'EParserDouble_Entity_Decl_Warning'
    then ErrorStr2:= 'Declaraci�n de entidad duplicada'
  else if FErrorClass = 'EParserDouble_Parameter_Entity_Decl_Warning'
    then ErrorStr2:= 'Declaraci�n de entidad con parametros duplicados'
  else if FErrorClass = 'EParserUnusable_Entity_Decl_Warning'
    then ErrorStr2:= 'Declaraci�n de entidad no utilizable'
  else if FErrorClass = 'EParserMissing_Entity_Declaration_Err'
    then ErrorStr2:= 'No existe declaraci�n de entidad'
  else if FErrorClass = 'EParserDouble_Element_Type_Declaration_Err' 
    then ErrorStr2:= 'Duplicada declaraci�n de tipo de elemento'
  else if FErrorClass = 'EParserDuplicate_Name_In_Mixed_Content_Err'
    then ErrorStr2:= 'Nombre duplicado en contenido mezclado'
  else if FErrorClass = 'EParserDuplicate_ID_On_Element_Type_Err' 
    then ErrorStr2:= 'Atributo ID duplicado en la misma declaraci�n de tipo de elemento'
  else if FErrorClass = 'EParserUndeclared_Notation_Name_Err'
    then ErrorStr2:= 'Nombre de anotaci�n no declarado'
  else if FErrorClass = 'EParserDuplicate_Notation_On_Element_Type_Err'
    then ErrorStr2:= 'Atributo de anotaci�n duplicado en la misma declaraci�n de tipo de elemento'
  else if FErrorClass = 'EParserDuplicate_Notation_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Notation_Token_Err'
  else if FErrorClass = 'EParserNotation_On_Empty_Element_Err'
    then ErrorStr2:= 'Atributo de anotaci�n en una declaraci�n de tipo de elemento vacia'
  else if FErrorClass = 'EParserDuplicate_Enumeration_Token_Err'
    then ErrorStr2:= 'EParserDuplicate_Enumeration_Token_Err'
  else if FErrorClass = 'EParserAttribute_Type_Mismatch_Err'
    then ErrorStr2:= 'Tipo de atributo y valor de atributo no coinciden'
  else if FErrorClass = 'EParserDuplicate_Tokens_Err'
    then ErrorStr2:= 'Declaraci�n de ''tokens'' duplicada'
  else if FErrorClass = 'EParserId_Neither_Implied_Nor_Required_Err'
    then ErrorStr2:= 'Atributo ID no ha sido declarado como #IMPLIED ni como #REQUIRED'
  else if FErrorClass = 'EParserWrong_Root_Element_Type_Err'
    then ErrorStr2:= 'El tipo del elemento raiz no tiene el mismo nombre que la declaraci�n del tipo de documento'
  else if FErrorClass = 'EParserElement_Type_Declaration_Not_Found_Err'
    then ErrorStr2:= 'Declaraci�n de tipo de elemento no encontrada'
  else if FErrorClass = 'EParserElement_Declared_Empty_Has_Content_Err'
    then ErrorStr2:= 'Elemento declarado como ''EMPTY'' no esta vacio'
  else if FErrorClass = 'EParserElement_With_Illegal_Mixed_Content_Err' 
    then ErrorStr2:= 'El contenido de un elemento con contenido mezclado no coincide con su declaraci�n'
  else if FErrorClass = 'EParserElement_With_Illegal_Element_Content_Err'
    then ErrorStr2:= 'El contenido de un elemento con contenido de elemento no coincide con su declaraci�n'
  else if FErrorClass = 'EParserNondeterministic_Element_Content_Model_Err'
    then ErrorStr2:= 'El modelo de contenido de un elemento no es determinante'
  else if FErrorClass = 'EParserDuplicate_Notation_Decl_Err'
    then ErrorStr2:= 'Declaraci�n de anotaci�n duplicada'
  else if FErrorClass = 'EParserAttribute_Definition_Not_Found_Err'
    then ErrorStr2:= 'Definici�n de atributo no encontrada'
  else if FErrorClass = 'EParserRequired_Attribute_Not_Found_Err'
    then ErrorStr2:= 'Atributo requerido no encontrado'
  else if FErrorClass = 'EParserFixed_Attribute_Mismatch_Err'
    then ErrorStr2:= 'El valor declarado y el valor actual de un atributo fijo no coincide'
  else if FErrorClass = 'EParserAttribute_Default_Type_Mismatch_Err'
    then ErrorStr2:= 'El tipo de atributo y el atributo por defecto no coincide'
  else if FErrorClass = 'EParserDuplicate_ID_Value_Err'
    then ErrorStr2:= 'Valor de ID duplicado'
  else if FErrorClass = 'EParserTarget_ID_Value_Not_Found_Err'
    then ErrorStr2:= 'El valor de IDREF o IDREFS apunta a un valor de ID no existente'
  else if FErrorClass = 'EParserTarget_Unparsed_Entity_Not_Found_Err'
    then ErrorStr2:= 'El valor de ENTITY o ENTITIES apunta a una entidad no existente'
  else if FErrorClass = 'EParserWrong_Declaration_Of_Predefined_Entity_Err'
    then ErrorStr2:= 'DEclaraci�n erronea de una entidad predefinida'
  else if FErrorClass = 'EParserUnresolvable_Entity_Reference_Err'
    then ErrorStr2:= 'Referencia a entidad imposible de resolver'
  else if FErrorClass = 'EParserExternal_Subset_Not_Found_Err'
    then ErrorStr2:= 'EParserExternal_Subset_Not_Found_Err'
  else if FErrorClass = 'EParserExternal_Entity_Not_Found_Err'
    then ErrorStr2:= 'EParserExternal_Entity_Not_Found_Err'
  else ErrorStr2:= 'Codigo fuente no v�lido';
  result:= Iso8859_1ToUTF16Str(concat(ErrorTypeStr,DocStr,ErrorStr1,' -- ',ErrorStr2));
end;

function TXmlParserError.GetErrorStr(const lang: TXmlParserLanguage): wideString;
begin
  Result:= '';

  case lang of
    iso639_de: result:= getGermanErrorStr;
    iso639_en: result:= getEnglishErrorStr;
    iso639_es: result:= getSpanishErrorStr;
    iso639_fr: result:= getFrenchErrorStr;
    iso639_it: result:= getItalianErrorStr;
    iso639_nl: result:= getDutchErrorStr;
    iso639_pl: result:= getPolishErrorStr;
  end;

  if FCode = ''
    then Result:= concat(Result,'.')
    else Result:= concat(Result,': ',FCode);
end;



// +++++++++++++++++++++++++ TXmlMemoryStream +++++++++++++++++++++++++
procedure TXmlMemoryStream.SetPointer(ptr: pointer; size: longint);
begin
  inherited setPointer(ptr,size);
end;



// ++++++++++++++++++++++++ TdomStandardLocator ++++++++++++++++++++++++
constructor TdomStandardLocator.create(const inputSource: TXmlInputSource);
begin
  inherited create;
  FInputSource:= inputSource;
  self.reset;
end;

function TdomStandardLocator.getPublicId: wideString;
begin
  Result:= '';
  if assigned(FInputSource)
    then Result:= FInputSource.publicId;
end;

function TdomStandardLocator.getSystemId: wideString;
begin
  Result:= '';
  if assigned(FInputSource)
    then Result:= FInputSource.systemId;
end;

procedure TdomStandardLocator.evaluate(const s: WideChar);
const
  LF: WideChar  = #10;
begin
  if FLastWCharWasLF then begin
    inc(FLineNumber);
    FLastWCharWasLF:= false;
    FColumnNumber:= 1;
  end else
    inc(FColumnNumber);
  if s = LF then FLastWCharWasLF:= true;
  if FPieceEndSet then pieceStart;
end;

procedure TdomStandardLocator.pieceEnd;
begin
  FPieceEndSet:= true;
end;

procedure TdomStandardLocator.pieceStart;
begin
  FStartColumnNumber:= FColumnNumber;
  FStartLineNumber:=   FLineNumber;
  FPieceEndSet:= false;
end;

procedure TdomStandardLocator.reset;
begin
  FColumnNumber:=      0;
  FLineNumber:=        0;
  FStartColumnNumber:= 0;
  FStartLineNumber:=   0;
  FLastWCharWasLF:=    true;
  pieceEnd;
end;



// ++++++++++++++++++++++++ TXmlStandardProcessorAgent +++++++++++++++++++++++
procedure TXmlStandardProcessorAgent.Notification(AComponent: TComponent; operation: TOperation);
begin
  inherited notification(AComponent,Operation);
  if (Operation = opRemove) and (AComponent = FReader)
    then FReader:= nil;
end;

function TXmlStandardProcessorAgent.processFile(const pubId,
                                                      sysId: wideString): boolean;
var
  MStream: TMemoryStream;
begin
  if sysId = ''
    then raise EAccessViolation.create('Filename not specified.');
  MStream:= TMemoryStream.create;
  try
    MStream.LoadFromFile(sysId);
    result:= processStream(MStream,pubId,sysId);
  finally
    MStream.free;
  end; {try}
end;

function TXmlStandardProcessorAgent.processMemory(const ptr: pointer;
                                                  const size: longint;
                                                  const pubId,
                                                        sysId: wideString): boolean;
var
  MStream: TXmlMemoryStream;
begin
  if not assigned(ptr) then raise EAccessViolation.create('pointer not specified.');
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    result:= processStream(MStream,pubId,sysId);
  finally
    MStream.free;
  end; {try}
end;

function TXmlStandardProcessorAgent.processSourceCode(const intDtdSourceCode: TXmlSourceCode;
                                                      const pubId,
                                                            sysId: wideString): boolean;
var
  content: TdomCustomStr;
  i: integer;
begin
  if not assigned(intDtdSourceCode) then raise EAccessViolation.create('Stream not specified.');
  content:= TdomCustomStr.create;
  try
    for i:= 0 to intDtdSourceCode.Count -1 do
      content.addWideString(TXmlSourceCodePiece(intDtdSourceCode[i]).text);
    result:= processString(content.value,pubId,sysId);
  finally
    content.free;
  end;
end;

function TXmlStandardProcessorAgent.processStream(const stream: TStream;
                                                  const pubId,
                                                        sysId: wideString): boolean;
var
  InputSrc: TXmlInputSource;
begin
  if not assigned(stream) then raise EAccessViolation.create('Stream not specified.');
  InputSrc:= TXmlInputSource.create(stream,pubId,sysId);
  try
    if assigned(Reader)
      then result:= Reader.parse(self,InputSrc)
      else result:= true;
  finally
    InputSrc.free;
  end; {try}
end;

function TXmlStandardProcessorAgent.processString(const str: String;
                                                  const pubId,
                                                        sysId: wideString): boolean;
var
  ptr: PChar;
  size: longint;
  MStream: TXmlMemoryStream;
begin
  ptr:= pointer(str);
  size:= length(str);
  if size = 0 then raise EAccessViolation.create('Empty string.');
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    result:= processStream(MStream,pubId,sysId);
  finally
    MStream.free;
  end; {try}
end;

function TXmlStandardProcessorAgent.processWideString(str: wideString;
                                                      const pubId,
                                                            sysId: wideString): boolean;
var
  ptr: PChar;
  size: longint;
  MStream: TXmlMemoryStream;
begin
  if str = '' then raise EAccessViolation.create('Empty string.');
  if str[1] <> #$feff
    then  str:= concat(wideString(#$feff),str);
  ptr:= pointer(str);
  size:= length(str)*2;
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    result:= processStream(MStream,pubId,sysId);
  finally
    MStream.free;
  end; {try}
end;



// ++++++++++++++++++++++++++++ TXmlCustomHandler ++++++++++++++++++++++++++++
procedure TXmlCustomHandler.SendErrorNotification(const sender: TXmlCustomProcessorAgent;
                                                        var e: TXmlParserError);
begin
  if not assigned(e) then exit;
  case e.errorType of
    xetFatalError: fatalError(sender,e);
    xetError: error(sender,e);
    xetWarning: warning(sender,e);
  end;
end;

procedure TXmlCustomHandler.error(const sender: TXmlCustomProcessorAgent;
                                    var e: TXmlParserError);
begin
  if assigned(FOnError) then FOnError(sender,e);
  // By default return nil.
  e.free;
  e:= nil;
end;

procedure TXmlCustomHandler.fatalError(const sender: TXmlCustomProcessorAgent;
                                         var e: TXmlParserError);
begin
  if assigned(FOnFatalError) then FOnFatalError(sender,e);
  // By default return the exception, i.e. do nothing.
end;

procedure TXmlCustomHandler.warning(const sender: TXmlCustomProcessorAgent;
                                      var e: TXmlParserError);
begin
  if assigned(FOnWarning) then FOnWarning(sender,e);
  // By default return nil.
  e.free;
  e:= nil;
end;



// +++++++++++++++++++++++++++ TXmlStandardHandler +++++++++++++++++++++++++++
procedure TXmlStandardHandler.Notification(AComponent: TComponent; operation: TOperation);
begin
  inherited notification(AComponent,Operation);
  if (Operation = opRemove) and (AComponent = FNextHandler)
    then FNextHandler:= nil;
end;

function TXmlStandardHandler.CDATA(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         data: wideString): TXmlParserError;
begin
  if assigned(FOnCDATA) then FOnCDATA(sender,locator,data);
  if assigned(nextHandler)
    then result:= nextHandler.CDATA(sender,locator,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.charRef(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           data: wideString): TXmlParserError;
begin
  if assigned(FOnCharRef) then FOnCharRef(sender,locator,data);
  if assigned(nextHandler)
    then result:= nextHandler.charRef(sender,locator,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.comment(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           data: wideString): TXmlParserError;
begin
  if assigned(FOnComment) then FOnComment(sender,locator,data);
  if assigned(nextHandler)
    then result:= nextHandler.comment(sender,locator,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.doctype(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           name,
                                           pubId,
                                           sysId,
                                           data: wideString): TXmlParserError;
begin
  if assigned(FOnDoctype) then FOnDoctype(sender,locator,name,pubId,sysId,data);
  if assigned(nextHandler)
    then result:= nextHandler.doctype(sender,locator,name,pubId,sysId,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.endDocument(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator): TXmlParserError;
begin
  if assigned(FOnEndDocument) then FOnEndDocument(sender,locator);
  if assigned(nextHandler)
    then result:= nextHandler.endDocument(sender,locator)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.endElement(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              namespaceURI,
                                              tagName: wideString): TXmlParserError;
begin
  if assigned(FOnEndElement) then FOnEndElement(sender,locator,namespaceURI,tagName);
  if assigned(nextHandler)
    then result:= nextHandler.endElement(sender,locator,namespaceURI,tagName)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                              const locator: TdomStandardLocator;
                                                    prefix: wideString): TXmlParserError;
begin
  if assigned(FOnEndPrefixMapping) then FOnEndPrefixMapping(sender,locator,prefix);
  if assigned(nextHandler)
    then result:= nextHandler.endPrefixMapping(sender,locator,prefix)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.entityRef(const sender: TXmlCustomProcessorAgent;
                                       const locator: TdomStandardLocator;
                                             name: wideString): TXmlParserError;
begin
  if assigned(FOnEntityRef) then FOnEntityRef(sender,locator,name);
  if assigned(nextHandler)
    then result:= nextHandler.entityRef(sender,locator,name)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.PCDATA(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator;
                                          data: wideString): TXmlParserError;
begin
  if assigned(FOnPCDATA) then FOnPCDATA(sender,locator,data);
  if assigned(nextHandler)
    then result:= nextHandler.PCDATA(sender,locator,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.processingInstruction(const sender: TXmlCustomProcessorAgent;
                                                   const locator: TdomStandardLocator;
                                                         targ,
                                                         data : wideString): TXmlParserError;
begin
  if assigned(FOnProcessingInstruction) then FOnProcessingInstruction(sender,locator,targ,data);
  if assigned(nextHandler)
    then result:= nextHandler.processingInstruction(sender,locator,targ,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.skippedEntity(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                                 name: wideString): TXmlParserError;
begin
  if assigned(FOnSkippedEntity) then FOnSkippedEntity(sender,locator,name);
  if assigned(nextHandler)
    then result:= nextHandler.skippedEntity(sender,locator,name)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.startDocument(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                                 defaultRoot: wideString): TXmlParserError;
begin
  if assigned(FOnStartDocument) then FOnStartDocument(sender,locator,defaultRoot);
  if assigned(nextHandler)
    then result:= nextHandler.startDocument(sender,locator,defaultRoot)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.startElement(const sender: TXmlCustomProcessorAgent;
                                          const locator: TdomStandardLocator;
                                                namespaceURI,
                                                tagName: wideString;
                                                attributes: TdomNameValueList): TXmlParserError;
begin
  if assigned(FOnStartElement) then FOnStartElement(sender,locator,namespaceURI,tagName,attributes);
  if assigned(nextHandler)
    then result:= nextHandler.startElement(sender,locator,namespaceURI,tagName,attributes)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                                const locator: TdomStandardLocator;
                                                      prefix,
                                                      uri: wideString): TXmlParserError;
begin
  if assigned(FOnStartPrefixMapping) then FOnStartPrefixMapping(sender,locator,prefix,uri);
  if assigned(nextHandler)
    then result:= nextHandler.startPrefixMapping(sender,locator,prefix,uri)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                                  version,
                                                  encDl,
                                                  sdDl: wideString): TXmlParserError;
begin
  if assigned(FOnXmlDeclaration) then FOnXmlDeclaration(sender,locator,version,encDl,sdDl);
  if assigned(nextHandler)
    then result:= nextHandler.xmlDeclaration(sender,locator,version,encDl,sdDl)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.attributeDefinition(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                       name,
                                                       attType,
                                                       bracket,
                                                       defaultDecl,
                                                       attValue: wideString): TXmlParserError;
begin
  if assigned(FOnAttributeDefinition) then FOnAttributeDefinition(sender,locator,name,attType,bracket,defaultDecl,attValue);
  if assigned(nextHandler)
    then result:= nextHandler.attributeDefinition(sender,locator,name,attType,bracket,defaultDecl,attValue)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.conditionalSection(const sender: TXmlCustomProcessorAgent;
                                                const locator: TdomStandardLocator;
                                                      includeStmt,
                                                      data: wideString): TXmlParserError;
begin
  if assigned(FOnConditionalSection) then FOnConditionalSection(sender,locator,includeStmt,data);
  if assigned(nextHandler)
    then result:= nextHandler.conditionalSection(sender,locator,includeStmt,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.DTDcomment(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              data: wideString): TXmlParserError;
begin
  if assigned(FOnDtdComment) then FOnDtdComment(sender,locator,data);
  if assigned(nextHandler)
    then result:= nextHandler.DTDcomment(sender,locator,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.DTDprocessingInstruction(const sender: TXmlCustomProcessorAgent;
                                                      const locator: TdomStandardLocator;
                                                            targ,
                                                            data : wideString): TXmlParserError;
begin
  if assigned(FOnDtdProcessingInstruction) then FOnDtdProcessingInstruction(sender,locator,targ,data);
  if assigned(nextHandler)
    then result:= nextHandler.DTDprocessingInstruction(sender,locator,targ,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.elementTypeDeclaration(const sender: TXmlCustomProcessorAgent;
                                                    const locator: TdomStandardLocator;
                                                          name,
                                                          data: wideString): TXmlParserError;
begin
  if assigned(FOnElementTypeDeclaration) then FOnElementTypeDeclaration(sender,locator,name,data);
  if assigned(nextHandler)
    then result:= nextHandler.elementTypeDeclaration(sender,locator,name,data)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.endAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                                   const locator: TdomStandardLocator): TXmlParserError;
begin
  if assigned(FOnEndAttListDeclaration) then FOnEndAttListDeclaration(sender,locator);
  if assigned(nextHandler)
    then result:= nextHandler.endAttListDeclaration(sender,locator)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.endDtd(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator): TXmlParserError;
begin
  if assigned(FOnEndDtd) then FOnEndDtd(sender,locator);
  if assigned(nextHandler)
    then result:= nextHandler.endDtd(sender,locator)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.entityDeclaration(const sender: TXmlCustomProcessorAgent;
                                               const locator: TdomStandardLocator;
                                                     name,
                                                     entityValue,
                                                     pubId,
                                                     sysId,
                                                     notaName: wideString): TXmlParserError;
begin
  if assigned(FOnEntityDeclaration) then FOnEntityDeclaration(sender,locator,name,entityValue,pubId,sysId,notaName);
  if assigned(nextHandler)
    then result:= nextHandler.entityDeclaration(sender,locator,name,entityValue,pubId,sysId,notaName)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.notationDeclaration(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                       name,
                                                       pubId,
                                                       sysId: wideString): TXmlParserError;
begin
  if assigned(FOnNotationDeclaration) then FOnNotationDeclaration(sender,locator,name,pubId,sysId);
  if assigned(nextHandler)
    then result:= nextHandler.notationDeclaration(sender,locator,name,pubId,sysId)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.parameterEntityDeclaration(const sender: TXmlCustomProcessorAgent;
                                                        const locator: TdomStandardLocator;
                                                              name,
                                                              entityValue,
                                                              pubId,
                                                              sysId: wideString): TXmlParserError;
begin
  if assigned(FOnParameterEntityDeclaration) then FOnParameterEntityDeclaration(sender,locator,name,entityValue,pubId,sysId);
  if assigned(nextHandler)
    then result:= nextHandler.parameterEntityDeclaration(sender,locator,name,entityValue,pubId,sysId)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.parameterEntityRef(const sender: TXmlCustomProcessorAgent;
                                                const locator: TdomStandardLocator;
                                                      name: wideString): TXmlParserError;
begin
  if assigned(FOnParameterEntityRef) then FOnParameterEntityRef(sender,locator,name);
  if assigned(nextHandler)
    then result:= nextHandler.parameterEntityRef(sender,locator,name)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.startAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                                     const locator: TdomStandardLocator;
                                                           name: wideString): TXmlParserError;
begin
  if assigned(FOnStartAttListDeclaration) then FOnStartAttListDeclaration(sender,locator,name);
  if assigned(nextHandler)
    then result:= nextHandler.startAttListDeclaration(sender,locator,name)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.startDtd(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            pubId,
                                            sysId: wideString): TXmlParserError;
begin
  if assigned(FOnStartDtd) then FOnStartDtd(sender,pubId,sysId);
  if assigned(nextHandler)
    then result:= nextHandler.startDtd(sender,locator,pubId,sysId)
    else result:= nil;
  SendErrorNotification(sender,result);
end;

function TXmlStandardHandler.textDeclaration(const sender: TXmlCustomProcessorAgent;
                                             const locator: TdomStandardLocator;
                                                   version,
                                                   encDl: wideString): TXmlParserError;
begin
  if assigned(FOnTextDeclaration) then FOnTextDeclaration(sender,locator,version,encDl);
  if assigned(nextHandler)
    then result:= nextHandler.textDeclaration(sender,locator,version,encDl)
    else result:= nil;
  SendErrorNotification(sender,result);
end;



// +++++++++++++++++++++++++++++ TXmlHandlerItem +++++++++++++++++++++++++++++
function TXmlHandlerItem.getXmlHandler: TXmlCustomHandler;
begin
  Result := FXmlHandler;
end;

procedure TXmlHandlerItem.setXmlHandler(Value: TXmlCustomHandler);
begin
  FXmlHandler:= Value;
end;

procedure TXmlHandlerItem.Assign(Source: TPersistent);
begin
  if Source is TXmlHandlerItem
    then XmlHandler:= TXmlHandlerItem(Source).XmlHandler
    else inherited Assign(Source);
end;


// +++++++++++++++++++++++++++++++ TXmlHandlers ++++++++++++++++++++++++++++++
constructor TXmlHandlers.Create(Distributor: TXmlDistributor);
begin
  inherited create(TXmlHandlerItem);
  FDistributor:= Distributor;
end;

function TXmlHandlers.GetItem(Index: Integer): TXmlHandlerItem;
begin
  result:= TXmlHandlerItem(inherited GetItem(Index));
end;

procedure TXmlHandlers.SetItem(Index: Integer; Value: TXmlHandlerItem);
begin
  inherited SetItem(Index, Value);
end;

function TXmlHandlers.GetOwner: TPersistent;
begin
  result:= FDistributor;
end;

function TXmlHandlers.Add: TXmlHandlerItem;
begin
  result:= TXmlHandlerItem(inherited Add);
end;

procedure TXmlHandlers.Assign(Source: TPersistent);
var
  i: integer;
begin
  if Source = self then exit;
  if Source is TStrings then begin
    clear;
    with TStrings(Source) do
      for i:= 0 to pred(count) do
        if assigned(Objects[i])
          then if Objects[i] is TXmlCustomHandler
            then self.add.XmlHandler:= TXmlCustomHandler(Objects[i]);
  end else inherited Assign(Source);
end;

function TXmlHandlers.FindHandlerItem(AHandler: TXmlCustomHandler): TXmlHandlerItem;
var
  i: integer;
begin
  for i:= 0 to pred(count) do
  begin
    result := TXmlHandlerItem(inherited getItem(i));
    if result.FXmlHandler = AHandler then exit;
  end;
  result:= nil;
end;



// +++++++++++++++++++++++++++++ TXmlDistributor +++++++++++++++++++++++++++++
constructor TXmlDistributor.create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FNextHandlers:= TXmlHandlers.create(self);
end;

destructor TXmlDistributor.destroy;
begin
  FNextHandlers.free;
  inherited destroy;
end;

procedure TXmlDistributor.readData(Reader: TReader);
begin
  Reader.ReadCollection(nextHandlers);
end;

procedure TXmlDistributor.writeData(Writer: TWriter);
begin
  Writer.WriteCollection(nextHandlers);
end;

procedure TXmlDistributor.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('NextHandlers',readData,writeData,true);
end;

procedure TXmlDistributor.Notification(AComponent: TComponent; operation: TOperation);
var
  handlerItem: TXmlHandlerItem;
begin
  inherited notification(AComponent,Operation);
  if not (csDestroying in ComponentState) and (Operation = opRemove) then begin
    if (AComponent is TXmlCustomHandler) then  begin
      handlerItem := nextHandlers.FindHandlerItem(TXmlCustomHandler(AComponent));
      if handlerItem <> nil then handlerItem.XmlHandler:= nil;
    end;
  end;
end;

procedure TXmlDistributor.setNextHandlers(const value: TXmlHandlers);
begin
  FNextHandlers.Assign(Value);
end;

function TXmlDistributor.CDATA(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                                     data: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnCDATA) then FOnCDATA(sender,locator,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.CDATA(sender,locator,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.charRef(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       data: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnCharRef) then FOnCharRef(sender,locator,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.charRef(sender,locator,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.comment(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       data: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnComment) then FOnComment(sender,locator,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.comment(sender,locator,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.doctype(const sender: TXmlCustomProcessorAgent;
                                 const locator: TdomStandardLocator;
                                       name,
                                       pubId,
                                       sysId,
                                       data: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnDoctype) then FOnDoctype(sender,locator,name,pubId,sysId,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.doctype(sender,locator,name,pubId,sysId,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.endDocument(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnEndDocument) then FOnEndDocument(sender,locator);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.endDocument(sender,locator);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.endElement(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator;
                                          namespaceURI,
                                          tagName: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnEndElement) then FOnEndElement(sender,locator,namespaceURI,tagName);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.endElement(sender,locator,namespaceURI,tagName);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                          const locator: TdomStandardLocator;
                                                prefix: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnEndPrefixMapping) then FOnEndPrefixMapping(sender,locator,prefix);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.endPrefixMapping(sender,locator,prefix);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.entityRef(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         name: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnEntityRef) then FOnEntityRef(sender,locator,name);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.entityRef(sender,locator,name);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.PCDATA(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                     data: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnPCDATA) then FOnPCDATA(sender,locator,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.PCDATA(sender,locator,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.processingInstruction(const sender: TXmlCustomProcessorAgent;
                                               const locator: TdomStandardLocator;
                                                     targ,
                                                     data : wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnProcessingInstruction) then FOnProcessingInstruction(sender,locator,targ,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.processingInstruction(sender,locator,targ,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.skippedEntity(const sender: TXmlCustomProcessorAgent;
                                       const locator: TdomStandardLocator;
                                             name: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnSkippedEntity) then FOnSkippedEntity(sender,locator,name);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.skippedEntity(sender,locator,name);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.startDocument(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                                 defaultRoot: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnStartDocument) then FOnStartDocument(sender,locator,defaultRoot);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.startDocument(sender,locator,defaultRoot);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.startElement(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            namespaceURI,
                                            tagName: wideString;
                                            attributes: TdomNameValueList): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnStartElement) then FOnStartElement(sender,locator,namespaceURI,tagName,attributes);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.startElement(sender,locator,namespaceURI,tagName,attributes);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                                  prefix,
                                                  uri: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnStartPrefixMapping) then FOnStartPrefixMapping(sender,locator,prefix,uri);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.startPrefixMapping(sender,locator,prefix,uri);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              version,
                                              encDl,
                                              sdDl: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnXmlDeclaration) then FOnXmlDeclaration(sender,locator,version,encDl,sdDl);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.xmlDeclaration(sender,locator,version,encDl,sdDl);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.attributeDefinition(const sender: TXmlCustomProcessorAgent;
                                             const locator: TdomStandardLocator;
                                                   name,
                                                   attType,
                                                   bracket,
                                                   defaultDecl,
                                                   attValue: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnAttributeDefinition) then FOnAttributeDefinition(sender,locator,name,attType,bracket,defaultDecl,attValue);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.attributeDefinition(sender,locator,name,attType,bracket,defaultDecl,attValue);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.conditionalSection(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                                  includeStmt,
                                                  data: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnConditionalSection) then FOnConditionalSection(sender,locator,includeStmt,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.conditionalSection(sender,locator,includeStmt,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.DTDcomment(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator;
                                          data: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnDtdComment) then FOnDtdComment(sender,locator,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.DTDcomment(sender,locator,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.DTDprocessingInstruction(const sender: TXmlCustomProcessorAgent;
                                                  const locator: TdomStandardLocator;
                                                        targ,
                                                        data : wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnDtdProcessingInstruction) then FOnDtdProcessingInstruction(sender,locator,targ,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.DTDprocessingInstruction(sender,locator,targ,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.elementTypeDeclaration(const sender: TXmlCustomProcessorAgent;
                                                const locator: TdomStandardLocator;
                                                      name,
                                                      data: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnElementTypeDeclaration) then FOnElementTypeDeclaration(sender,locator,name,data);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.elementTypeDeclaration(sender,locator,name,data);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.endAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                                   const locator: TdomStandardLocator): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnEndAttListDeclaration) then FOnEndAttListDeclaration(sender,locator);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.endAttListDeclaration(sender,locator);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.endDtd(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnEndDtd) then FOnEndDtd(sender,locator);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.endDtd(sender,locator);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.entityDeclaration(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                                 name,
                                                 entityValue,
                                                 pubId,
                                                 sysId,
                                                 notaName: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnEntityDeclaration) then FOnEntityDeclaration(sender,locator,name,entityValue,pubId,sysId,notaName);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.entityDeclaration(sender,locator,name,entityValue,pubId,sysId,notaName);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.notationDeclaration(const sender: TXmlCustomProcessorAgent;
                                             const locator: TdomStandardLocator;
                                                   name,
                                                   pubId,
                                                   sysId: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnNotationDeclaration) then FOnNotationDeclaration(sender,locator,name,pubId,sysId);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.notationDeclaration(sender,locator,name,pubId,sysId);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.parameterEntityDeclaration(const sender: TXmlCustomProcessorAgent;
                                                    const locator: TdomStandardLocator;
                                                          name,
                                                          entityValue,
                                                          pubId,
                                                          sysId: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnParameterEntityDeclaration) then FOnParameterEntityDeclaration(sender,locator,name,entityValue,pubId,sysId);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.parameterEntityDeclaration(sender,locator,name,entityValue,pubId,sysId);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.parameterEntityRef(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                                  name: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnParameterEntityRef) then FOnParameterEntityRef(sender,locator,name);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.parameterEntityRef(sender,locator,name);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.startAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                       name: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnStartAttListDeclaration) then FOnStartAttListDeclaration(sender,locator,name);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.startAttListDeclaration(sender,locator,name);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.startDtd(const sender: TXmlCustomProcessorAgent;
                                  const locator: TdomStandardLocator;
                                        pubId,
                                        sysId: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnStartDtd) then FOnStartDtd(sender,pubId,sysId);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.startDtd(sender,locator,pubId,sysId);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;

function TXmlDistributor.textDeclaration(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator;
                                               version,
                                               encDl: wideString): TXmlParserError;
var
  i: integer;
begin
  if assigned(FOnTextDeclaration) then FOnTextDeclaration(sender,locator,version,encDl);
  result:= nil;
  with nextHandlers do begin
    for i:= 0 to pred(count) do begin
      if not assigned(items[i].XmlHandler) then continue;
      result:= items[i].XmlHandler.textDeclaration(sender,locator,version,encDl);
      if assigned(result) then break;
    end;
  end;
  SendErrorNotification(sender,result);
end;



// +++++++++++++++++++++++++++ TXmlCustomDTDHandler +++++++++++++++++++++++++++
function TXmlCustomDtdHandler.parserErrorFactory(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                 const e: EParserException;
                                                 const code: wideString): TXmlParserError;
var
  sln,scn,ln,cn: integer;
  pubId,sysId: wideString;
begin
  if assigned(locator) then begin
    with locator do begin
      sln:= startLineNumber;
      scn:= startColumnNumber;
      ln:= lineNumber;
      cn:= columnNumber;
      pubId:= publicId;
      sysId:= systemId;
    end;
  end else begin
    sln:= 0;
    scn:= 0;
    ln:= 0;
    cn:= 0;
    pubId:= '';
    sysId:= '';
  end;
  result:= TXmlParserError.create(e,sln,scn,ln,cn,pubId,sysId,code);
end;

function TXmlCustomDtdHandler.comment(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            data: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.CDATA(const sender: TXmlCustomProcessorAgent;
                                    const locator: TdomStandardLocator;
                                          data: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.charRef(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            data: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.doctype(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            name,
                                            pubId,
                                            sysId,
                                            data: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.endDocument(const sender: TXmlCustomProcessorAgent;
                                          const locator: TdomStandardLocator): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.endElement(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator;
                                               namespaceURI,
                                               tagName: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                               const locator: TdomStandardLocator;
                                                     prefix: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.entityRef(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              name: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.PCDATA(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           data: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.processingInstruction(const sender: TXmlCustomProcessorAgent;
                                                    const locator: TdomStandardLocator;
                                                          targ,
                                                          data : wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.skippedEntity(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                                  name: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.startDocument(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                                  defaultRoot: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.startElement(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                                 namespaceURI,
                                                 tagName: wideString;
                                                 attributes: TdomNameValueList): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                       prefix,
                                                       uri: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomDtdHandler.xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                             const locator: TdomStandardLocator;
                                                   version,
                                                   encDl,
                                                   sdDl: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;



// +++++++++++++++++++++++++ TXmlCustomContentHandler +++++++++++++++++++++++++
function TXmlCustomContentHandler.parserErrorFactory(const sender: TXmlCustomProcessorAgent;
                                                     const locator: TdomStandardLocator;
                                                     const e: EParserException;
                                                     const code: wideString): TXmlParserError;
var
  sln,scn,ln,cn: integer;
  pubId,sysId: wideString;
begin
  if assigned(locator) then begin
    with locator do begin
      sln:= startLineNumber;
      scn:= startColumnNumber;
      ln:= lineNumber;
      cn:= columnNumber;
      pubId:= publicId;
      sysId:= systemId;
    end;
  end else begin
    sln:= 0;
    scn:= 0;
    ln:= 0;
    cn:= 0;
    pubId:= '';
    sysId:= '';
  end;
  result:= TXmlParserError.create(e,sln,scn,ln,cn,pubId,sysId,code);
end;

function TXmlCustomContentHandler.attributeDefinition(const sender: TXmlCustomProcessorAgent;
                                                      const locator: TdomStandardLocator;
                                                            name,
                                                            attType,
                                                            bracket,
                                                            defaultDecl,
                                                            attValue: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.conditionalSection(const sender: TXmlCustomProcessorAgent;
                                                     const locator: TdomStandardLocator;
                                                           includeStmt,
                                                           data: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.DTDcomment(const sender: TXmlCustomProcessorAgent;
                                             const locator: TdomStandardLocator;
                                                   data: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.DTDprocessingInstruction(const sender: TXmlCustomProcessorAgent;
                                                           const locator: TdomStandardLocator;
                                                                 targ,
                                                                 data : wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.elementTypeDeclaration(const sender: TXmlCustomProcessorAgent;
                                                         const locator: TdomStandardLocator;
                                                               name,
                                                               data: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.endAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                                        const locator: TdomStandardLocator): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.endDtd(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator): TXmlParserError;
begin
  result:= parserErrorFactory(sender,nil,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.entityDeclaration(const sender: TXmlCustomProcessorAgent;
                                                    const locator: TdomStandardLocator;
                                                          name,
                                                          entityValue,
                                                          pubId,
                                                          sysId,
                                                          notaName: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.notationDeclaration(const sender: TXmlCustomProcessorAgent;
                                                      const locator: TdomStandardLocator;
                                                            name,
                                                            pubId,
                                                            sysId: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.parameterEntityDeclaration(const sender: TXmlCustomProcessorAgent;
                                                             const locator: TdomStandardLocator;
                                                                   name,
                                                                   entityValue,
                                                                   pubId,
                                                                   sysId: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.parameterEntityRef(const sender: TXmlCustomProcessorAgent;
                                                     const locator: TdomStandardLocator;
                                                           name: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.startAttListDeclaration(const sender: TXmlCustomProcessorAgent;
                                                          const locator: TdomStandardLocator;
                                                                name: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.startDtd(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                                 pubId,
                                                 sysId: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,nil,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;

function TXmlCustomContentHandler.textDeclaration(const sender: TXmlCustomProcessorAgent;
                                                  const locator: TdomStandardLocator;
                                                        version,
                                                        encDl: wideString): TXmlParserError;
begin
  result:= parserErrorFactory(sender,locator,
                              EInternalParserException.create('Internal parser exception.'),
                              '');
end;


// +++++++++++++++++++++++++ TXmlCustomReader ++++++++++++++++++++++++++
procedure TXmlCustomReader.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation = opRemove) and (AComponent = FNextHandler)
    then FNextHandler:= nil;
end;

procedure TXmlCustomReader.SendErrorNotification(const sender: TXmlCustomProcessorAgent;
                                                   var e: TXmlParserError);
begin
  if not assigned(e) then exit;
  case e.errorType of
    xetFatalError: fatalError(sender,e);
    xetError: error(sender,e);
    xetWarning: warning(sender,e);
  end;
end;

function TXmlCustomReader.parserErrorFactory(const sender: TXmlCustomProcessorAgent;
                                             const locator: TdomStandardLocator;
                                             const e: EParserException;
                                             const code: wideString): TXmlParserError;
var
  sln,scn,ln,cn: integer;
  pubId,sysId: wideString;
begin
  if assigned(locator) then begin
    with locator do begin
      sln:= startLineNumber;
      scn:= startColumnNumber;
      ln:= lineNumber;
      cn:= columnNumber;
      pubId:= publicId;
      sysId:= systemId;
    end;
  end else begin
    sln:= 0;
    scn:= 0;
    ln:= 0;
    cn:= 0;
    pubId:= '';
    sysId:= '';
  end;
  result:= TXmlParserError.create(e,sln,scn,ln,cn,pubId,sysId,code);
end;

procedure TXmlCustomReader.error(const sender: TXmlCustomProcessorAgent;
                                   var e: TXmlParserError);
begin
  if assigned(FOnError) then FOnError(sender,e);
  // By default return nil.
  e.free;
  e:= nil;
end;

procedure TXmlCustomReader.fatalError(const sender: TXmlCustomProcessorAgent;
                                        var e: TXmlParserError);
begin
  if assigned(FOnFatalError) then FOnFatalError(sender,e);
  // By default return the exception, i.e. do nothing.
end;

procedure TXmlCustomReader.warning(const sender: TXmlCustomProcessorAgent;
                                     var e: TXmlParserError);
begin
  if assigned(FOnWarning) then FOnWarning(sender,e);
  // By default return nil.
  e.free;
  e:= nil;
end;



// +++++++++++++++++++++++ TXmlWFTestContentHandler +++++++++++++++++++++++
constructor TXmlWFTestContentHandler.create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FIsActive:= false;
  FDoctypeFound:= false;
  FRootFound:= false;
  FXMLDeclarationAllowed:= true;
  FTagStack:= TStringList.Create;
end;

destructor TXmlWFTestContentHandler.destroy;
begin
  FTagStack.free;
  inherited destroy;
end;

function TXmlWFTestContentHandler.CDATA(const sender: TXmlCustomProcessorAgent;
                                        const locator: TdomStandardLocator;
                                              data: wideString): TXmlParserError;
begin
  if assigned(FOnCDATA) then FOnCDATA(sender,locator,data);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  if not IsXmlCData(data)
    then result:= parserErrorFactory(sender,locator,
                                     EParserInvalidCDATASection_Err.create('Invalid CDATA section error.'),
                                     data);
  if not FRootFound
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserNotInRoot_Err.create('Not in root error.'),
                                       data);

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.CDATA(sender,locator,data);
end;

function TXmlWFTestContentHandler.charRef(const sender: TXmlCustomProcessorAgent;
                                          const locator: TdomStandardLocator;
                                                data: wideString): TXmlParserError;
begin
  if assigned(FOnCharRef) then FOnCharRef(sender,locator,data);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  try
    XmlCharRefToStr(data);
  except
    on EConvertError do
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidCharRef_Err.create('Invalid character reference error.'),
                                  data);
  end;
  if not FRootFound
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserNotInRoot_Err.create('Not in root error.'),
                                       data);

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.charRef(sender,locator,data);
end;

function TXmlWFTestContentHandler.comment(const sender: TXmlCustomProcessorAgent;
                                          const locator: TdomStandardLocator;
                                                data: wideString): TXmlParserError;
var
  dataLength: integer;
begin
  if assigned(FOnComment) then FOnComment(sender,locator,data);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  if pos('--',data) > 0
    then result:= parserErrorFactory(sender,locator,
                                     EParserInvalidComment_Err.create('Invalid comment error.'),
                                     '--');
  dataLength:= length(data);
  if dataLength > 0
    then if WideChar(data[dataLength]) = '-'
      then if not assigned(result)
        then result:= parserErrorFactory(sender,locator,
                                         EParserInvalidComment_Err.create('Invalid comment error.'),
                                         '-');
  if not IsXmlChars(data)
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserInvalidCharacter_Err.create('Invalid character error.'),
                                       data);

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.comment(sender,locator,data);
end;

function TXmlWFTestContentHandler.doctype(const sender: TXmlCustomProcessorAgent;
                                          const locator: TdomStandardLocator;
                                                name,
                                                pubId,
                                                sysId,
                                                data: wideString): TXmlParserError;
const
  SQ: wideString  = #$0027;
  DQ: wideString  = '"';
begin
  if assigned(FOnDoctype) then FOnDoctype(sender,locator,name,pubId,sysId,data);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  if FDoctypeFound
    then result:= parserErrorFactory(sender,locator,
                                     EParserDoubleDoctype_Err.create('Double doctype declaration error.'),
                                     data);
  FDoctypeFound:= true;
  if FRootFound
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserWrongOrder_Err.create('Wrong order declaration error.'),
                                       data);
  if not isXmlName(name)
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserInvalidDoctype_Err.create('Invalid doctype declaration error.'),
                                       data);
  if not ( IsXmlPubidLiteral(concat(DQ,pubId,DQ)) or IsXmlPubidLiteral(concat(SQ,pubId,SQ)) )
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserInvalidDoctype_Err.create('Invalid doctype declaration error.'),
                                       data);
  if not ( IsXmlSystemLiteral(concat(DQ,sysId,DQ)) or IsXmlPubidLiteral(concat(SQ,sysId,SQ)) )
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserInvalidDoctype_Err.create('Invalid doctype declaration error.'),
                                       data);

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.doctype(sender,locator,name,pubId,sysId,data);
end;

function TXmlWFTestContentHandler.endDocument(const sender: TXmlCustomProcessorAgent;
                                              const locator: TdomStandardLocator): TXmlParserError;
begin
  if assigned(FOnEndDocument) then FOnEndDocument(sender,locator);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  FIsActive:= false;
  result:= nil;

  if FTagStack.Count > 0
    then result:= parserErrorFactory(sender,locator,
                                     EParserMissingEndTag_Err.create('Missing end tag error.'),
                                     '');

  if not FRootFound
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserRootNotFound_Err.create('Root not found error.'),
                                       '');

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.endDocument(sender,locator);
end;

function TXmlWFTestContentHandler.endElement(const sender: TXmlCustomProcessorAgent;
                                             const locator: TdomStandardLocator;
                                                   namespaceURI,
                                                   tagName: wideString): TXmlParserError;
var
  lastItemIndex: integer;
begin
  if assigned(FOnEndElement) then FOnEndElement(sender,locator,namespaceURI,tagName);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  if not IsXmlName(tagName)
    then result:= parserErrorFactory(sender,locator,
                                     EParserInvalidElementName_Err.create('Invalid element name error.'),
                                     tagname);
  if not assigned(result) then begin
    lastItemIndex:= pred(FTagStack.Count);
    if lastItemIndex = -1 then begin
      result:= parserErrorFactory(sender,locator,
                                  EParserMissingStartTag_Err.create('Missing start tag error.'),
                                  tagname);
    end else begin
      if FTagStack.Strings[lastItemIndex] = tagname
        then FTagStack.Delete(lastItemIndex)
        else result:= parserErrorFactory(sender,locator,
                                         EParserMissingStartTag_Err.create('Missing start tag error.'),
                                         tagname);
    end;
  end;

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.endElement(sender,locator,namespaceURI,tagName);
end;

function TXmlWFTestContentHandler.endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                                   const locator: TdomStandardLocator;
                                                         prefix: wideString): TXmlParserError;
begin
  if assigned(FOnEndPrefixMapping) then FOnEndPrefixMapping(sender,locator,prefix);
  if assigned(nextHandler)
    then result:= nextHandler.endPrefixMapping(sender,locator,prefix)
    else result:= nil;
end;

function TXmlWFTestContentHandler.entityRef(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                                  name: wideString): TXmlParserError;
begin
  if assigned(FOnEntityRef) then FOnEntityRef(sender,locator,name);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  if not IsXmlName(name)
    then result:= parserErrorFactory(sender,locator,
                                     EParserInvalidEntityName_Err.create('Invalid entity name error.'),
                                     name);
  if not FRootFound
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserNotInRoot_Err.create('Not in root error.'),
                                       concat('&',name,';'));

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.entityRef(sender,locator,name);
end;

function TXmlWFTestContentHandler.PCDATA(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator;
                                               data: wideString): TXmlParserError;
begin
  if assigned(FOnPCDATA) then FOnPCDATA(sender,locator,data);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  if not IsXmlCharData(data)
    then result:= parserErrorFactory(sender,locator,
                                     EParserInvalidCharacter_Err.create('Invalid character error.'),
                                     data);
  if not FRootFound
    then if not IsXmlS(data)
      then if not assigned(result)
        then result:= parserErrorFactory(sender,locator,
                                         EParserNotInRoot_Err.create('Not in root error.'),
                                         data);

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.PCDATA(sender,locator,data);
end;

function TXmlWFTestContentHandler.processingInstruction(const sender: TXmlCustomProcessorAgent;
                                                        const locator: TdomStandardLocator;
                                                              targ,
                                                              data : wideString): TXmlParserError;
begin
  if assigned(FOnProcessingInstruction) then FOnProcessingInstruction(sender,locator,targ,data);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  if not IsXmlPITarget(targ)
    then result:= parserErrorFactory(sender,locator,
                                     EParserInvalidProcessingInstruction_Err.create('Invalid processing instruction error.'),
                                     targ);
  if pos('?>',data) > 0
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserInvalidProcessingInstruction_Err.create('Invalid processing instruction error.'),
                                       '?>');
  if not IsXmlChars(data)
    then if not assigned(result)
        then result:= parserErrorFactory(sender,locator,
                                         EParserInvalidCharacter_Err.create('Invalid character error.'),
                                         data);

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.processingInstruction(sender,locator,targ,data);
end;

function TXmlWFTestContentHandler.skippedEntity(const sender: TXmlCustomProcessorAgent;
                                                const locator: TdomStandardLocator;
                                                      name: wideString): TXmlParserError;
begin
  if assigned(FOnSkippedEntity) then FOnSkippedEntity(sender,locator,name);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.skippedEntity(sender,locator,name);
end;

function TXmlWFTestContentHandler.startDocument(const sender: TXmlCustomProcessorAgent;
                                                const locator: TdomStandardLocator;
                                                      defaultRoot: wideString): TXmlParserError;
begin
  if assigned(FOnStartDocument) then FOnStartDocument(sender,locator,defaultRoot);
  if FIsActive then EParserException.Create('TXmlWFTestContentHandler is active.');
  result:= nil;
  FTagStack.Clear;
  FIsActive:= true;
  FDoctypeFound:= false;
  FRootFound:= false;
  FXMLDeclarationAllowed:= true;
  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.startDocument(sender,locator,defaultRoot);
end;

function TXmlWFTestContentHandler.startElement(const sender: TXmlCustomProcessorAgent;
                                               const locator: TdomStandardLocator;
                                                     namespaceURI,
                                                     tagName: wideString;
                                                     attributes: TdomNameValueList): TXmlParserError;
var
  i,j: integer;
  name,value,text,characRef,v: wideString;
  isEntity: boolean;
begin
  if assigned(FOnStartElement) then FOnStartElement(sender,locator,namespaceURI,tagName,attributes);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;
  FXMLDeclarationAllowed:= false;

  if not IsXmlName(tagName)
    then result:= parserErrorFactory(sender,locator,
                                     EParserInvalidElementName_Err.create('Invalid element name error.'),
                                     tagname);
  if FRootFound
    then if FTagStack.Count = 0
      then if not assigned(result)
        then result:= parserErrorFactory(sender,locator,
                                         EParserDoubleRootElement_Err.create('Double root element error.'),
                                         tagname);
  FRootFound:= true;
  FTagStack.Add(tagname);

  if not assigned(result) then begin
    for i:= 0 to pred(attributes.length) do begin
      value:= attributes.values[i];
      name:= attributes.names[i];

      if attributes.indexOfName(name) <> i then begin
        result:= parserErrorFactory(sender,locator,
                                    EParserDoubleAttributeName_Err.create('Double attribute name error.'),
                                    name);
        break;
      end;

      if not IsXmlName(name) then begin
        result:= parserErrorFactory(sender,locator,
                                    EParserInvalidAttributeName_Err.create('Invalid attribute name error.'),
                                    value);
        break;
      end;
      if pos('&',value) = 0 then begin
        if not IsXmlCharData(value) then begin
          result:= parserErrorFactory(sender,locator,
                                      EParserInvalidAttributeValue_Err.create('Invalid attribute value error.'),
                                      value);
          break;
        end;
      end else begin
        isEntity:= false;
        text:= '';
        for j:= 1 to Length(value) do begin
          if IsEntity then begin
            if value[j] = ';' then begin
              if text[1] = '#' then begin // CharRef
                try
                  CharacRef:= concat(wideString('&'),text,wideString(';'));
                  v:= XmlCharRefToStr(CharacRef);
                except
                  on EConvertError do begin
                    result:= parserErrorFactory(sender,locator,
                                                EParserInvalidCharRef_Err.create('Invalid character reference error.'),
                                                CharacRef);
                    break;
                  end;
                end; {try}
              end else begin  // EntityRef
                if not IsXmlName(text) then begin
                  result:= parserErrorFactory(sender,locator,
                                              EParserInvalidEntityName_Err.create('Invalid entity name error.'),
                                              text);
                  break;
                end;
              end;
              text:= '';
              IsEntity:= false;
            end else Text:= concat(text,wideString(value[j]));
          end else begin
            if value[j] = '&' then begin
              IsEntity:= true;
            end else if (value[j] = '<') or not IsXmlChar(value[j]) then begin
              result:= parserErrorFactory(sender,locator,
                                          EParserInvalidAttributeValue_Err.create('Invalid attribute value error.'),
                                          value);
              break;
            end;
          end; {if ...}
        end; {for ...}
        // invalid attribute value?
        if IsEntity
          then if not assigned(result)
            then result:= parserErrorFactory(sender,locator,
                                             EParserInvalidAttributeValue_Err.create('Invalid attribute value error.'),
                                             value);
      end; {if ...}
    end;
  end; {if not assigned(result) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.startElement(sender,locator,namespaceURI,tagName,attributes);
end;

function TXmlWFTestContentHandler.startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                                     const locator: TdomStandardLocator;
                                                           prefix,
                                                           uri: wideString): TXmlParserError;
begin
  if assigned(FOnStartPrefixMapping) then FOnStartPrefixMapping(sender,locator,prefix,uri);
  if assigned(nextHandler)
    then result:= nextHandler.startPrefixMapping(sender,locator,prefix,uri)
    else result:= nil;
end;

function TXmlWFTestContentHandler.xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                       version,
                                                       encDl,
                                                       sdDl: wideString): TXmlParserError;
begin
  if assigned(FOnXmlDeclaration) then FOnXmlDeclaration(sender,locator,version,encDl,sdDl);
  if not FIsActive then EParserException.Create('TXmlWFTestContentHandler not active.');
  result:= nil;

  if not FXMLDeclarationAllowed
    then result:= parserErrorFactory(sender,locator,
                                     EParserWrongOrder_Err.create('Wrong order error.'),
                                     '');
  FXMLDeclarationAllowed:= false;
  if (not (IsXmlEncName(EncDl) or (EncDl = ''))) or
     (not ((SdDl = 'yes') or (SdDl = 'no') or (SdDl = ''))) or
     (not IsXmlVersionNum(Version))
    then if not assigned(result)
      then result:= parserErrorFactory(sender,locator,
                                       EParserInvalidXmlDeclaration_Err.create('Invalid xml-declaration error.'),
                                       '');

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.xmlDeclaration(sender,locator,version,encDl,sdDl);
end;



// ++++++++++++++++++++++++++++ TXmlDocBuilder ++++++++++++++++++++++++++++
constructor TXmlDocBuilder.create(AOwner: TComponent);
begin
  inherited create(AOwner);
  FRefNode:= nil;
  FBuildNamespaceTree:= true;
  FPrefixUriList:= TdomNameValueList.create;
  FPreserveWhitespace := true;
end;

destructor TXmlDocBuilder.destroy;
begin
  FPrefixUriList.free;
  inherited destroy;
end;

function TXmlDocBuilder.CDATA(const sender: TXmlCustomProcessorAgent;
                              const locator: TdomStandardLocator;
                                    data: wideString): TXmlParserError;
var
  newCData: TdomCDATASection;
begin
  if assigned(FOnCDATA) then FOnCDATA(sender,locator,data);
  result:= nil;
  if assigned(FRefNode) then begin
    try
      newCData:= FRefNode.OwnerDocument.CreateCDATASection(data);
      try
        FRefNode.appendChild(newCData);
      except
        if assigned(newCData.ParentNode)
          then newCData.ParentNode.RemoveChild(newCData);
        FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newCData));
        raise;
      end; {try ...}
    except
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidCDATASection_Err.create('Invalid CDATA section error.'),
                                  data);
    end; {try ...}
  end; {if assigned(FRefNode) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.CDATA(sender,locator,data);
end;

function TXmlDocBuilder.charRef(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      data: wideString): TXmlParserError;
var
  newText: TdomText;
  previousNode: TdomNode;
  value: wideString;
  previousNodeIsText: boolean;
begin
  if assigned(FOnCharRef) then FOnCharRef(sender,locator,data);
  result:= nil;
  if assigned(FRefNode) then begin

    try
      value:= XmlCharRefToStr(data);
    except
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidCharRef_Err.create('Invalid character reference error.'),
                                  data);
    end;

    if not assigned(result) then begin
      previousNode:= FRefNode.LastChild;
      if assigned(previousNode) then begin
        if (previousNode.NodeType = ntText_Node)
          then previousNodeIsText:= true
          else previousNodeIsText:= false;
      end else previousNodeIsText:= false;

      if previousNodeIsText
        then (previousNode as TdomText).appendData(value)
        else begin
          try
            newText:= FRefNode.OwnerDocument.CreateTextNode(value);
            try
              FRefNode.appendChild(newText);
            except
              if assigned(newText.ParentNode)
                then newText.ParentNode.RemoveChild(newText);
              FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newText));
              raise;
            end; {try ...}
          except
            result:= parserErrorFactory(sender,locator,
                                        EParserInvalidCharRef_Err.create('Invalid character reference error.'),
                                        data);
          end; {try ...}
        end;
    end; {if not assgined ...}
  end; {if assigned(FRefNode) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.charRef(sender,locator,data);
end;

function TXmlDocBuilder.comment(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      data: wideString): TXmlParserError;
var
  newComment: TdomComment;
begin
  if assigned(FOnComment) then FOnComment(sender,locator,data);
  result:= nil;
  if assigned(FRefNode) then begin
    try
      newComment:= FRefNode.OwnerDocument.CreateComment(data);
      try
        FRefNode.appendChild(newComment);
      except
        if assigned(newComment.ParentNode)
          then newComment.ParentNode.RemoveChild(newComment);
        FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newComment));
        raise;
      end; {try ...}
    except
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidComment_Err.create('Invalid comment error.'),
                                  data);
    end; {try ...}
  end; {if assigned(FRefNode) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.comment(sender,locator,data);
end;

function TXmlDocBuilder.doctype(const sender: TXmlCustomProcessorAgent;
                                const locator: TdomStandardLocator;
                                      name,
                                      pubId,
                                      sysId,
                                      data: wideString): TXmlParserError;
var
  newDocType: TdomDocumentType;
begin
  if assigned(FOnDoctype) then FOnDoctype(sender,locator,name,pubId,sysId,data);
  result:= nil;
  if assigned(FRefNode) then begin
    try
      newDocType:= FRefNode.OwnerDocument.CreateDocumentType(name,pubId,sysId,data);
      try
        FRefNode.appendChild(newDocType);
      except
        if assigned(newDocType.ParentNode)
          then newDocType.ParentNode.RemoveChild(newDocType);
        FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newDocType));
        raise;
      end; {try ...}
    except
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidDoctype_Err.create('Invalid doctype declaration error.'),
                                  data);
    end; {try ...}
  end; {if assigned(FRefNode) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.doctype(sender,locator,name,pubId,sysId,data);
end;

function TXmlDocBuilder.endDocument(const sender: TXmlCustomProcessorAgent;
                                              const locator: TdomStandardLocator): TXmlParserError;
begin
  if assigned(FOnEndDocument) then FOnEndDocument(sender,locator);
  // notifications of endDocument are being ignored.
  result:= nil;
  if assigned(nextHandler)
    then result:= nextHandler.endDocument(sender,locator);
end;

function TXmlDocBuilder.endElement(const sender: TXmlCustomProcessorAgent;
                                   const locator: TdomStandardLocator;
                                         namespaceURI,
                                         tagName: wideString): TXmlParserError;
begin
  if assigned(FOnEndElement) then FOnEndElement(sender,locator,namespaceURI,tagName);
  result:= nil;
  if assigned(FRefNode) then begin
    // xxx Evaluate 'FBuildNamespaceTree' and 'namespaceURI' here, too?
    if not ( (FRefNode.nodeType = ntElement_Node) and (tagName = FRefNode.NodeName) )
      then result:= parserErrorFactory(sender,locator,
                                       EParserMissingStartTag_Err.create('Missing start tag error.'),
                                       tagname)
      else FRefNode:= FRefNode.ParentNode;
  end;

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.endElement(sender,locator,namespaceURI,tagName);
end;

function TXmlDocBuilder.endPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator;
                                               prefix: wideString): TXmlParserError;
var
  l: integer;
begin
  if assigned(FOnEndPrefixMapping) then FOnEndPrefixMapping(sender,locator,prefix);
  l:= pred(FPrefixUriList.length);
  if l = -1 then begin
    result:= parserErrorFactory(sender,locator,
                                EParserWrongPrefixMappingNesting_Err.create('Wrong prefix mapping nesting error.'),
                                prefix);
    exit;
  end;
  if FPrefixUriList.names[l] <> prefix then begin
    result:= parserErrorFactory(sender,locator,
                                EParserWrongPrefixMappingNesting_Err.create('Wrong prefix mapping nesting error.'),
                                prefix);
    exit;
  end;
  FPrefixUriList.delete(l);
  if assigned(nextHandler)
    then result:= nextHandler.endPrefixMapping(sender,locator,prefix)
    else result:= nil;
end;

function TXmlDocBuilder.entityRef(const sender: TXmlCustomProcessorAgent;
                                  const locator: TdomStandardLocator;
                                        name: wideString): TXmlParserError;
var
  newEntityRef: TdomEntityReference;
begin
  if assigned(FOnEntityRef) then FOnEntityRef(sender,locator,name);
  result:= nil;
  if assigned(FRefNode) then begin
    try
      newEntityRef:= FRefNode.OwnerDocument.CreateEntityReference(name);
      try
        FRefNode.appendChild(newEntityRef);
      except
        if assigned(newEntityRef.ParentNode)
          then newEntityRef.ParentNode.RemoveChild(newEntityRef);
        FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newEntityRef));
        raise;
      end; {try ...}
    except
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidEntityName_Err.create('Invalid entity name error.'),
                                  name);
    end; {try ...}
  end; {if assigned(FRefNode) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.entityRef(sender,locator,name);
end;

function TXmlDocBuilder.PCDATA(const sender: TXmlCustomProcessorAgent;
                               const locator: TdomStandardLocator;
                                     data: wideString): TXmlParserError;
var
  newPcdata: TdomText;
begin
  if assigned(FOnPCDATA) then FOnPCDATA(sender,locator,data);
  result:= nil;
  if assigned(FRefNode) then begin

    if (FRefNode.NodeType = ntDocument_Node) then begin
      if not IsXmlS(data)
        then result:= parserErrorFactory(sender,locator,
                                         EParserNotInRoot_Err.create('Not in root error.'),
                                         data);
    // September 21, 2001 - Borland Change - Added property to automatically strip formatting whitespace
    end else if preserveWhitespace or (Trim(data) <> '') then begin
      if assigned(FRefNode.LastChild) and (FRefNode.LastChild.NodeType = ntText_Node)
        then (FRefNode.LastChild as TdomText).appendData(data)
        else begin
          try
            newPcdata:= FRefNode.OwnerDocument.CreateTextNode(data);
            try
              FRefNode.appendChild(newPcdata);
            except
              if assigned(newPcdata.ParentNode)
                then newPcdata.ParentNode.RemoveChild(newPcdata);
              FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newPcdata));
              raise;
            end; {try ...}
          except
            result:= parserErrorFactory(sender,locator,
                                        EParserInvalidCharacter_Err.create('Invalid character error.'),
                                        data);
          end; {try ...}
        end;
    end; {if (FRefNode.NodeType = ntDocument_Node) then ... else ...}
  end; {if assigned(FRefNode) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.PCDATA(sender,locator,data);
end;

function TXmlDocBuilder.processingInstruction(const sender: TXmlCustomProcessorAgent;
                                              const locator: TdomStandardLocator;
                                                    targ,
                                                    data : wideString): TXmlParserError;
var
  newPI: TdomProcessingInstruction;
begin
  if assigned(FOnProcessingInstruction) then FOnProcessingInstruction(sender,locator,targ,data);
  result:= nil;
  if assigned(FRefNode) then begin
    try
      newPI:= FRefNode.OwnerDocument.CreateProcessingInstruction(targ,data);
      try
        FRefNode.appendChild(newPI);
      except
        if assigned(newPI.ParentNode)
          then newPI.ParentNode.RemoveChild(newPI);
        FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newPI));
        raise;
      end;
    except
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidProcessingInstruction_Err.create('Invalid processing instruction error.'),
                                  targ);
    end;
  end; {if assigned(FRefNode) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.processingInstruction(sender,locator,targ,data);
end;

function TXmlDocBuilder.skippedEntity(const sender: TXmlCustomProcessorAgent;
                                      const locator: TdomStandardLocator;
                                            name: wideString): TXmlParserError;
begin
  if assigned(FOnSkippedEntity) then FOnSkippedEntity(sender,locator,name);
  // notifications of skippedEntity are being ignored.
  result:= nil;
  if assigned(nextHandler)
    then result:= nextHandler.skippedEntity(sender,locator,name);
end;

function TXmlDocBuilder.startDocument(const sender: TXmlCustomProcessorAgent;
                                                const locator: TdomStandardLocator;
                                                      defaultRoot: wideString): TXmlParserError;
begin
  if assigned(FOnStartDocument) then FOnStartDocument(sender,locator,defaultRoot);
  FPrefixUriList.clear;
  result:= nil;
  if assigned(nextHandler)
    then result:= nextHandler.startDocument(sender,locator,defaultRoot);
end;

function TXmlDocBuilder.startElement(const sender: TXmlCustomProcessorAgent;
                                     const locator: TdomStandardLocator;
                                           namespaceURI,
                                           tagName: wideString;
                                           attributes: TdomNameValueList): TXmlParserError;
var
  newElement: TdomElement;
  i,j: integer;
  pfx,elementNsUri,AttrNsUri,name,value,text,characRef,v: wideString;
  Attri: TdomAttr;
  isEntity,pfxFound: boolean;
begin
  if assigned(FOnStartElement) then FOnStartElement(sender,locator,namespaceURI,tagName,attributes);
  result:= nil;
  pfx:= '';
  elementNsUri:= '';
  if FBuildNamespaceTree then begin
    if not isXmlQName(tagName) then begin
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidQualifiedName_Err.create('Invalid qualified name error.'),
                                  tagname);
      exit;
    end;
    pfx:= XMLExtractPrefix(tagName);
    pfxFound:= false;
    with FPrefixUriList do begin
      for i:= pred(FPrefixUriList.length) downto 0 do
        if FPrefixUriList.names[i] = pfx then begin
          elementNsUri:= FPrefixUriList.values[i];
          pfxFound:= true;
          break;
        end;
    end; {with ...}
    if not pfxFound
      then if pfx <> '' then begin
        result:= parserErrorFactory(sender,locator,
                                    EParserNamespaceURINotFound_Err.create('Namespace URI not found error.'),
                                    tagname);
        exit;
      end;
  end; {if FBuildNamespaceTree ...}

  if assigned(FRefNode) then begin
    try
      if FBuildNamespaceTree
        then newElement:= FRefNode.OwnerDocument.CreateElementNS(elementNsUri,tagName)
        else newElement:= FRefNode.OwnerDocument.CreateElement(tagName);
    except
      raise EInternalParserException.create('Internal Parser Exception in TXmlDocBuilder.startElement');
    end;

    // Compute attributes:
    try
      for i:= 0 to pred(attributes.length) do begin
        value:= attributes.values[i];
        name:= attributes.names[i];
        pfx:= '';
        attrNsUri:= '';

        if FBuildNamespaceTree then begin
          if not isXmlQName(name) then begin
            result:= parserErrorFactory(sender,locator,
                                        EParserInvalidQualifiedName_Err.create('Invalid qualified name error.'),
                                        name);
            exit;
          end;
          if name = 'xmlns' then begin
            pfx:= '';
            attrNsUri:= 'http://www.w3.org/2000/xmlns/';
          end else begin
            pfx:= XMLExtractPrefix(name);
            if pfx = '' then begin
              attrNsUri:= ''; // September 5, 2001 - Borland Fix - Use no namespace.
            end else if pfx = 'xmlns' then begin
              attrNsUri:= 'http://www.w3.org/2000/xmlns/';
            end else begin
              pfxFound:= false;
              with FPrefixUriList do begin
                for j:= pred(FPrefixUriList.length) downto 0 do begin
                  if FPrefixUriList.names[j] = pfx then begin
                    attrNsUri:= FPrefixUriList.values[j];
                    pfxFound:= true;
                    break;
                  end; {if ...}
                end; {for ...}
              end; {with ...}
              if not pfxFound then begin
                result:= parserErrorFactory(sender,locator,
                                            EParserNamespaceURINotFound_Err.create('Namespace URI not found error.'),
                                            name);
                exit;
              end; {if not pfxFound ...}
            end; {if pfx = '' ... else ...}
          end; {if name = 'xmlns' ...}
        end; {if FBuildNamespaceTree ...}

        if not IsXmlName(name) then
          raise EParserInvalidAttributeName_Err.create('Invalid attribute name error.');
        if pos('&',value) = 0 then begin
          if not IsXmlCharData(value)
            then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
          if FBuildNamespaceTree
            then newElement.setAttributeNS(attrNsUri,name,value)
            else newElement.setAttribute(name,value);
        end else begin
          if FBuildNamespaceTree then begin
            Attri:= newElement.OwnerDocument.CreateAttributeNS(attrNsUri,name);
            newElement.SetAttributeNodeNS(Attri);
          end else begin
            Attri:= newElement.OwnerDocument.CreateAttribute(name);
            newElement.SetAttributeNode(Attri);
          end;
          isEntity:= false;
          text:= '';
          for j:= 1 to Length(value) do begin
            if IsEntity then begin
              if value[j] = ';' then begin
                if text[1] = '#' then begin {CharRef}
                try
                  CharacRef:= concat(wideString('&'),text,wideString(';'));
                  v:= XmlCharRefToStr(CharacRef);
                  if assigned(Attri.LastChild) and (Attri.LastChild.NodeType = ntText_Node)
                    then (Attri.LastChild as TdomText).appendData(v)
                    else Attri.appendChild(newElement.OwnerDocument.CreateTextNode(v));
                except
                  on EConvertError do
                    raise EParserInvalidCharRef_Err.create('Invalid character reference error.');
                end; {try}
                end else begin
                  if not IsXmlName(text)
                    then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
                  Attri.appendChild(newElement.OwnerDocument.CreateEntityReference(text));
                end;
                text:= '';
                IsEntity:= false;
              end else Text:= concat(text,wideString(value[j]));
            end else begin
              if value[j] = '&' then begin
                if text <> '' then begin
                  // invalid attribute value?
                  if not IsXmlCharData(text)
                    then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
                  Attri.appendChild(newElement.OwnerDocument.CreateTextNode(text));
                end;
                text:= '';
                IsEntity:= true;
              end else Text:= concat(text,wideString(value[j]));
            end; {if ...}
          end; {for ...}
          // invalid attribute value?
          if IsEntity
            then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
          if text <> '' then Attri.appendChild(newElement.OwnerDocument.CreateTextNode(text));
        end; {if ...}
      end;
      FRefNode.appendChild(newElement);
    except
      on EParserInvalidAttributeName_Err do begin
        if assigned(newElement.ParentNode)
          then newElement.ParentNode.RemoveChild(newElement);
        FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newElement));
        result:= parserErrorFactory(sender,locator,
                                           EParserInvalidAttributeName_Err.create('Invalid attribute name error.'),
                                           value);
      end;
      else begin
        if assigned(newElement.ParentNode)
          then newElement.ParentNode.RemoveChild(newElement);
        FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newElement));
        result:= parserErrorFactory(sender,locator,
                                           EParserInvalidAttributeValue_Err.create('Invalid attribute value error.'),
                                           value);
      end;
    end; {try ...}

    FRefNode:= newElement;
  end; {if assigned(FRefNode) ...}

  if not assigned(result)
    then if assigned(nextHandler)
      then result:= nextHandler.startElement(sender,locator,namespaceURI,tagName,attributes);
end;

function TXmlDocBuilder.startPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                                 prefix,
                                                 uri: wideString): TXmlParserError;
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
begin
  if assigned(FOnStartPrefixMapping) then FOnStartPrefixMapping(sender,locator,prefix,uri);
  if (prefix = 'xmlns') and (uri <> 'http://www.w3.org/2000/xmlns/') then begin
    result:= parserErrorFactory(sender,locator,
                                EParserInvalidPrefix_Err.create('Invalid prefix error.'),
                                'xmlns');
    exit;
  end;
  if prefix <> ''
    then if not isXmlPrefix(prefix) then begin
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidPrefix_Err.create('Invalid prefix error.'),
                                  prefix);
      exit;
    end;
  if not ( IsXMLAttValue(concat(dQuote,uri,dQuote)) or
    IsXMLAttValue(concat(sQuote,uri,sQuote)) ) then begin
    result:= parserErrorFactory(sender,locator,
                                EParserInvalidNamespaceURI_Err.create('Invalid namespace URI error.'),
                                uri);
    exit;
  end;
  FPrefixUriList.add(prefix,uri);
  if assigned(nextHandler)
    then result:= nextHandler.startPrefixMapping(sender,locator,prefix,uri)
    else result:= nil;
end;

function TXmlDocBuilder.xmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                       const locator: TdomStandardLocator;
                                             version,
                                             encDl,
                                             sdDl: wideString): TXmlParserError;
begin
  if assigned(FOnXmlDeclaration) then FOnXmlDeclaration(sender,locator,version,encDl,sdDl);
  // notifications of xmlDeclaration are being ignored.
  result:= nil;
  if assigned(nextHandler)
    then result:= nextHandler.xmlDeclaration(sender,locator,version,encDl,sdDl);
end;



// ++++++++++++++++++++++ TXmlStandardDocReader ++++++++++++++++++++++++
function TXmlStandardDocReader.WriteXmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                                    const locator: TdomStandardLocator;
                                                    const content: wideString): TXmlParserError;
var
  version,encoding,standalone,targetName,attribSequence: wideString;
  versionAttr,encodingAttr,standaloneAttr: TdomAttr;
  versionIndex,encodingIndex,standaloneIndex: integer;
  newElement: TdomElement;
  dummyDoc: TdomDocument;
begin
  result:= nil;
  XMLAnalyseTag(content,TargetName,AttribSequence);
  if TargetName <> 'xml' then begin
    result:= parserErrorFactory(sender,locator,
                                EParserInvalidXmlDeclaration_Err.create('Invalid xml-declaration error.'),
                                '');
    exit;
  end;
  dummyDoc:= TdomDocument.create(nil);
  NewElement:= dummyDoc.CreateElement('dummy');
  try
    XMLAnalyseAttrSequence(AttribSequence,NewElement);
    with NewElement.Attributes do begin
      VersionAttr:= (GetNamedItem('version') as TdomAttr);
      EncodingAttr:= (GetNamedItem('encoding') as TdomAttr);
      StandaloneAttr:= (GetNamedItem('standalone') as TdomAttr);
      VersionIndex:= getNamedIndex('version');
      EncodingIndex:= getNamedIndex('encoding');
      StandaloneIndex:= getNamedIndex('standalone');
      if (VersionIndex <> 0)
        or (EncodingIndex > 1)
        or ((Length > 1) and (EncodingIndex = -1) and (StandaloneIndex = -1))
        or ((Length > 2) and ((EncodingIndex = -1) or (StandaloneIndex = -1)))
        or (Length > 3)
        or (not assigned(VersionAttr))
        then begin
          result:= parserErrorFactory(sender,locator,
                                      EParserInvalidXmlDeclaration_Err.create('Invalid xml-declaration error.'),
                                      '');
          dummyDoc.free;
          exit;
        end;
    end; {with ...}
    version:= VersionAttr.value;
    if assigned(EncodingAttr)
      then encoding:= EncodingAttr.value
      else encoding:= '';
    if assigned(standaloneAttr)
      then standalone:= StandaloneAttr.value
      else Standalone:= '';

    if assigned(NextHandler)
      then result:= NextHandler.xmlDeclaration(sender,locator,version,encoding,standalone);

  finally
    dummyDoc.free;
  end; {try ...}
end;

function TXmlStandardDocReader.WriteProcessingInstruction(const sender: TXmlCustomProcessorAgent;
                                                          const locator: TdomStandardLocator;
                                                          const Content: wideString): TXmlParserError;
var
  TargetName,AttribSequence: wideString;
begin
  XMLAnalyseTag(content,TargetName,AttribSequence);
  if assigned(NextHandler)
    then result:= NextHandler.ProcessingInstruction(sender,locator,TargetName,AttribSequence)
    else result:= nil;
end;

function TXmlStandardDocReader.WriteComment(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                            const Content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.comment(sender,locator,content)
    else result:= nil;
end;

function TXmlStandardDocReader.WriteCDATA(const sender: TXmlCustomProcessorAgent;
                                          const locator: TdomStandardLocator;
                                          const Content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.cdata(sender,locator,content)
    else result:= nil;
end;

function TXmlStandardDocReader.WriteCharRef(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                            const content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.charRef(sender,locator,content)
    else result:= nil;
end;

function TXmlStandardDocReader.WritePCDATA(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                           const Content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.pcdata(sender,locator,content)
    else result:= nil;
end;

function TXmlStandardDocReader.WriteStartElement(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                 const Content: wideString): TXmlParserError;
var
  tagName: wideString;
  attributeList: TdomNameValueList;
begin
  result:= nil;
  attributeList:= TdomNameValueList.create;
  try
    try
      XMLAnalyseElement(content,tagName,attributeList);
    except
      on EParserMissingWhiteSpace_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserMissingWhiteSpace_Err.create('Missing white-space error.'),
                                    '');
      on EParserMissingEqualitySign_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserMissingEqualitySign_Err.create('Missing equality sign error.'),
                                    '');
      on EParserMissingQuotationMark_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserMissingQuotationMark_Err.create('Missing quotation mark error.'),
                                    '');
      on EParserDoubleEqualitySign_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserDoubleEqualitySign_Err.create('Double equality sign error.'),
                                    '');
      on EParserInvalidAttributeName_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserInvalidAttributeName_Err.create('Invalid attribute name error.'),
                                    '');
      on EParserDoubleAttributeName_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserDoubleAttributeName_Err.create('Double attribute name error.'),
                                    '');
      else  // Only for debugging.  In principle the above "on .. do" commands should catch any exception.
        result:= parserErrorFactory(sender,locator,
                                    EParserFatalError.create('EParserFatalError'),
                                    '');
    end;
    if assigned(NextHandler)
      then if not assigned(result)
        then result:= NextHandler.startElement(sender,locator,'',tagName,attributeList);
  finally
    attributeList.free;
  end;
end;

function TXmlStandardDocReader.WriteEndElement(const sender: TXmlCustomProcessorAgent;
                                               const locator: TdomStandardLocator;
                                               const content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.endElement(sender,locator,'',content)
    else result:= nil;
end;

function TXmlStandardDocReader.WriteEmptyElement(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                 const content: wideString): TXmlParserError;
var
  tagName: wideString;
  attributeList: TdomNameValueList;
begin
  result:= nil;
  attributeList:= TdomNameValueList.create;
  try
    try
      XMLAnalyseElement(content,tagName,attributeList);
    except
      on EParserMissingWhiteSpace_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserMissingWhiteSpace_Err.create('Missing white-space error.'),
                                    '');
      on EParserMissingEqualitySign_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserMissingEqualitySign_Err.create('Missing equality sign error.'),
                                    '');
      on EParserMissingQuotationMark_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserMissingQuotationMark_Err.create('Missing quotation mark error.'),
                                    '');
      on EParserDoubleEqualitySign_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserDoubleEqualitySign_Err.create('Double equality sign error.'),
                                    '');
      on EParserInvalidAttributeName_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserInvalidAttributeName_Err.create('Invalid attribute name error.'),
                                    '');
      on EParserDoubleAttributeName_Err do
        result:= parserErrorFactory(sender,locator,
                                    EParserDoubleAttributeName_Err.create('Double attribute name error.'),
                                    '');
      else  // Only for debugging.  In principle the above "on .. do" commands should catch any exception.
        result:= parserErrorFactory(sender,locator,
                                    EParserFatalError.create('EParserFatalError'),
                                    '');
    end;
    if assigned(NextHandler)
      then if not assigned(result) then begin
        result:= NextHandler.startElement(sender,locator,'',tagName,attributeList);
        if not assigned(result)
          then result:= NextHandler.endElement(sender,locator,'',tagName);
      end;
  finally
    attributeList.free;
  end;
end;

function TXmlStandardDocReader.WriteEntityRef(const sender: TXmlCustomProcessorAgent;
                                              const locator: TdomStandardLocator;
                                              const content: wideString): TXmlParserError;
var
  EntityName: wideString;
begin
  EntityName:= copy(content,2,length(content)-2);
  if assigned(NextHandler)
    then result:= NextHandler.EntityRef(sender,locator,EntityName)
    else result:= nil;
end;

function TXmlStandardDocReader.WriteDoctype(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                            const content: wideString): TXmlParserError;
var
  DeclAnfg: integer;
  ExternalId,intro,name,SystemLiteral,PubidLiteral: wideString;
  NakedContent,data,dummy1,dummy2: wideString;
  Error: boolean;
begin
  result:= nil;
  if (copy(content,1,9) <> '<!DOCTYPE')
    or (content[length(content)] <> '>')
    or (not isXmlWhiteSpace(content[10])) then begin
    result:= parserErrorFactory(sender,locator,
                                EParserInvalidDoctype_Err.create('Invalid doctype declaration error.'),
                                '');
    exit;
  end;
  NakedContent:= XmlTrunc(copy(content,11,length(content)-11));
  DeclAnfg:= Pos(wideString('['),NakedContent);
  if DeclAnfg = 0 then begin
    intro:= NakedContent;
    Data:= '';
  end else begin
    intro:= copy(NakedContent,1,DeclAnfg-1);
    dummy1:= copy(NakedContent,DeclAnfg,length(NakedContent)-DeclAnfg+1);
    XMLTruncAngularBrackets(dummy1,data,error); {Diese umst�ndliche Zuweisung ist wegen Delphi-Problem von WideStrings bei copy n�tig}
    if error then begin
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidDoctype_Err.create('Invalid doctype declaration error.'),
                                  '');
      exit;
    end; {if ...}
  end; {if ...}

  XMLAnalyseTag(intro,name,ExternalId);
  if not IsXmlName(name) then begin
    result:= parserErrorFactory(sender,locator,
                                EParserInvalidDoctype_Err.create('Invalid doctype declaration error.'),
                                '');
    exit;
  end; {if ...}

  dummy1:= XmlTrunc(ExternalId);
  ExternalId:= dummy1; {Diese umst�ndliche Zuweisung ist wegen der Verwendung von WideStrings n�tig}
  if ExternalId <> '' then begin
    XMLAnalyseEntityDef(ExternalId,dummy1,SystemLiteral,PubidLiteral,dummy2,Error);
    if Error or (dummy1 <> '') or (dummy2 <> '') then begin
      result:= parserErrorFactory(sender,locator,
                                  EParserInvalidDoctype_Err.create('Invalid doctype declaration error.'),
                                  '');
      exit;
    end; {if ...}
  end; {if ...}

  if assigned(NextHandler)
    then result:= NextHandler.doctype(sender,locator,name,PubidLiteral,SystemLiteral,Data);

end;

function TXmlStandardDocReader.parse(const sender: TXmlCustomProcessorAgent;
                                     const inputSource: TXmlInputSource): boolean;
const
  CR: WideChar  = #13;
  LF: WideChar  = #10;
  QM: WideChar  = '?';
  ampCode: word = 38; // code of &
  gtCode: word = 60; // code of <
  SingleQuote: WideChar = #39; // code of '
  DoubleQuote: WideChar = #34; // code of "
  NUMBERSIGN: WideChar = #35;  // code of #
  SOLIDUS: WideChar = #47;     // code of /
  PISTART: wideString = '<?';
  PIEND: wideString = '?>';
  XMLDECLSTART: wideString = '<?xml';
  COMMENTSTART: wideString = '<!--';
  CDATASTART: wideString = '<![CDATA[';
  DOCTYPESTART: wideString = '<!DOCTYPE';
var
  l,offset: integer;
  str1: WideChar;
  subEndMarker,SubStartMarker: wideString;
  SingleQuoteOpen,DoubleQuoteOpen,BracketOpened: boolean;
  parserError: TXmlParserError;
  pieceType: TdomPieceType;
  content: TdomCustomStr;
begin
  result:= true;
  parserError:= nil;
  PieceType:= xmlUnknown;
  subEndMarker:= '';
  subStartMarker:= '';
  SingleQuoteOpen:= false;
  DoubleQuoteOpen:= false;
  BracketOpened:= false;
  content:= TdomCustomStr.create;
  try
    try
      try
        if assigned(NextHandler)
          then parserError:= NextHandler.startDocument(sender,inputSource.Locator,inputsource.rootName);
        while InputSource.getNextWideChar(str1) do begin
          if assigned(parserError) then break;
          if not IsXmlChar(str1) then begin
            content.addWideChar(str1);
            raise EParserInvalidCharacter_Err.create('Invalid character error.');
          end;

          case PieceType of

            xmlUnknown: begin
              if str1 = '<' then PieceType:= xmlStartTag
              else if str1 = '&' then PieceType:= xmlEntityRef
              else PieceType:= xmlPCData;
              content.AddWideChar(Str1);
              inputsource.locator.pieceStart;
            end;

            xmlPCData: begin
              if str1 = '<' then begin
                parserError:= writePCDATA(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlStartTag;
                inputsource.locator.pieceStart;
              end else
              if str1 = '&' then begin
                parserError:= writePCDATA(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlEntityRef;
                inputsource.locator.pieceStart;
              end;
              content.AddWideChar(Str1);
            end;

            xmlEntityRef: begin
              content.AddWideChar(str1);
              if str1 = ';' then begin
                if content[2] = NUMBERSIGN
                  then parserError:= writeCharRef(sender,inputSource.Locator,content.value)
                  else parserError:= writeEntityRef(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;
            end;

            xmlStartTag: begin
              content.AddWideChar(str1);
              case content.length of
                2: if content.startsWith(PISTART) then PieceType:= xmlProcessingInstruction;
                4: if content.startsWith(COMMENTSTART) then PieceType:= xmlComment;
                9: if content.startsWith(CDATASTART) then begin
                     PieceType:= xmlCDATA;
                   end else
                   if content.startsWith(DOCTYPESTART) then begin
                     PieceType:= xmlDoctype;
                     subEndMarker:= '';
                     subStartMarker:= '';
                     BracketOpened:= false;
                   end;
              end;

              // Count quotation marks:
              if (str1 = SingleQuote) and (not DoubleQuoteOpen) then begin
                SingleQuoteOpen:= not SingleQuoteOpen;
              end else if (str1 = DoubleQuote) and (not SingleQuoteOpen) then begin
                DoubleQuoteOpen:= not DoubleQuoteOpen;
              end else if str1 = '>' then begin
                if (not DoubleQuoteOpen) and (not SingleQuoteOpen) then begin
                  if content[2] = SOLIDUS then begin
                    l:= content.length;
                    offset:= 3;
                    // eliminate white-space after tag name:
                    while (l-offset > 0) and isXMLWhitespace(content[l-offset+2]) do
                      inc(offset);
                    parserError:= writeEndElement(sender,inputSource.Locator,copy(content.value,3,l-offset))
                  end else begin if content[content.length-1] = SOLIDUS
                    then parserError:= writeEmptyElement(sender,inputSource.Locator,copy(content.value,2,content.length-3))
                    else parserError:= writeStartElement(sender,inputSource.Locator,copy(content.value,2,content.length-2));
                  end;
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
              end;
            end;

            xmlProcessingInstruction: begin
              content.AddWideChar(str1);
              if str1 = '>' then
                if content[content.length-1] = QM then begin
                  if (content.length > 5) then
                    if IsXmlWhiteSpace(content[6]) then
                      if content.startsWith(XMLDECLSTART)
                        then PieceType:= xmlXmlDeclaration;
                  case pieceType of
                    xmlXmlDeclaration: parserError:= writeXmlDeclaration(sender,inputSource.Locator,copy(content.value,3,content.length-4));
                    xmlProcessingInstruction: parserError:= writeProcessingInstruction(sender,inputSource.Locator,copy(content.value,3,content.length-4));
                  end;
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
            end;

            xmlComment: begin
              content.AddWideChar(str1);
              if str1 = '>' then
                if content[content.length-1] = '-' then
                  if content[content.length-2] = '-' then
                    if content.length > 6 then begin
                      parserError:= writeComment(sender,inputSource.Locator,copy(content.value,5,content.length-7));
                      content.reset;
                      PieceType:= xmlUnknown;
                    end;
            end;

            xmlCDATA: begin
              content.AddWideChar(str1);
              if str1 = '>' then
                if content[content.length-1] = ']' then
                  if content[content.length-2] = ']' then begin
                    parserError:= writeCDATA(sender,inputSource.Locator,copy(content.value,10,content.length-12));
                    content.reset;
                    PieceType:= xmlUnknown;
                  end;
            end;

            xmlDoctype: begin
              content.AddWideChar(str1);
              if (SubEndMarker = '') then begin

                if (str1 = SingleQuote) and (not DoubleQuoteOpen) then begin
                  SingleQuoteOpen := not SingleQuoteOpen;
                end else if (str1 = DoubleQuote) and (not SingleQuoteOpen) then begin
                  DoubleQuoteOpen := not DoubleQuoteOpen;
                end;

                if BracketOpened then begin
                  if not (SingleQuoteOpen or DoubleQuoteOpen) then begin
                    if str1 = '<' then begin
                      SubStartMarker:= '<';
                    end else if (str1 = '!') and (SubStartMarker = '<') then begin
                      SubStartMarker:= '<!';
                    end else if (str1 = QM) and (SubStartMarker = '<') then begin
                      SubStartMarker:= '';
                      SubEndMarker:= PIEND;
                    end else if (str1 = '-') and (SubStartMarker = '<!')then begin
                      SubStartMarker:= '<!-';
                    end else if (str1 = '-') and (SubStartMarker = '<!-')then begin
                      SubStartMarker:= '';
                      SubEndMarker:= '-->';
                    end else if SubStartMarker <> '' then begin
                      SubStartMarker:= '';
                    end;
                    if (str1 = ']')
                      and (not SingleQuoteOpen)
                      and (not DoubleQuoteOpen)
                      then BracketOpened:= false;
                  end; {if not ...}
                end else begin {if BracketOpened ... }
                  if (str1 = '[')
                    and (not SingleQuoteOpen)
                    and (not DoubleQuoteOpen) then BracketOpened:= true;
                end; {if BracketOpened ... else ...}

              end else begin; {if (SubEndMarker = '') ...}
                if content.endsWith(SubEndMarker) then SubEndMarker:= '';
              end; {if (SubEndMarker = '') ... else ...}

              if (not DoubleQuoteOpen)
                and (not SingleQuoteOpen)
                and (not BracketOpened)
                and (SubEndMarker = '')
                and (str1 = '>')
                then begin
                  parserError:= writeDoctype(sender,inputSource.Locator,content.value);
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
            end; {xmlDoctype: ...}
          end; {case ...}
        end; {while ...}

        if not assigned(parserError)
          then if content.length > 0
            then parserError:= writePCDATA(sender,inputSource.Locator,content.value);

        if not assigned(parserError)
          then if assigned(NextHandler)
            then parserError:= NextHandler.endDocument(sender,inputSource.Locator);
      except
        on EConvertError do raise EParserInvalidCharacter_Err.create('Invalid character error.');
        on EReadError do raise EParserInvalidCharacter_Err.create('Invalid character error.');
      end; {try ...}
    except
      on E: EParserInvalidCharacter_Err do
        parserError:= parserErrorFactory(sender,inputSource.Locator,
                                         EParserInvalidCharacter_Err.create('Invalid character error.'),
                                         '');
    end; {try}

    sendErrorNotification(sender,parserError);
    if assigned(parserError) then begin
      parserError.free;
      parserError:= nil;
      result:= false;
    end;

  finally
    content.free;
  end; {try}
end;



// +++++++++++++++++++++++ TXmlStandardDomReader +++++++++++++++++++++++
constructor TXmlStandardDomReader.create(AOwner: TComponent);
begin
  inherited create(AOwner);
  suppressXmlns:= false;
  prefixMapping:= false;
end;

function TXmlStandardDomReader.WriteXmlDeclaration(const sender: TXmlCustomProcessorAgent;
                                                   const locator: TdomStandardLocator;
                                                   const version,
                                                         encDl,
                                                         sdDl: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.xmlDeclaration(sender,locator,version,encDl,sdDl)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteProcessingInstruction(const sender: TXmlCustomProcessorAgent;
                                                          const locator: TdomStandardLocator;
                                                          const targ,
                                                                attribSequence : wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.ProcessingInstruction(sender,locator,targ,attribSequence)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteComment(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                            const content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.comment(sender,locator,content)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteCDATA(const sender: TXmlCustomProcessorAgent;
                                          const locator: TdomStandardLocator;
                                          const content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.cdata(sender,locator,content)
    else result:= nil;
end;

function TXmlStandardDomReader.WritePCDATA(const sender: TXmlCustomProcessorAgent;
                                           const locator: TdomStandardLocator;
                                           const content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.pcdata(sender,locator,content)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteStartElement(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                 const tagName: wideString;
                                                 const attributeList: TdomNameValueList): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.startElement(sender,locator,'',tagName,attributeList)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteEndElement(const sender: TXmlCustomProcessorAgent;
                                               const locator: TdomStandardLocator;
                                               const tagName: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.endElement(sender,locator,'',tagName)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteEmptyElement(const sender: TXmlCustomProcessorAgent;
                                                 const locator: TdomStandardLocator;
                                                 const tagName: wideString;
                                                 const attributeList: TdomNameValueList): TXmlParserError;
begin
  if assigned(NextHandler) then begin
    result:= NextHandler.startElement(sender,locator,'',tagName,attributeList);
    if not assigned(result)
      then result:= NextHandler.endElement(sender,locator,'',tagName);
  end else result:= nil;
end;

function TXmlStandardDomReader.writeStartPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                                       const locator: TdomStandardLocator;
                                                             prefix,
                                                             uri: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.startPrefixMapping(sender,locator,prefix,uri)
    else result:= nil;
end;

function TXmlStandardDomReader.writeEndPrefixMapping(const sender: TXmlCustomProcessorAgent;
                                                     const locator: TdomStandardLocator;
                                                           prefix: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.endPrefixMapping(sender,locator,prefix)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteCharRef(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                            const content: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.charRef(sender,locator,content)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteEntityRef(const sender: TXmlCustomProcessorAgent;
                                              const locator: TdomStandardLocator;
                                              const entityName: wideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.EntityRef(sender,locator,entityName)
    else result:= nil;
end;

function TXmlStandardDomReader.WriteDoctype(const sender: TXmlCustomProcessorAgent;
                                            const locator: TdomStandardLocator;
                                            const name,
                                                  publicId,
                                                  systemId,
                                                  intSubset: WideString): TXmlParserError;
begin
  if assigned(NextHandler)
    then result:= NextHandler.doctype(sender,locator,name,publicId,systemId,intSubset)
    else result:= nil;
end;

function TXmlStandardDomReader.parseloop(const sender: TXmlCustomProcessorAgent;
                                         const sourceNode: TDomNode): TXmlParserError;
var
  i: integer;
  attributeList: TdomNameValueList;
  pfxUriList: TdomNameValueList;
  rootName,versionNumber: wideString;
  suppressThisAttr: boolean;

  function writeWhileCheckingForAMPAndLT(const sender: TXmlCustomProcessorAgent;
                                         const locator: TdomStandardLocator;
                                         const source: wideString): TXmlParserError;
  var
    i: integer;
    content: TdomCustomStr;
  begin
    result:= nil;
    content:= TdomCustomStr.create;
    try
      for i:= 1 to length(source) do begin
        case ord(source[i]) of
          60: begin  // LT
            result:= WritePCDATA(sender,locator,content.value);
            if assigned(result) then break;
            result:= WriteCharRef(sender,locator,'&#60;');
            if assigned(result) then break;
            content.reset;
          end;
          38: begin // AMP
            result:= WritePCDATA(sender,locator,content.value);
            if assigned(result) then break;
            result:= WriteCharRef(sender,locator,'&#38;');
            if assigned(result) then break;
            content.reset;
          end;

        else
          content.addWideChar(source[i]);
        end;
      end;
      if content.length > 0
        then if not assigned(result)
          then result:= WritePCDATA(sender,locator,content.value);
    finally
      content.free;
    end;
  end;

begin
  result:= nil;
  case sourceNode.nodeType of
    ntElement_Node: begin
      attributeList:= TdomNameValueList.create;
      pfxUriList:= TdomNameValueList.create;
      try
        for i:= 0 to pred(sourceNode.attributes.length) do
          with (sourceNode.attributes.item(i) as TdomAttr) do begin
            suppressThisAttr:= false;
            if FPrefixMapping or FSuppressXmlns then begin
              if IsXmlDefaultAttName(nodeName) then begin
                suppressThisAttr:= FSuppressXmlns;
                pfxUriList.add('',literalValue);
              end else if IsXmlPrefixedAttName(nodeName) then begin
                suppressThisAttr:= FSuppressXmlns;
                pfxUriList.add(XmlExtractLocalName(nodeName),literalValue);
              end;
            end;
            if not suppressThisAttr then attributeList.add(nodeName,literalValue);
          end;
        if FPrefixMapping then
          with pfxUriList do
            for i:= 0 to pred(length) do begin
              result:= writeStartPrefixMapping(sender,nil,names[i],values[i]);
              if assigned(result) then break;
            end;
        if not assigned(result) then begin
          if sourceNode.hasChildNodes then begin
            result:= WriteStartElement(sender,nil,sourceNode.nodeName,attributeList);
            if not assigned(result) then begin
              for i:= 0  to pred(sourceNode.childNodes.length) do begin
                result:= parseloop(sender,sourceNode.childNodes.item(i));
                if assigned(result) then break;
              end;
            end;
            if not assigned(result)
              then result:= WriteEndElement(sender,nil,sourceNode.nodeName);
          end else result:= WriteEmptyElement(sender,nil,sourceNode.nodeName,attributeList);
          if FPrefixMapping and not assigned(result) then
            with pfxUriList do
              for i:= pred(length) downto 0 do begin
                result:= writeEndPrefixMapping(sender,nil,names[i]);
                if assigned(result) then break;
              end;
        end;
      finally
        attributeList.free;
        pfxUriList.free;
      end;
    end;
    ntText_Node:
      result:= writeWhileCheckingForAMPAndLT(sender,nil,sourceNode.nodeValue);
    ntCDATA_Section_Node:
      result:= WriteCDATA(sender,nil,sourceNode.nodeValue);
    ntEntity_Reference_Node:
      result:= WriteEntityRef(sender,nil,sourceNode.nodeName);
    ntProcessing_Instruction_Node:
      result:= WriteProcessingInstruction(sender,nil,sourceNode.nodeName,sourceNode.nodeValue);
    ntComment_Node:
      result:= WriteComment(sender,nil,sourceNode.nodeValue);
    ntDocument_Node: begin
      if assigned((sourceNode as TdomDocument).documentElement)
        then rootName:= (sourceNode as TdomDocument).documentElement.nodeName
        else rootName:= '';
      if assigned(NextHandler)
        then result:= NextHandler.startDocument(sender,nil,rootName);
      if not assigned(result) then begin
        versionNumber:= (sourceNode as TdomDocument).version;
        if versionNumber = '' then  versionNumber:= '1.0';
        result:= WriteXmlDeclaration(sender,nil,versionNumber,(sourceNode as TdomDocument).encoding,(sourceNode as TdomDocument).systemId);
      end;
      if not assigned(result) then begin
        for i:= 0  to pred(sourceNode.childNodes.length) do begin
          result:= parseloop(sender,sourceNode.childNodes.item(i));
          if assigned(result) then break;
        end;
      end;
      if not assigned(result)
        then if assigned(NextHandler)
          then result:= NextHandler.endDocument(sender,nil);
    end;
    ntDocument_Type_Node:
      result:= WriteDoctype(sender,nil,sourceNode.nodeName,
                            (sourceNode as TdomDocumentType).publicId,
                            (sourceNode as TdomDocumentType).systemId,
                            (sourceNode as TdomDocumentType).internalSubset);
    else
      result:= nil;  // xxx raise an exception instead?
  end;
end;

function  TXmlStandardDomReader.parse(const sender: TXmlCustomProcessorAgent;
                                      const sourceNode: TDomNode): boolean;
var
  parserError: TXmlParserError;
begin
  parserError:= parseloop(sender,sourceNode);

  sendErrorNotification(sender,parserError);
  if assigned(parserError) then begin
    parserError.free;
    parserError:= nil;
    result:= false;
  end else result:= true;
end;



// ++++++++++++++++++++++ TdomCustomContentHandler ++++++++++++++++++++++
procedure TdomCustomContentHandler.comment(const sender: TdomCustomParser;
                                           const locator: TdomStandardLocator;
                                           const data: wideString);
begin
end;

procedure TdomCustomContentHandler.CDATA(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const data: wideString);
begin
end;

procedure TdomCustomContentHandler.charRef(const sender: TdomCustomParser;
                                           const locator: TdomStandardLocator;
                                           const data: wideString);
begin
end;

procedure TdomCustomContentHandler.doctype(const sender: TdomCustomParser;
                                           const locator: TdomStandardLocator;
                                           const name,
                                                 pubId,
                                                 sysId,
                                                 data: wideString);
begin
end;

procedure TdomCustomContentHandler.endDocument(const sender: TdomCustomParser);
begin
end;

procedure TdomCustomContentHandler.endElement(const sender: TdomCustomParser;
                                              const locator: TdomStandardLocator;
                                              const namespaceURI,
                                                    localName,
                                                    tagName: wideString);
begin
end;

procedure TdomCustomContentHandler.endPrefixMapping(const sender: TdomCustomParser;
                                                    const locator: TdomStandardLocator;
                                                    const prefix: wideString);
begin
end;

procedure TdomCustomContentHandler.entityRef(const sender: TdomCustomParser;
                                             const locator: TdomStandardLocator;
                                             const name: wideString);
begin
end;

procedure TdomCustomContentHandler.PCDATA(const sender: TdomCustomParser;
                                          const locator: TdomStandardLocator;
                                          const data: wideString);
begin
end;

procedure TdomCustomContentHandler.processingInstruction(const sender: TdomCustomParser;
                                                         const locator: TdomStandardLocator;
                                                         const targ,
                                                               data : wideString);
begin
end;

procedure TdomCustomContentHandler.skippedEntity(const sender: TdomCustomParser;
                                                 const locator: TdomStandardLocator;
                                                 const name: wideString);
begin
end;

procedure TdomCustomContentHandler.startDocument(const sender: TdomCustomParser;
                                                 const locator: TdomStandardLocator;
                                                       defaultRoot: wideString);
begin
end;

procedure TdomCustomContentHandler.startElement(const sender: TdomCustomParser;
                                                const locator: TdomStandardLocator;
                                                const namespaceURI,
                                                      localName,
                                                      tagName: wideString;
                                                      attributes: TdomNameValueList);
begin
end;

procedure TdomCustomContentHandler.startPrefixMapping(const sender: TdomCustomParser;
                                                      const locator: TdomStandardLocator;
                                                      const prefix,
                                                            uri: wideString);
begin
end;

procedure TdomCustomContentHandler.xmlDeclaration(const sender: TdomCustomParser;
                                                  const locator: TdomStandardLocator;
                                                  const version,
                                                        encDl,
                                                        sdDl: wideString);
begin
end;



// +++++++++++++++++++++++ TdomCustomDTDHandler +++++++++++++++++++++++
function TdomCustomDTDHandler.getPEFromCurrentCMObject(const PEReferenceName: wideString): wideString;
begin
  raise ENot_Supported_Err.create('Not supported error.');
end;

procedure TdomCustomDTDHandler.attributeDefinition(const sender: TdomCustomParser;
                                                   const locator: TdomStandardLocator;
                                                   const name,
                                                         attType,
                                                         bracket,
                                                         defaultDecl,
                                                         attValue: wideString);
begin
end;

procedure TdomCustomDTDHandler.comment(const sender: TdomCustomParser;
                                       const locator: TdomStandardLocator;
                                       const data: wideString);
begin
end;

procedure TdomCustomDTDHandler.conditionalSection(const sender: TdomCustomParser;
                                                  const locator: TdomStandardLocator;
                                                  const includeStmt,
                                                        data: wideString);
begin
end;

procedure TdomCustomDTDHandler.elementTypeDeclaration(const sender: TdomCustomParser;
                                                      const locator: TdomStandardLocator;
                                                      const name,
                                                            data: wideString);
begin
end;

procedure TdomCustomDTDHandler.endAttListDeclaration(const sender: TdomCustomParser;
                                                     const locator: TdomStandardLocator);
begin
end;

procedure TdomCustomDTDHandler.endDtd(const sender: TdomCustomParser);
begin
end;

procedure TdomCustomDTDHandler.entityDeclaration(const sender: TdomCustomParser;
                                                 const locator: TdomStandardLocator;
                                                 const name,
                                                       entityValue,
                                                       pubId,
                                                       sysId,
                                                       notaName: wideString);
begin
end;

procedure TdomCustomDTDHandler.notationDeclaration(const sender: TdomCustomParser;
                                                   const locator: TdomStandardLocator;
                                                   const name,
                                                         pubId,
                                                         sysId: wideString);
begin
end;

procedure TdomCustomDTDHandler.parameterEntityDeclaration(const sender: TdomCustomParser;
                                                          const locator: TdomStandardLocator;
                                                          const name,
                                                                entityValue,
                                                                pubId,
                                                                sysId: wideString);
begin
end;

procedure TdomCustomDTDHandler.parameterEntityRef(const sender: TdomCustomParser;
                                                  const locator: TdomStandardLocator;
                                                  const name: wideString);
begin
end;

procedure TdomCustomDTDHandler.processingInstruction(const sender: TdomCustomParser;
                                                     const locator: TdomStandardLocator;
                                                     const targ,
                                                           data : wideString);
begin
end;

procedure TdomCustomDTDHandler.startAttListDeclaration(const sender: TdomCustomParser;
                                                       const locator: TdomStandardLocator;
                                                       const name: wideString);
begin
end;

procedure TdomCustomDTDHandler.startDtd(const sender: TdomCustomParser;
                                        const pubId,
                                              sysId: wideString);
begin
end;

procedure TdomCustomDTDHandler.textDeclaration(const sender: TdomCustomParser;
                                               const locator: TdomStandardLocator;
                                               const version,
                                                     encDl: wideString);
begin
end;



// ++++++++++++++++++++++ TdomCustomErrorHandler ++++++++++++++++++++++
procedure TdomCustomErrorHandler.error(const sender: TdomCustomParser;
                                       const locator: TdomStandardLocator;
                                       const e: EParserException;
                                       const code: wideString);
begin
end;

procedure TdomCustomErrorHandler.fatalError(const sender: TdomCustomParser;
                                            const locator: TdomStandardLocator;
                                            const e: EParserException;
                                            const code: wideString);
begin
  raise EParserFatalError.create('EParserFatalError: Fatal Error.');
end;

procedure TdomCustomErrorHandler.warning(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const e: EParserException;
                                         const code: wideString);
begin
end;



// ++++++++++++++++++ TdomStandardContentModelReader ++++++++++++++++++
function TdomStandardContentModelReader.parse(const sender: TdomCustomParser;
                                              const source: TdomCustomCMIEObject):boolean;
//  This function was converted for stream processing by Karl Waclawek.
var
  dtdAnalyzer: TdomDtdAnalyzer;
  i,j: integer;

  function getBracket(CMNode: TdomCMNode): wideString;
  var
    k: integer;
    XMLStream: TdomWideStringStream;
  begin
    Result := '';
    if CMNode.HasChildNodes then begin
      XMLStream := TdomWideStringStream.create;
      try
        writeWideChars(XMLStream, ['(']);
        for k:= 0 to CMNode.ChildNodes.Length -1 do begin
          if k > 0 then writeWideChars(XMLStream, [' ', '|', ' ']);
          CMNode.ChildNodes.item(k).writeCode(XMLStream);
        end;
        writeWideChars(XMLStream, [')']);
        Result := XMLStream.DataString;
      finally
        XMLStream.Free;
      end;
    end;
  end;

begin
  result:= true;
  if not(sender is TdomDtdAnalyzer) then exit;
  dtdAnalyzer:= (sender as TdomDtdAnalyzer);
  with source.ChildNodes do begin
    for i:= 0 to pred(length) do begin
      case Item(i).NodeType of
        ctAttributeList:
          begin
            dtdAnalyzer.DtdHandler.startAttListDeclaration(sender,nil,Item(i).NodeName);
            with TdomCMAttrList(Item(i)).childnodes do begin
              for j:= 0 to pred(length) do begin
                dtdAnalyzer.DtdHandler.attributeDefinition(
                                          sender,
                                          nil,
                                          Item(j).NodeName,
                                          (Item(j) as TdomCMAttrDefinition).AttributeType,
                                          getBracket(Item(j)),
                                          (Item(j) as TdomCMAttrDefinition).DefaultDeclaration,
                                          Item(j).NodeValue);
              end; {for ...}
            end; {with ...}
            dtdAnalyzer.DtdHandler.endAttListDeclaration(sender,nil);
          end;
        ctComment:
          dtdAnalyzer.DtdHandler.comment(
                                    sender,
                                    nil,
                                    (Item(i) as TdomCMComment).data);
        ctElementTypeDeclaration:
          dtdAnalyzer.DtdHandler.elementTypeDeclaration(
                                    sender,
                                    nil,
                                    Item(i).NodeName,
                                    (Item(i) as TdomCMElementTypeDeclaration).Contentspec);
        ctEntityDeclaration:
          dtdAnalyzer.DtdHandler.entityDeclaration(
                                    sender,
                                    nil,
                                    Item(i).NodeName,
                                    Item(i).nodeValue,
                                    (Item(i) as TdomCMEntityDeclaration).publicId,
                                    (Item(i) as TdomCMEntityDeclaration).systemId,
                                    (Item(i) as TdomCMEntityDeclaration).notationName);
        ctNotationDeclaration:
          dtdAnalyzer.DtdHandler.notationDeclaration(
                                    sender,
                                    nil,
                                    Item(i).NodeName,
                                    (Item(i) as TdomCMNotationDeclaration).publicId,
                                    (Item(i) as TdomCMNotationDeclaration).systemId);
        ctParameterEntityDeclaration:
          dtdAnalyzer.DtdHandler.parameterEntityDeclaration(
                                    sender,
                                    nil,
                                    Item(i).NodeName,
                                    Item(i).nodeValue,
                                    (Item(i) as TdomCMParameterEntityDeclaration).publicId,
                                    (Item(i) as TdomCMParameterEntityDeclaration).systemId);
        ctParameterEntityReference:
          dtdAnalyzer.DtdHandler.parameterEntityRef(
                                    sender,
                                    nil,
                                    Item(i).NodeName);
        ctProcessingInstruction:
          dtdAnalyzer.DtdHandler.processingInstruction(
                                    sender,
                                    nil,
                                    (Item(i) as TdomCMProcessingInstruction).target,
                                    (Item(i) as TdomCMProcessingInstruction).data);
      end; {case ...}
    end; {for ...}
  end; {with ...}
end;



// +++++++++++++++++++++++ TdomCustomXMLReader ++++++++++++++++++++++++
function TdomCustomXMLReader.parse(const sender: TdomCustomParser;
                                   const inputSource: TXmlInputSource):boolean;
begin
  result:= true;
end;



// +++++++++++++++++++++ TdomStandardDocXMLReader +++++++++++++++++++++++
procedure TdomStandardDocXMLReader.WriteXmlDeclaration(const sender: TdomCustomParser;
                                                       const locator: TdomStandardLocator;
                                                       const content: wideString);
var
  version,encoding,standalone,targetName,attribSequence: wideString;
  versionAttr,encodingAttr,standaloneAttr: TdomAttr;
  versionIndex,encodingIndex,standaloneIndex: integer;
  newElement: TdomElement;
  dummyDoc: TdomDocument;
begin
  XMLAnalyseTag(content,TargetName,AttribSequence);
  if TargetName <> 'xml'
    then raise EParserInvalidXmlDeclaration_Err.create('Invalid xml-declaration error.');
  dummyDoc:= TdomDocument.create(nil);
  NewElement:= dummyDoc.CreateElement('dummy');
  try
    XMLAnalyseAttrSequence(AttribSequence,NewElement);
    with NewElement.Attributes do begin
      VersionAttr:= (GetNamedItem('version') as TdomAttr);
      EncodingAttr:= (GetNamedItem('encoding') as TdomAttr);
      StandaloneAttr:= (GetNamedItem('standalone') as TdomAttr);
      VersionIndex:= getNamedIndex('version');
      EncodingIndex:= getNamedIndex('encoding');
      StandaloneIndex:= getNamedIndex('standalone');
      if (VersionIndex <> 0)
        or (EncodingIndex > 1)
        or ((Length > 1) and (EncodingIndex = -1) and (StandaloneIndex = -1))
        or ((Length > 2) and ((EncodingIndex = -1) or (StandaloneIndex = -1)))
        or (Length > 3)
        or (not assigned(VersionAttr))
        then begin
          raise EParserInvalidXmlDeclaration_Err.create('Invalid xml-declaration error.');
      end;
    end; {with ...}
    version:= VersionAttr.value;
    if assigned(EncodingAttr)
      then encoding:= EncodingAttr.value
      else encoding:= '';
    if assigned(standaloneAttr)
      then standalone:= StandaloneAttr.value
      else Standalone:= '';

    if assigned(contentHandler)
      then contentHandler.xmlDeclaration(sender,locator,version,encoding,standalone);

  finally
    dummyDoc.free;
  end; {try ...}
end;

procedure TdomStandardDocXMLReader.WriteProcessingInstruction(const sender: TdomCustomParser;
                                                              const locator: TdomStandardLocator;
                                                              const Content: wideString);
var
  TargetName,AttribSequence: wideString;
begin
  XMLAnalyseTag(content,TargetName,AttribSequence);
  if assigned(contentHandler)
    then contentHandler.ProcessingInstruction(sender,locator,TargetName,AttribSequence);
end;

procedure TdomStandardDocXMLReader.WriteComment(const sender: TdomCustomParser;
                                                const locator: TdomStandardLocator;
                                                const Content: wideString);
begin
  if assigned(contentHandler)
    then contentHandler.comment(sender,locator,content);
end;

procedure TdomStandardDocXMLReader.WriteCDATA(const sender: TdomCustomParser;
                                             const locator: TdomStandardLocator;
                                             const Content: wideString);
begin
  if assigned(contentHandler)
    then contentHandler.cdata(sender,locator,content);
end;

procedure TdomStandardDocXMLReader.WritePCDATA(const sender: TdomCustomParser;
                                              const locator: TdomStandardLocator;
                                              const Content: wideString);
begin
  if assigned(contentHandler)
    then contentHandler.pcdata(sender,locator,content);
end;

procedure TdomStandardDocXMLReader.WriteStartElement(const sender: TdomCustomParser;
                                                     const locator: TdomStandardLocator;
                                                     const Content: wideString);
var
  tagName: wideString;
  attributeList: TdomNameValueList;
begin
  attributeList:= TdomNameValueList.create;
  try
    XMLAnalyseElement(content,tagName,attributeList);
    if assigned(contentHandler)
      then contentHandler.startElement(sender,locator,'','',tagName,attributeList);
  finally
    attributeList.free;
  end;
end;

procedure TdomStandardDocXMLReader.WriteEndElement(const sender: TdomCustomParser;
                                                   const locator: TdomStandardLocator;
                                                   const content: wideString);
begin
  if assigned(contentHandler)
    then contentHandler.endElement(sender,locator,'','',content);
end;

procedure TdomStandardDocXMLReader.WriteEmptyElement(const sender: TdomCustomParser;
                                                     const locator: TdomStandardLocator;
                                                     const content: wideString);
var
  tagName: wideString;
  attributeList: TdomNameValueList;
begin
  attributeList:= TdomNameValueList.create;
  try
    XMLAnalyseElement(content,tagName,attributeList);
    if assigned(contentHandler) then begin
      contentHandler.startElement(sender,locator,'','',tagName,attributeList);
      contentHandler.endElement(sender,locator,'','',tagName);
    end;
  finally
    attributeList.free;
  end;
end;

procedure TdomStandardDocXMLReader.WriteCharRef(const sender: TdomCustomParser;
                                                const locator: TdomStandardLocator;
                                                const Content: wideString);
begin
  if assigned(contentHandler)
    then contentHandler.charRef(sender,locator,content);
end;

procedure TdomStandardDocXMLReader.WriteEntityRef(const sender: TdomCustomParser;
                                                  const locator: TdomStandardLocator;
                                                  const Content: wideString);
var
  EntityName: wideString;
begin
  EntityName:= copy(content,2,length(content)-2);
  if assigned(contentHandler)
    then contentHandler.EntityRef(sender,locator,EntityName);
end;

procedure TdomStandardDocXMLReader.WriteDoctype(const sender: TdomCustomParser;
                                                const locator: TdomStandardLocator;
                                                const Content: wideString);
var
  DeclAnfg: integer;
  ExternalId,intro,name,SystemLiteral,PubidLiteral: wideString;
  NakedContent,data,dummy1,dummy2: wideString;
  Error: boolean;
begin
  if (copy(content,1,9) <> '<!DOCTYPE')
    or (content[length(content)] <> '>')
    or (not isXmlWhiteSpace(content[10]))
    then raise EParserInvalidDoctype_Err.create('Invalid doctype declaration error.');
  NakedContent:= XmlTrunc(copy(content,11,length(content)-11));
  DeclAnfg:= Pos(wideString('['),NakedContent);
  if DeclAnfg = 0 then begin
    intro:= NakedContent;
    Data:= '';
  end else begin
    intro:= copy(NakedContent,1,DeclAnfg-1);
    dummy1:= copy(NakedContent,DeclAnfg,length(NakedContent)-DeclAnfg+1);
    XMLTruncAngularBrackets(dummy1,data,error); {Diese umst�ndliche Zuweisung ist wegen Delphi-Problem von WideStrings bei copy n�tig}
    if error then raise EParserInvalidDoctype_Err.create('Invalid doctype declaration error.');
  end; {if ...}

  XMLAnalyseTag(intro,name,ExternalId);
  if not IsXmlName(name)
    then raise EParserInvalidDoctype_Err.create('Invalid doctype declaration error.');

  dummy1:= XmlTrunc(ExternalId);
  ExternalId:= dummy1; {Diese umst�ndliche Zuweisung ist wegen der Verwendung von WideStrings n�tig}
  if ExternalId <> '' then begin
    XMLAnalyseEntityDef(ExternalId,dummy1,SystemLiteral,PubidLiteral,dummy2,Error);
    if Error or (dummy1 <> '') or (dummy2 <> '')
      then raise EParserInvalidDoctype_Err.create('Invalid doctype declaration error.');
  end; {if ...}

  if assigned(contentHandler)
    then contentHandler.doctype(sender,locator,name,PubidLiteral,SystemLiteral,Data);

end;

function TdomStandardDocXMLReader.parse(const sender: TdomCustomParser;
                                        const inputSource: TXmlInputSource): boolean;
const
  CR: WideChar  = #13;
  LF: WideChar  = #10;
  QM: WideChar  = '?';
  ampCode: word = 38; // code of &
  gtCode: word = 60; // code of <
  SingleQuote: WideChar = #39; // code of '
  DoubleQuote: WideChar = #34; // code of "
  NUMBERSIGN: WideChar = #35;  // code of #
  SOLIDUS: WideChar = #47;     // code of /
  PISTART: wideString = '<?';
  PIEND: wideString = '?>';
  XMLDECLSTART: wideString = '<?xml';
  COMMENTSTART: wideString = '<!--';
  CDATASTART: wideString = '<![CDATA[';
  DOCTYPESTART: wideString = '<!DOCTYPE';
var
  l,offset: integer;
  str1: WideChar;
  subEndMarker,SubStartMarker: wideString;
  SingleQuoteOpen,DoubleQuoteOpen,BracketOpened: boolean;
  PieceType: TdomPieceType;
  content: TdomCustomStr;
begin
  result:= true;
  PieceType:= xmlUnknown;
  subEndMarker:= '';
  subStartMarker:= '';
  SingleQuoteOpen:= false;
  DoubleQuoteOpen:= false;
  BracketOpened:= false;
  content:= TdomCustomStr.create;
  try
    try
      try
        if assigned(contentHandler) then contentHandler.startDocument(sender,inputSource.Locator,inputsource.rootName);
        while InputSource.getNextWideChar(str1) do begin
          if not IsXmlChar(str1) then begin
            content.addWideChar(str1);
            raise EParserInvalidCharacter_Err.create('Invalid character error.');
          end;

          case PieceType of

            xmlUnknown: begin
              if str1 = '<' then PieceType:= xmlStartTag
              else if str1 = '&' then PieceType:= xmlEntityRef
              else PieceType:= xmlPCData;
              content.AddWideChar(Str1);
              inputsource.locator.pieceStart;
            end;

            xmlPCData: begin
              if str1 = '<' then begin
                writePCDATA(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlStartTag;
                inputsource.locator.pieceStart;
              end else
              if str1 = '&' then begin
                writePCDATA(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlEntityRef;
                inputsource.locator.pieceStart;
              end;
              content.AddWideChar(Str1);
            end;

            xmlEntityRef: begin
              content.AddWideChar(str1);
              if str1 = ';' then begin
                if content[2] = NUMBERSIGN
                  then writeCharRef(sender,inputSource.Locator,content.value)
                  else writeEntityRef(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;
            end;

            xmlStartTag: begin
              content.AddWideChar(str1);
              case content.length of
                2: if content.startsWith(PISTART) then PieceType:= xmlProcessingInstruction;
                4: if content.startsWith(COMMENTSTART) then PieceType:= xmlComment;
                9: if content.startsWith(CDATASTART) then begin
                     PieceType:= xmlCDATA;
                   end else
                   if content.startsWith(DOCTYPESTART) then begin
                     PieceType:= xmlDoctype;
                     subEndMarker:= '';
                     subStartMarker:= '';
                     BracketOpened:= false;
                   end;
              end;

              {Count quotation marks:}
              if (str1 = SingleQuote) and (not DoubleQuoteOpen) then begin
                SingleQuoteOpen:= not SingleQuoteOpen;
              end else if (str1 = DoubleQuote) and (not SingleQuoteOpen) then begin
                DoubleQuoteOpen:= not DoubleQuoteOpen;
              end else if str1 = '>' then begin
                if (not DoubleQuoteOpen) and (not SingleQuoteOpen) then begin
                  if content[2] = SOLIDUS then begin
                    l:= content.length;
                    offset:= 3;
                    // eliminate white-space after tag name:
                    while (l-offset > 0) and isXMLWhitespace(content[l-offset+2]) do
                      inc(offset);
                    writeEndElement(sender,inputSource.Locator,copy(content.value,3,l-offset))
                  end else begin if content[content.length-1] = SOLIDUS
                    then writeEmptyElement(sender,inputSource.Locator,copy(content.value,2,content.length-3))
                    else writeStartElement(sender,inputSource.Locator,copy(content.value,2,content.length-2));
                  end;
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
              end;
            end;

            xmlProcessingInstruction: begin
              content.AddWideChar(str1);
              if str1 = '>' then
                if content[content.length-1] = QM then begin
                  if (content.length > 5) then
                    if IsXmlWhiteSpace(content[6]) then
                      if content.startsWith(XMLDECLSTART)
                        then begin
                          PieceType:= xmlXmlDeclaration;
                          if (inputSource.Locator.startColumnNumber <> 1)
                            or (inputSource.Locator.startLineNumber <> 1)
                            then raise EParserInvalidXmlDeclaration_Err.create('Character(s) before xml-declaration error.');
                        end;
                  case pieceType of
                    xmlXmlDeclaration: writeXmlDeclaration(sender,inputSource.Locator,copy(content.value,3,content.length-4));
                    xmlProcessingInstruction: writeProcessingInstruction(sender,inputSource.Locator,copy(content.value,3,content.length-4));
                  end;
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
            end;

            xmlComment: begin
              content.AddWideChar(str1);
              if str1 = '>' then
                if content[content.length-1] = '-' then
                  if content[content.length-2] = '-' then
                    if content.length > 6 then begin
                      writeComment(sender,inputSource.Locator,copy(content.value,5,content.length-7));
                      content.reset;
                      PieceType:= xmlUnknown;
                    end;
            end;

            xmlCDATA: begin
              content.AddWideChar(str1);
              if str1 = '>' then
                if content[content.length-1] = ']' then
                  if content[content.length-2] = ']' then begin
                    writeCDATA(sender,inputSource.Locator,copy(content.value,10,content.length-12));
                    content.reset;
                    PieceType:= xmlUnknown;
                  end;
            end;

            xmlDoctype: begin
              content.AddWideChar(str1);
              if (SubEndMarker = '') then begin

                if (str1 = SingleQuote) and (not DoubleQuoteOpen) then begin
                  SingleQuoteOpen := not SingleQuoteOpen;
                end else if (str1 = DoubleQuote) and (not SingleQuoteOpen) then begin
                  DoubleQuoteOpen := not DoubleQuoteOpen;
                end;

                if BracketOpened then begin
                  if not (SingleQuoteOpen or DoubleQuoteOpen) then begin
                    if str1 = '<' then begin
                      SubStartMarker:= '<';
                    end else if (str1 = '!') and (SubStartMarker = '<') then begin
                      SubStartMarker:= '<!';
                    end else if (str1 = QM) and (SubStartMarker = '<') then begin
                      SubStartMarker:= '';
                      SubEndMarker:= PIEND;
                    end else if (str1 = '-') and (SubStartMarker = '<!')then begin
                      SubStartMarker:= '<!-';
                    end else if (str1 = '-') and (SubStartMarker = '<!-')then begin
                      SubStartMarker:= '';
                      SubEndMarker:= '-->';
                    end else if SubStartMarker <> '' then begin
                      SubStartMarker:= '';
                    end;
                    if (str1 = ']')
                      and (not SingleQuoteOpen)
                      and (not DoubleQuoteOpen)
                      then BracketOpened:= false;
                  end; {if not ...}
                end else begin {if BracketOpened ... }
                  if (str1 = '[')
                    and (not SingleQuoteOpen)
                    and (not DoubleQuoteOpen) then BracketOpened:= true;
                end; {if BracketOpened ... else ...}

              end else begin; {if (SubEndMarker = '') ...}
                if content.endsWith(SubEndMarker) then SubEndMarker:= '';
              end; {if (SubEndMarker = '') ... else ...}

              if (not DoubleQuoteOpen)
                and (not SingleQuoteOpen)
                and (not BracketOpened)
                and (SubEndMarker = '')
                and (str1 = '>')
                then begin
                  writeDoctype(sender,inputSource.Locator,content.value);
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
            end; {xmlDoctype: ...}
          end; {case ...}
        end; {while ...}

        if content.length > 0
          then writePCDATA(sender,inputSource.Locator,content.value);

        if assigned(contentHandler) then contentHandler.endDocument(sender);
      except
        on EConvertError do raise EParserInvalidCharacter_Err.create('Invalid character error.');
        on EReadError do raise EParserInvalidCharacter_Err.create('Invalid character error.');
      end; {try ...}
    except
      on E: EParserFatalError do
      begin
        result:= false;
        try
          if assigned(errorHandler) then errorHandler.fatalError(sender,inputSource.Locator,E,'');
        except
        end;
      end;
    end; {try}
  finally
    content.free;
  end; {try}
end;



// +++++++++++++++++ TdomStandardIntSubsetXMLReader +++++++++++++++++++
procedure TdomStandardIntSubsetXMLReader.FindNextAttDef(const Decl: wideString;
                                                        var name,
                                                            attType,
                                                            Bracket,
                                                            defaultDecl,
                                                            attValue,
                                                            Rest: wideString);
var
  i,j: integer;
  FindBracket, FindDefaultDecl, FindAttValue: boolean;
  QuoteType: WideChar;
begin
  name:= '';
  attType:= '';
  Bracket:= '';
  defaultDecl:= '';
  attValue:= '';
  Rest:= '';
  FindBracket:= false;
  FindDefaultDecl:= false;
  FindAttValue:= false;

  if Length(Decl) = 0
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  i:= 1;

  {White-space?}
  while IsXmlWhiteSpace(Decl[i]) do begin
    inc(i);
    if i > length(Decl)
      then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  end;
  j:= i;

  {name?}
  while not IsXmlWhiteSpace(Decl[i]) do begin
    inc(i);
    if i > length(Decl)
      then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  end;
  name:= copy(Decl,j,i-j);

  {White-space?}
  while IsXmlWhiteSpace(Decl[i]) do begin
    inc(i);
    if i > length(Decl)
      then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  end;
  j:= i;

  if Decl[j] = '(' then FindBracket:= true;

  {attType?}
  if not FindBracket then begin
    while not IsXmlWhiteSpace(Decl[i]) do begin
      inc(i);
      if i > length(Decl)
        then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    end;
    attType:= copy(Decl,j,i-j);
    if attType = 'NOTATION' then FindBracket:= true;

    {White-space?}
    while IsXmlWhiteSpace(Decl[i]) do begin
      inc(i);
      if i > length(Decl)
        then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    end;
    j:= i;
  end; {if ...}

  {Bracket?}
  if FindBracket then begin
    if Decl[j] <> '('
      then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    while not (Decl[i] = ')') do begin
      inc(i);
      if i >= length(Decl)
        then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    end;
    Bracket:= copy(Decl,j,i-j+1);

    {White-space?}
    inc(i);
    if not IsXmlWhiteSpace(Decl[i])
      then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    while IsXmlWhiteSpace(Decl[i]) do begin
      inc(i);
      if i > length(Decl)
        then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    end;
    j:= i;
  end; {if ...}

  if Decl[j] = '#'
    then FindDefaultDecl:= true
    else FindAttValue:= true;

  {defaultDecl?}
  if FindDefaultDecl then begin
    while not IsXmlWhiteSpace(Decl[i]) do begin
      inc(i);
      if i > length(Decl) then break;
    end; {while ...}
    defaultDecl:= copy(Decl,j,i-j);
    if defaultDecl = '#FIXED' then begin
      FindAttValue:= true;
      {White-space?}
      if i > length(Decl)
        then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
      while IsXmlWhiteSpace(Decl[i]) do begin
        inc(i);
        if i > length(Decl)
          then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
      end; {while ...}
      j:= i;
    end; {if ...}
  end; {if ...}

  {attValue?}
  if FindAttValue then begin
    if i = length(Decl)
      then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    QuoteType:= Decl[i];
    if not ( (QuoteType = '"') or (QuoteType = #$0027))
      then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    inc(i);
    while not (Decl[i] = QuoteType) do begin
      inc(i);
      if i > length(Decl)
        then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    end; {while ...}
    attValue:= copy(Decl,j+1,i-j-1);
    inc(i);
  end; {if ...}

  Rest:= copy(Decl,i,length(Decl)-i+1);
end;

procedure TdomStandardIntSubsetXMLReader.WriteProcessingInstruction(const sender: TdomCustomParser;
                                                                  const locator: TdomStandardLocator;
                                                                  const Content: wideString);
var
  TargetName,AttribSequence: wideString;
begin
  XMLAnalyseTag(content,TargetName,AttribSequence);
  if assigned(dtdHandler)
    then dtdHandler.ProcessingInstruction(sender,locator,TargetName,AttribSequence);
end;

procedure TdomStandardIntSubsetXMLReader.WriteComment(const sender: TdomCustomParser;
                                                    const locator: TdomStandardLocator;
                                                    const Content: wideString);
begin
  if assigned(dtdHandler)
    then dtdHandler.comment(sender,locator,content);
end;

procedure TdomStandardIntSubsetXMLReader.WriteParameterEntityRef(const sender: TdomCustomParser;
                                                               const locator: TdomStandardLocator;
                                                               const Content: wideString);
var
  EntityName: wideString;
begin
  EntityName:= copy(content,2,length(content)-2);
  if assigned(dtdHandler)
    then dtdHandler.parameterEntityRef(sender,locator,EntityName);
end;

procedure TdomStandardIntSubsetXMLReader.WriteEntityDeclaration(const sender: TdomCustomParser;
                                                                const locator: TdomStandardLocator;
                                                                const Content: wideString);
var
  DeclCorpus,DeclName,EntityDef,entityValue,SystemLiteral,PubidLiteral,NDataName: wideString;
  DeclTypus: TDomCMNodeType;
  dummy: wideString;
  Error: boolean;
begin
  if (copy(content,1,8) <> '<!ENTITY')
    or (content[length(content)] <> '>')
    or (length(content) < 14)
    or (not IsXmlWhiteSpace(content[9]))
    then raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
  DeclCorpus:= XMLTrunc(copy(content,10,length(content)-10));
  if DeclCorpus[1] = '%' then begin
    if not IsXmlWhiteSpace(DeclCorpus[2])
      then raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
    dummy:= XMLTrunc(copy(DeclCorpus,2,length(DeclCorpus)-1));
    DeclCorpus:= dummy;
    DeclTypus:= ctParameterEntityDeclaration;
  end else DeclTypus:= ctEntityDeclaration;
  XMLAnalyseTag(DeclCorpus,DeclName,EntityDef);
  XMLAnalyseEntityDef(EntityDef,entityValue,SystemLiteral,PubidLiteral,NDataName,Error);
  if Error then raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
  if (DeclTypus = ctParameterEntityDeclaration) and (NDataName <> '')
    then raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');

  if assigned(dtdHandler) then begin
    case DeclTypus of
      ctEntityDeclaration:
        dtdHandler.entityDeclaration(sender,locator,DeclName,entityValue,PubidLiteral,SystemLiteral,NDataName);
      ctParameterEntityDeclaration:
        dtdHandler.parameterentityDeclaration(sender,locator,DeclName,entityValue,PubidLiteral,SystemLiteral);
    end; {case ...}
  end; {if ...}
end;

procedure TdomStandardIntSubsetXMLReader.WriteElementDeclaration(const sender: TdomCustomParser;
                                                               const locator: TdomStandardLocator;
                                                               const Content: wideString);
var
  DeclCorpus,DeclName,contSpec: wideString;
begin
  if length(content) < 16
    then raise EParserInvalidElementDeclaration_Err.create('Invalid element declaration error.');
  if (copy(content,1,9) <> '<!ELEMENT')
     or (content[length(content)] <> '>')
     or (not IsXmlWhiteSpace(content[10]))
    then raise EParserInvalidElementDeclaration_Err.create('Invalid element declaration error.');
  DeclCorpus:= XMLTrunc(copy(content,11,length(content)-11));
  XMLAnalyseTag(DeclCorpus,DeclName,contSpec);
  if assigned(dtdHandler)
    then dtdHandler.elementTypeDeclaration(sender,locator,DeclName,contSpec);
end;

procedure TdomStandardIntSubsetXMLReader.WriteAttributeDeclaration(const sender: TdomCustomParser;
                                                                   const locator: TdomStandardLocator;
                                                                   const Content: wideString);
var
  declCorpus,declName,contSpec: wideString;
  dummy,AttDefName,attType,Bracket,defaultDecl,attValue,Rest: wideString;
begin
  if length(Content) < 12
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  if (copy(Content,1,9) <> '<!ATTLIST')
     or (Content[length(Content)] <> '>')
     or (not IsXmlWhiteSpace(Content[10]))
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  DeclCorpus:= XMLTrunc(copy(Content,11,length(Content)-11));
  XMLAnalyseTag(DeclCorpus,DeclName,contSpec);
  if assigned(dtdHandler)
    then dtdHandler.startAttListDeclaration(sender,locator,DeclName);
  dummy:= XMLTrunc(contSpec);
  contSpec:= dummy;
  while contSpec <> '' do begin
    FindNextAttDef(contSpec,AttDefName,attType,Bracket,
                   defaultDecl,attValue,Rest);
    if assigned(dtdHandler)
      then dtdHandler.attributeDefinition(sender,locator,attDefName,attType,bracket,
                                          defaultDecl,attValue);
    contSpec:= Rest;
  end; {while ...}
  if assigned(dtdHandler)
    then dtdHandler.endAttListDeclaration(sender,locator);
end;

procedure TdomStandardIntSubsetXMLReader.WriteNotationDeclaration(const sender: TdomCustomParser;
                                                                const locator: TdomStandardLocator;
                                                                const Content: wideString);
var
  DeclCorpus,DeclName,contSpec,SystemLiteral,PubidLiteral: wideString;
  Error: boolean;
begin
  if length(Content) < 22
    then raise EParserInvalidNotationDeclaration_Err.create('Invalid notation declaration error.');
  if (copy(Content,1,10) <> '<!NOTATION')
     or (Content[length(Content)] <> '>')
     or (not IsXmlWhiteSpace(Content[11]))
    then raise EParserInvalidNotationDeclaration_Err.create('Invalid notation declaration error.');
  DeclCorpus:= XMLTrunc(copy(Content,12,length(Content)-12));
  XMLAnalyseTag(DeclCorpus,DeclName,contSpec);
  XMLAnalyseNotationDecl(contSpec,SystemLiteral,PubidLiteral,Error);
  if Error then raise EParserInvalidNotationDeclaration_Err.create('Invalid notation declaration error.');
  if assigned(dtdHandler)
    then dtdHandler.notationDeclaration(sender,locator,DeclName,PubidLiteral,SystemLiteral);
end;

function TdomStandardIntSubsetXMLReader.parse(const sender: TdomCustomParser;
                                              const inputSource: TXmlInputSource):boolean;
const
  CR: WideChar  = #13;
  LF: WideChar  = #10;
  QM: WideChar  = '?';
  SingleQuote: WideChar = #39; // code of '
  DoubleQuote: WideChar = #34; // code of "
  PISTART: wideString = '<?';
  COMMENTSTART: wideString = '<!--';
  ENTITYSTART: wideString = '<!ENTITY';
  ELEMENTSTART: wideString = '<!ELEMENT';
  ATTLISTSTART: wideString = '<!ATTLIST';
  NOTATIONSTART: wideString = '<!NOTATION';
var
  str1: WideChar;
  SingleQuoteOpen,DoubleQuoteOpen: boolean;
  PieceType: TdomPieceType;
  content: TdomCustomStr;
begin
  result:= true;
  PieceType:= xmlUnknown;
  SingleQuoteOpen:= false;
  DoubleQuoteOpen:= false;
  content:= TdomCustomStr.create;
  try
    try
      try
        if assigned(dtdHandler) then dtdHandler.startDtd(sender,inputSource.publicId,inputSource.systemId);
        while InputSource.getNextWideChar(str1) do begin
          if not IsXmlChar(str1) then begin
            content.addWideChar(str1);
            raise EParserInvalidCharacter_Err.create('Invalid character error.');
          end;

          case PieceType of

            xmlUnknown: begin
              if str1 = '<' then begin
                PieceType:= xmlStartTag;
                content.addWideChar(str1);
                inputsource.locator.pieceStart;
              end else
              if str1 = '%' then begin
                PieceType:= xmlParameterEntityRef;
                content.addWideChar(str1);
                inputsource.locator.pieceStart;
              end else
              if not IsXmlWhiteSpace(str1) then begin;
                raise EParserInvalidCharacter_Err.create('Invalid character error.');
              end;
            end;

            xmlParameterEntityRef: begin
              content.addWideChar(str1);
              if str1 = ';' then begin
                WriteParameterEntityRef(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;
            end;

            xmlStartTag: begin
              content.addWideChar(str1);
              case content.length of
                2: if content.startsWith(PISTART) then PieceType:= xmlProcessingInstruction;
                4: if content.startsWith(COMMENTSTART) then PieceType:= xmlComment;
                8: if content.startsWith(ENTITYSTART) then PieceType:= xmlEntityDecl;
                9: if content.startsWith(ELEMENTSTART) then PieceType:= xmlElementDecl
                   else if content.startsWith(ATTLISTSTART) then PieceType:= xmlAttributeDecl;
               10: if content.startsWith(NOTATIONSTART) then PieceType:= xmlNotationDecl;
              end;

            end;

            xmlProcessingInstruction: begin
              content.addWideChar(str1);
              if str1 = '>' then
                if content[content.Length-1] = QM then begin
                  WriteProcessingInstruction(sender,inputSource.Locator,copy(content.value,3,content.length-4));
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
            end;

            xmlComment: begin
              content.addWideChar(str1);
              if str1 = '>' then
                if content[content.Length-1] = '-' then
                  if content[content.Length-2] = '-' then
                    if content.length > 6 then begin
                      WriteComment(sender,inputSource.Locator,copy(content.value,5,content.length-7));
                      content.reset;
                      PieceType:= xmlUnknown;
                    end;
            end;

            xmlEntityDecl,xmlNotationDecl: begin
              content.addWideChar(str1);

              if (str1 = SingleQuote) and (not DoubleQuoteOpen) then begin
                SingleQuoteOpen := not SingleQuoteOpen;
              end else if (str1 = DoubleQuote) and (not SingleQuoteOpen) then begin
                DoubleQuoteOpen := not DoubleQuoteOpen;
              end;

              if (not DoubleQuoteOpen)
                and (not SingleQuoteOpen)
                and (str1 = '>')
                then begin
                  if pieceType = xmlEntityDecl
                    then WriteEntityDeclaration(sender,inputSource.Locator,content.value)
                    else WriteNotationDeclaration(sender,inputSource.Locator,content.value);
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
            end;

            xmlAttributeDecl: begin
              content.addWideChar(str1);
              if str1 = '>' then begin
                WriteAttributeDeclaration(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;
            end;

            xmlElementDecl: begin
              content.addWideChar(str1);
              if str1 = '>' then begin
                WriteElementDeclaration(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;
            end;
          end; {case ...}
        end; {while ...}

        if content.length > 0
          then if not IsXmlS(content.value)
            then raise EParserUnknownDeclarationType_Err.create('Invalid declaration error.');

        if assigned(dtdHandler) then dtdHandler.endDtd(sender);
      except
        on EConvertError do raise EParserInvalidCharacter_Err.create('Invalid character error.');
        on EReadError do raise EParserInvalidCharacter_Err.create('Invalid character error.');
      end; {try ...}
    except
      on E: EParserFatalError do
      begin
        result:= false;
        try
          if assigned(errorHandler) then errorHandler.fatalError(sender,inputSource.Locator,E,content.value);
        except
        end;
      end;
    end; {try}
  finally
    content.free;
  end;
end;



// +++++++++++++++++++ TdomStandardExtSubsetXMLReader +++++++++++++++++++
procedure TdomStandardExtSubsetXMLReader.WriteTextDeclaration(const sender: TdomCustomParser;
                                                              const locator: TdomStandardLocator;
                                                              const Content: wideString);
var
  version,encoding,TargetName,AttribSequence: wideString;
  VersionAttr,EncodingAttr: TdomAttr;
  VersionIndex,EncodingIndex: integer;
  NewElement: TdomElement;
  dummyDoc: TdomDocument;
begin
  XMLAnalyseTag(content,TargetName,AttribSequence);
  if TargetName <> 'xml'
    then raise EParserInvalidTextDeclaration_Err.create('Invalid text-declaration error.');
  dummyDoc:= TdomDocument.create(nil);
  NewElement:= dummyDoc.CreateElement('dummy');
  try
    XMLAnalyseAttrSequence(AttribSequence,NewElement);
    with NewElement.Attributes do begin
      VersionAttr:= (GetNamedItem('version') as TdomAttr);
      EncodingAttr:= (GetNamedItem('encoding') as TdomAttr);
      VersionIndex:= getNamedIndex('version');
      EncodingIndex:= getNamedIndex('encoding');
      if (assigned(VersionAttr) and ((VersionIndex <> 0) or (EncodingIndex <> 1) or (Length > 2)))
        or ( (not assigned(VersionAttr)) and ( (EncodingIndex <> 0) or (Length > 1)))
        then raise EParserInvalidTextDeclaration_Err.create('Invalid text-declaration error.');
    end; {with ...}
    if assigned(VersionAttr)
      then version:= VersionAttr.value
      else version:= '';
    encoding:= EncodingAttr.value;

    if assigned(dtdHandler)
      then dtdHandler.textDeclaration(sender,locator,version,encoding);

  finally
    dummyDoc.free;
  end; {try ...}
end;

procedure TdomStandardExtSubsetXMLReader.WriteConditionalSection(const sender: TdomCustomParser;
                                                               const locator: TdomStandardLocator;
                                                               const Content: wideString);
var
  declaration: wideString;
  IncludeStmt: wideString;
  i,nr1,nr2: longint;
begin
  nr1:= 0;
  nr2:= 0;
  for i:= 1 to length(content) do begin
    if content[i] = '[' then begin
      if nr1 = 0 then nr1:= i else nr2:= i;
    end;
    if nr2 > 0 then break;
  end;
  if nr2 = 0 then raise EParserInvalidConditionalSection_Err.create('Invalid conditional section error.');
  if (copy(content,1,3) <> '<![') then raise EParserInvalidConditionalSection_Err.create('Invalid conditional section error.');
  if (copy(content,length(content)-2,3) <> ']]>') then raise EParserInvalidConditionalSection_Err.create('Invalid conditional section error.');
  IncludeStmt:= XmlTrunc(copy(content,4,nr2-4));
  if not ( IsXmlPEReference(IncludeStmt)
           or (IncludeStmt = 'INCLUDE')
           or (IncludeStmt = 'IGNORE') )
    then raise EParserInvalidConditionalSection_Err.create('Invalid conditional section error.');
  declaration:= XmlTrunc(copy(content,nr2+1,length(content)-nr2-3));
  if assigned(dtdHandler)
    then dtdHandler.conditionalSection(sender,locator,IncludeStmt,declaration);
end;

function TdomStandardExtSubsetXMLReader.includeAsPE(const sender: TdomCustomParser;
                                                    const locator: TdomStandardLocator;
                                                    const inputSource: TXmlInputSource): wideString;
begin
  result:= concat(#$20,includeInLiteral(sender,locator,inputSource),#$20);
end;

function TdomStandardExtSubsetXMLReader.includeInLiteral(const sender: TdomCustomParser;
                                                         const locator: TdomStandardLocator;
                                                         const inputSource: TXmlInputSource): wideString;
var
  str1: WideChar;
  PEName: TdomCustomStr;
  error: boolean;
begin
  result:= '';
  error:= true;
  PEName:= TdomCustomStr.create;
  try
    while InputSource.getNextWideChar(str1) do begin
      if not IsXmlChar(str1)
        then raise EParserInvalidCharacter_Err.create('Invalid character error.');
      if isXmlWhiteSpace(str1) then begin
        if PEName.length = 0 then begin
          error:= false;
          result:= concat(#$25,wideString(str1)); // No PE reference, but single % found. --> Return '%'+whitespace
          break;
        end else break; // Error found: Whitespace before semicolon.
      end;
      if str1 = ';' then begin // End of PE reference found.
        error:= false;
        if assigned(dtdHandler) then begin
          result:= concat(dtdHandler.getPEFromCurrentCMObject(PEName.value));
          break;
        end else raise ENot_Found_Err.create('Parameter entity not found.');
      end else PEName.addWideChar(str1);
    end;
  finally
    PEName.free;
  end;
  if error
    then raise ENot_Found_Err.create('Semicolon not found.');
end;

function TdomStandardExtSubsetXMLReader.parse(const sender: TdomCustomParser;
                                              const inputSource: TXmlInputSource):boolean;
const
  CR: WideChar  = #13;
  LF: WideChar  = #10;
  QM: WideChar  = '?';
  SingleQuote: WideChar = #39; // code of '
  DoubleQuote: WideChar = #34; // code of "
  PISTART: wideString = '<?';
  TEXTDECLSTART: wideString = '<?xml';
  CONTSECTSTART: wideString = '<![';
  COMMENTSTART: wideString = '<!--';
  ENTITYSTART: wideString = '<!ENTITY';
  ELEMENTSTART: wideString = '<!ELEMENT';
  ATTLISTSTART: wideString = '<!ATTLIST';
  NOTATIONSTART: wideString = '<!NOTATION';
var
  str1: WideChar;
  entityDeclValue: wideString;
  SingleQuoteOpen,DoubleQuoteOpen: boolean;
  commentActive,includeStatementFinished: boolean;
  PieceType: TdomPieceType;
  content: TdomCustomStr;
  condSectCounter: longint;
begin
  result:= true;
  PieceType:= xmlUnknown;
  SingleQuoteOpen:= false;
  DoubleQuoteOpen:= false;
  commentActive:= false;
  includeStatementFinished:= false;
  condSectCounter:= 0;
  content:= TdomCustomStr.create;
  try
    try
      try
        if assigned(dtdHandler) then dtdHandler.startDtd(sender,inputSource.Locator.publicId,inputSource.systemId);
        while InputSource.getNextWideChar(str1) do begin
          if not IsXmlChar(str1)
            then raise EParserInvalidCharacter_Err.create('Invalid character error.');

          case PieceType of

            xmlUnknown: begin
              if str1 = '<' then begin
                PieceType:= xmlStartTag;
                content.addWideChar(str1);
                inputsource.locator.pieceStart;
              end else
              if str1 = '%' then begin
                PieceType:= xmlParameterEntityRef;
                content.addWideChar(str1);
                inputsource.locator.pieceStart;
              end else
              if not IsXmlWhiteSpace(str1) then begin;
                raise EParserInvalidCharacter_Err.create('Invalid character error.');
              end;
            end;

            xmlParameterEntityRef: begin
              content.addWideChar(str1);
              if str1 = ';' then begin
                WriteParameterEntityRef(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;
            end;

            xmlStartTag: begin
              content.addWideChar(str1);
              case content.length of
                2: if content.startsWith(PISTART) then PieceType:= xmlProcessingInstruction;
                3: if content.startsWith(CONTSECTSTART) then begin
                     PieceType:= xmlCondSection;
                     condSectCounter:= 1;
                     commentActive:= false;
                     includeStatementFinished:= false;
                   end;
                4: if content.startsWith(COMMENTSTART) then PieceType:= xmlComment;
                8: if content.startsWith(ENTITYSTART) then PieceType:= xmlEntityDecl;
                9: if content.startsWith(ELEMENTSTART) then PieceType:= xmlElementDecl
                   else if content.startsWith(ATTLISTSTART) then PieceType:= xmlAttributeDecl;
               10: if content.startsWith(NOTATIONSTART) then PieceType:= xmlNotationDecl;
              end;

            end;

            xmlProcessingInstruction: begin
              content.addWideChar(str1);
              if str1 = '>' then
                if content[content.length-1] = QM then begin
                  if (content.length > 5) then
                    if IsXmlWhiteSpace(content[6]) then
                      if content.startsWith(TEXTDECLSTART)
                        then begin
                          PieceType:= xmlTextDeclaration;
                          if (inputSource.Locator.startColumnNumber <> 1)
                            or (inputSource.Locator.startLineNumber <> 1)
                            then raise EParserInvalidTextDeclaration_Err.create('Character(s) before text-declaration error.');
                        end;
                  if PieceType = xmlTextDeclaration
                    then WriteTextDeclaration(sender,inputSource.Locator,copy(content.value,3,content.length-4))
                    else WriteProcessingInstruction(sender,inputSource.Locator,copy(content.value,3,content.length-4));
                  content.reset;
                  PieceType:= xmlUnknown;
                end;
            end;

            xmlCondSection: begin
              if includeStatementFinished then begin
                content.addWideChar(str1);
                if str1 = '[' then begin
                  if content[content.length-1] = '!' then
                    if content[content.length-2] = '<' then
                      if not commentActive then inc(condSectCounter);
                end else if str1 = '>' then begin
                  if content[content.length-1] = ']' then
                    if content[content.length-2] = ']' then
                      if not commentActive then dec(condSectCounter);
                end; {if str1 = '[' ... else ...}

                if commentActive then begin
                  if str1 = '>' then
                    if content[content.length-1] = '-' then
                      if content[content.length-2] = '-' then
                        if not ( (content[content.length-3] = '!')
                                 and (content[content.length-4] = '<') ) then
                          if not ( (content[content.length-3] = '-')
                                    and (content[content.length-4] = '!')
                                    and (content[content.length-5] = '<') )
                            then commentActive:= false;
                end else begin
                  if str1 = '-' then
                    if content[content.length-1] = '-' then
                      if content[content.length-2] = '!' then
                        if content[content.length-3] = '<'
                          then commentActive:= true;
                end; {if commentActive ... else ...}

                if condSectCounter = 0 then begin
                  WriteConditionalSection(sender,inputSource.Locator,content.value);
                  content.reset;
                  PieceType:= xmlUnknown;
                end; {if ...}

              end else begin {if includeStatementFinished ... }
                if str1 = '['
                  then includeStatementFinished:= true;
                if str1 = '%'
                  then content.addWideString(includeAsPE(sender,inputSource.Locator,inputSource))
                  else content.addWideChar(str1);
              end; {if includeStatementFinished ... else ...}
            end;

            xmlComment: begin
              content.addWideChar(str1);
              if str1 = '>' then
                if content[content.Length-1] = '-' then
                  if content[content.Length-2] = '-' then
                    if content.length > 6 then begin
                      WriteComment(sender,inputSource.Locator,copy(content.value,5,content.length-7));
                      content.reset;
                      PieceType:= xmlUnknown;
                    end;
            end;

            xmlEntityDecl,xmlNotationDecl: begin
              if not (DoubleQuoteOpen or SingleQuoteOpen) then begin
                if str1 = '%'
                  then content.addWideString(includeAsPE(sender,inputSource.Locator,inputSource))
                  else content.addWideChar(str1);
              end else begin
                if (PieceType = xmlEntityDecl) and (str1 = '%') then begin
                    // XML 1.0, � 4.4.5: "When ... a parameter entity
                    // reference appears in a literal entity value, its
                    // replacement text is processed in place of the
                    // reference itself as though it were part of the
                    // document at the location the reference was
                    // recognized, except that ...
                  entityDeclValue:= includeInLiteral(sender,inputSource.Locator,inputSource);
                  content.addWideString(
                    // ... a single or double quote character in the
                    // replacement text is always treated as a normal
                    // data character and will not terminate the literal."
                    xmlReplaceQuotes(entityDeclValue)
                    );
                end else content.addWideChar(str1);
              end;

              if (str1 = SingleQuote) and (not DoubleQuoteOpen) then begin
                SingleQuoteOpen := not SingleQuoteOpen;
              end else if (str1 = DoubleQuote) and (not SingleQuoteOpen) then begin
                DoubleQuoteOpen := not DoubleQuoteOpen;
              end;

              if (not DoubleQuoteOpen)
                and (not SingleQuoteOpen)
                and (str1 = '>')
              then begin
                if pieceType = xmlEntityDecl
                  then WriteEntityDeclaration(sender,inputSource.Locator,content.value)
                  else WriteNotationDeclaration(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;

            end;

            xmlAttributeDecl: begin

              if not (DoubleQuoteOpen or SingleQuoteOpen) then begin
                if str1 = '%'
                  then content.addWideString(includeAsPE(sender,inputSource.Locator,inputSource))
                  else content.addWideChar(str1);
              end else content.addWideChar(str1);

              if (str1 = SingleQuote) and (not DoubleQuoteOpen) then begin
                SingleQuoteOpen := not SingleQuoteOpen;
              end else if (str1 = DoubleQuote) and (not SingleQuoteOpen) then begin
                DoubleQuoteOpen := not DoubleQuoteOpen;
              end;

              if str1 = '>' then begin
                WriteAttributeDeclaration(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;

            end;

            xmlElementDecl: begin
              if str1 = '%'
                then content.addWideString(includeAsPE(sender,inputSource.Locator,inputSource))
                else content.addWideChar(str1);
              if str1 = '>' then begin
                WriteElementDeclaration(sender,inputSource.Locator,content.value);
                content.reset;
                PieceType:= xmlUnknown;
              end;
            end;
          end; {case ...}
        end; {while ...}

        if content.length > 0
          then if not IsXmlS(content.value)
            then raise EParserUnknownDeclarationType_Err.create('Invalid declaration error.');

        if assigned(dtdHandler) then dtdHandler.endDtd(sender);
      except
        on EConvertError do raise EParserInvalidCharacter_Err.create('Invalid character error.');
        on EReadError do raise EParserInvalidCharacter_Err.create('Invalid character error.');
      end; {try ...}
    except
      on E: EParserFatalError do
      begin
        result:= false;
        try
          if assigned(errorHandler) then errorHandler.fatalError(sender,inputSource.Locator,E,content.value);
        except
        end;
      end;
    end; {try}
  finally
    content.free;
  end;
end;



// ++++++++++++++++++++++ TdomStandardErrorHandler +++++++++++++++++++++
constructor TdomStandardErrorHandler.create;
begin
  inherited create;
  FErrorList:= TList.create;
end;

destructor TdomStandardErrorHandler.destroy;
begin
  clearErrorList;
  FErrorList.free;
  inherited destroy;
end;

procedure TdomStandardErrorHandler.clearErrorList;
var
  i: integer;
begin
  with FErrorList do begin
    for i:= 0 to count -1 do
      if assigned(Items[i]) then TXmlParserError(Items[i]).free;
    clear;
  end;
end;

procedure TdomStandardErrorHandler.error(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const e: EParserException;
                                         const code: wideString);
var
  sln,scn,ln,cn: integer;
  pubId,sysId: wideString;
begin
  if assigned(locator) then begin
    with locator do begin
      sln:= startLineNumber;
      scn:= startColumnNumber;
      ln:= lineNumber;
      cn:= columnNumber;
      pubId:= publicId;
      sysId:= systemId;
    end;
  end else begin
    sln:= 0;
    scn:= 0;
    ln:= 0;
    cn:= 0;
    pubId:= '';
    sysId:= '';
  end;
  FErrorList.Add(TXmlParserError.create(e,sln,scn,ln,cn,pubId,sysId,code));
  inherited error(sender,locator,e,code);
end;

procedure TdomStandardErrorHandler.fatalError(const sender: TdomCustomParser;
                                              const locator: TdomStandardLocator;
                                              const e: EParserException;
                                              const code: wideString);
var
  sln,scn,ln,cn: integer;
  pubId,sysId: wideString;
begin
  if assigned(locator) then begin
    with locator do begin
      sln:= startLineNumber;
      scn:= startColumnNumber;
      ln:= lineNumber;
      cn:= columnNumber;
      pubId:= publicId;
      sysId:= systemId;
    end;
  end else begin
    sln:= 0;
    scn:= 0;
    ln:= 0;
    cn:= 0;
    pubId:= '';
    sysId:= '';
  end;
  FErrorList.Add(TXmlParserError.create(e,sln,scn,ln,cn,pubId,sysId,code));
  inherited fatalError(sender,locator,e,code);
end;

procedure TdomStandardErrorHandler.warning(const sender: TdomCustomParser;
                                           const locator: TdomStandardLocator;
                                           const e: EParserException;
                                           const code: wideString);
var
  sln,scn,ln,cn: integer;
  pubId,sysId: wideString;
begin
  if assigned(locator) then begin
    with locator do begin
      sln:= startLineNumber;
      scn:= startColumnNumber;
      ln:= lineNumber;
      cn:= columnNumber;
      pubId:= publicId;
      sysId:= systemId;
    end;
  end else begin
    sln:= 0;
    scn:= 0;
    ln:= 0;
    cn:= 0;
    pubId:= '';
    sysId:= '';
  end;
  FErrorList.Add(TXmlParserError.create(e,sln,scn,ln,cn,pubId,sysId,code));
  inherited warning(sender,locator,e,code);
end;



// ++++++++++++++++++++++ TdomStandardDocBuilder ++++++++++++++++++++++
constructor TdomStandardDocBuilder.create;
begin
  inherited create;
  FReferenceNode:= nil;
  FRefNode:= nil;
  FRefDocument:= nil;
end;

procedure TdomStandardDocBuilder.comment(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const data: wideString);
var
  newComment: TdomComment;
  dataLength: integer;
begin
  if not assigned(FRefNode) then exit;
  if pos('--',data) > 0
    then raise EParserInvalidCharacter_Err.create('Invalid character error.');
  dataLength:= length(data);
  if dataLength > 0
    then if WideChar(data[dataLength]) = '-'
      then raise EParserInvalidCharacter_Err.create('Invalid character error.');
  try
    newComment:= FRefNode.OwnerDocument.CreateComment(data);
    try
      FRefNode.appendChild(newComment);
    except
      if assigned(newComment.ParentNode)
        then newComment.ParentNode.RemoveChild(newComment);
      FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newComment));
      raise;
    end; {try ...}
  except
    raise EParserInvalidCharacter_Err.create('Invalid character error.');
  end; {try ...}
end;

procedure TdomStandardDocBuilder.CDATA(const sender: TdomCustomParser;
                                       const locator: TdomStandardLocator;
                                       const data: wideString);
var
  newCData: TdomCDATASection;
begin
  if not assigned(FRefNode) then exit;
  if not IsXmlCData(data)
    then raise EParserInvalidCharacter_Err.create('Invalid character error.');
  try
    newCData:= FRefNode.OwnerDocument.CreateCDATASection(data);
    try
      FRefNode.appendChild(newCData);
    except
      if assigned(newCData.ParentNode)
        then newCData.ParentNode.RemoveChild(newCData);
      FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newCData));
      raise;
    end; {try ...}
  except
    raise EParserInvalidCharacter_Err.create('Invalid character error.');
  end; {try ...}
end;

procedure TdomStandardDocBuilder.charRef(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const data: wideString);
var
  newText: TdomText;
  previousNode: TdomNode;
  value: wideString;
  previousNodeIsText: boolean;
begin
  if not assigned(FRefNode) then exit;
  try
    value:= XmlCharRefToStr(data);
  except
    on EConvertError do
      raise EParserInvalidCharRef_Err.create('Invalid character reference error.');
  end;

  previousNode:= FRefNode.LastChild;
  if assigned(previousNode) then begin
    if (previousNode.NodeType = ntText_Node)
      then previousNodeIsText:= true
      else previousNodeIsText:= false;
  end else previousNodeIsText:= false;

  if previousNodeIsText
    then (previousNode as TdomText).appendData(value)
    else begin
      try
        newText:= FRefNode.OwnerDocument.CreateTextNode(value);
        try
          FRefNode.appendChild(newText);
        except
          if assigned(newText.ParentNode)
            then newText.ParentNode.RemoveChild(newText);
          FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newText));
          raise;
        end; {try ...}
      except
        raise EParserInvalidCharacter_Err.create('Invalid character error.');
      end; {try ...}
    end;
end;

procedure TdomStandardDocBuilder.doctype(const sender: TdomCustomParser;
                                         const locator: TdomStandardLocator;
                                         const name,
                                               pubId,
                                               sysId,
                                               data: wideString);
var
  newDocType: TdomDocumentType;
begin
  if not assigned(FRefNode) then exit;
  if (FRefNode.NodeType <> ntDocument_Node)
    or assigned((FRefNode as TdomDocument).DocumentElement)
    then raise EParserWrongOrder_Err.create('Wrong order declaration error.');
  if assigned((FRefNode as TdomDocument).Doctype)
    then raise EParserDoubleDoctype_Err.create('Double doctype declaration error.');
  try
    newDocType:= FRefNode.OwnerDocument.CreateDocumentType(name,pubId,sysId,data);
  except
    raise EParserInvalidDoctype_Err.create('Invalid doctype declaration error.');
  end; {try ...}

  FRefNode.appendChild(newDocType);

  try
    if (sender is TXmlToDomParser)
      then TXmlToDomParser(sender).parseDtd(locator,name,pubId,sysId,data,(FRefNode.OwnerDocument.standalone = 'yes'));
  except
    on E: EParserException do
    begin
      raise;
    end
    else
      raise EParserInvalidDoctype_Err.create('Invalid doctype declaration error.');
  end;

end;

procedure TdomStandardDocBuilder.endDocument;
begin
  if not assigned(FRefNode) then exit;
  if FRefNode <> FReferenceNode
    then raise EParserMissingEndTag_Err.create('Missing end tag error.');
  if FReferenceNode.NodeType = ntDocument_Node
    then if not assigned(TdomDocument(FReferenceNode).DocumentElement)
      then raise EParserRootNotFound_Err.create('Root not found error.');
end;

procedure TdomStandardDocBuilder.endElement(const sender: TdomCustomParser;
                                            const locator: TdomStandardLocator;
                                            const namespaceURI,
                                                  localName,
                                                  tagName: wideString);
begin
  if not assigned(FRefNode) then exit;
  if not IsXmlName(tagName) then
    raise EParserInvalidElementName_Err.create('Invalid element name error.');
  if not (FRefNode.nodeType = ntElement_Node)
    then raise EParserMissingStartTag_Err.create('Missing start tag error.');
  if tagName <> FRefNode.NodeName
    then raise EParserMissingStartTag_Err.create('Missing start tag error.');
  FRefNode:= FRefNode.ParentNode;
end;

procedure TdomStandardDocBuilder.endPrefixMapping(const sender: TdomCustomParser;
                                                  const locator: TdomStandardLocator;
                                                  const prefix: wideString);
begin
  // Do nothing.
end;

procedure TdomStandardDocBuilder.entityRef(const sender: TdomCustomParser;
                                           const locator: TdomStandardLocator;
                                           const name: wideString);
var
  newEntityRef: TdomEntityReference;
begin
  if not assigned(FRefNode) then exit;
  try
    newEntityRef:= FRefNode.OwnerDocument.CreateEntityReference(name);
    try
      FRefNode.appendChild(newEntityRef);
    except
      if assigned(newEntityRef.ParentNode)
        then newEntityRef.ParentNode.RemoveChild(newEntityRef);
      FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newEntityRef));
      raise;
    end; {try ...}
  except
    raise EParserInvalidEntityName_Err.create('Invalid entity name error.');
  end; {try ...}
end;

procedure TdomStandardDocBuilder.PCDATA(const sender: TdomCustomParser;
                                        const locator: TdomStandardLocator;
                                        const data: wideString);
var
  newPcdata: TdomText;
begin
  if not assigned(FRefNode) then exit;
  if FRefNode.NodeType = ntDocument_Node then
    if IsXmlS(data)
      then exit
      else raise EParserNotInRoot_Err.create('Not in root error.');
  if not IsXmlCharData(data)
    then raise EParserInvalidCharacter_Err.create('Invalid character error.');
  if assigned(FRefNode.LastChild) and (FRefNode.LastChild.NodeType = ntText_Node)
    then (FRefNode.LastChild as TdomText).appendData(data)
    else begin
      try
        newPcdata:= FRefNode.OwnerDocument.CreateTextNode(data);
        try
          FRefNode.appendChild(newPcdata);
        except
          if assigned(newPcdata.ParentNode)
            then newPcdata.ParentNode.RemoveChild(newPcdata);
          FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newPcdata));
          raise;
        end; {try ...}
      except
        raise EParserInvalidCharacter_Err.create('Invalid character error.');
      end; {try ...}
   end;
end;

procedure TdomStandardDocBuilder.processingInstruction(const sender: TdomCustomParser;
                                                       const locator: TdomStandardLocator;
                                                       const targ,
                                                             data : wideString);
var
  newPI: TdomProcessingInstruction;
begin
  if not assigned(FRefNode) then exit;
  try
    newPI:= FRefNode.OwnerDocument.CreateProcessingInstruction(targ,data);
    try
      FRefNode.appendChild(newPI);
    except
      if assigned(newPI.ParentNode)
        then newPI.ParentNode.RemoveChild(newPI);
      FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newPI));
      raise;
    end;
  except
    raise EParserInvalidProcessingInstruction_Err.create('Invalid processing instruction error.');
  end;
end;

procedure TdomStandardDocBuilder.skippedEntity(const sender: TdomCustomParser;
                                               const locator: TdomStandardLocator;
                                               const name: wideString);
begin
end;

procedure TdomStandardDocBuilder.startDocument(const sender: TdomCustomParser;
                                               const locator: TdomStandardLocator;
                                                     defaultRoot: wideString);
begin
  if defaultRoot = '' then defaultRoot:= 'default';
  // Note that 'default' cannot be used as a registered document format.

  if (not assigned(FReferenceNode)) and (sender is TXmlToDomParser) then begin
    FRefDocument:= TXmlToDomParser(sender).DOMImpl.createDocument(defaultRoot,nil);
    FReferenceNode:= FRefDocument;
    FReferenceNode.Clear;  // Delete the dummy root element
  end else FRefDocument:= nil;
  FRefNode:= FReferenceNode;

  if FRefNode.nodeType = ntDocument_Node then begin
    FXMLDeclarationAllowed:= true;
    if assigned(locator)
      then (FRefNode as TdomDocument).systemId:= locator.systemId
      else (FRefNode as TdomDocument).systemId:= '';
  end else FXMLDeclarationAllowed:= false;
end;

procedure TdomStandardDocBuilder.startElement(const sender: TdomCustomParser;
                                              const locator: TdomStandardLocator;
                                              const namespaceURI,
                                                    localName,
                                                    tagName: wideString;
                                                    attributes: TdomNameValueList);
var
  newElement: TdomElement;
  i,j: integer;
  name,value,text,characRef,v: wideString;
  Attri: TdomAttr;
  isEntity: boolean;
begin
  if not assigned(FRefNode) then exit;
  if not IsXmlName(tagName) then
    raise EParserInvalidElementName_Err.create('Invalid element name error.');
  if (FRefNode.NodeType = ntDocument_Node) then
    if assigned((FRefNode as TdomDocument).DocumentElement)
      then raise EParserDoubleRootElement_Err.create('Double root element error.');
  try
    newElement:= FRefNode.OwnerDocument.CreateElement(tagName);
  except
    raise EInternalParserException.create('Internal Parser Exception in TdomStandardDocBuilder.startElement');
  end;

  try
    for i:= 0 to pred(attributes.length) do begin
      value:= attributes.values[i];
      name:= attributes.names[i];
      if not IsXmlName(name) then
        raise EParserInvalidAttributeName_Err.create('Invalid attribute name error.');
      if pos('&',value) = 0 then begin
        if not IsXmlCharData(value)
          then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
        newElement.setAttribute(name,value);
      end else begin
        Attri:= newElement.OwnerDocument.CreateAttribute(name);
        newElement.SetAttributeNode(Attri);
        isEntity:= false;
        text:= '';
        for j:= 1 to Length(value) do begin
          if IsEntity then begin
            if value[j] = ';' then begin
              if text[1] = '#' then begin {CharRef}
              try
                CharacRef:= concat(wideString('&'),text,wideString(';'));
                v:= XmlCharRefToStr(CharacRef);
                if assigned(Attri.LastChild) and (Attri.LastChild.NodeType = ntText_Node)
                  then (Attri.LastChild as TdomText).appendData(v)
                  else Attri.appendChild(newElement.OwnerDocument.CreateTextNode(v));
              except
                on EConvertError do
                  raise EParserInvalidCharRef_Err.create('Invalid character reference error.');
              end; {try}
              end else begin
                if not IsXmlName(text)
                  then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
                Attri.appendChild(newElement.OwnerDocument.CreateEntityReference(text));
              end;
              text:= '';
              IsEntity:= false;
            end else Text:= concat(text,wideString(value[j]));
          end else begin
            if value[j] = '&' then begin
              if text <> '' then begin
                // invalid attribute value?
                if not IsXmlCharData(text)
                  then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
                Attri.appendChild(newElement.OwnerDocument.CreateTextNode(text));
              end;
              text:= '';
              IsEntity:= true;
            end else Text:= concat(text,wideString(value[j]));
          end; {if ...}
        end; {for ...}
        // invalid attribute value?
        if IsEntity
          then raise EParserInvalidAttributeValue_Err.create('Invalid attribute value error.');
        if text <> '' then Attri.appendChild(newElement.OwnerDocument.CreateTextNode(text));
      end; {if ...}
    end;
    FRefNode.appendChild(newElement);
  except
    if assigned(newElement.ParentNode)
      then newElement.ParentNode.RemoveChild(newElement);
    FRefNode.OwnerDocument.FreeAllNodes(TdomNode(newElement));
    raise;
  end; {try ...}

  FRefNode:= newElement;
end;

procedure TdomStandardDocBuilder.startPrefixMapping(const sender: TdomCustomParser;
                                                    const locator: TdomStandardLocator;
                                                    const prefix,
                                                          uri: wideString);
begin
end;

procedure TdomStandardDocBuilder.xmlDeclaration(const sender: TdomCustomParser;
                                                const locator: TdomStandardLocator;
                                                const version,
                                                      encDl,
                                                      sdDl: wideString);
begin
  if not assigned(FRefNode) then exit;
  if (FRefNode.nodeType <> ntDocument_Node)
    or (FRefNode.HasChildNodes)
    or not FXMLDeclarationAllowed
    then raise EParserWrongOrder_Err.create('Wrong order error.');
  if not (IsXmlEncName(EncDl) or (EncDl = ''))
    then raise EParserInvalidXmlDeclaration_Err.create('Invalid xml-declaration error.');
  if not ((SdDl = 'yes') or (SdDl = 'no') or (SdDl = ''))
    then raise EParserInvalidXmlDeclaration_Err.create('Invalid xml-declaration error.');
  if not IsXmlVersionNum(Version)
    then raise EParserInvalidXmlDeclaration_Err.create('Invalid xml-declaration error.');

  FXMLDeclarationAllowed:= false;
  (FRefNode as TdomDocument).version:= version;
  (FRefNode as TdomDocument).standalone:= SdDl;
  (FRefNode as TdomDocument).encoding:= encDl;
end;



// ++++++++++++++++++++ TdomDTDContentModelHandler ++++++++++++++++++++
procedure TdomDTDContentModelHandler.insertMixedContent(const sender: TdomCustomParser;
                                                        const refNode: TdomCMNode;
                                                        const contSpec: wideString);
var
  freq, dummy, content,piece: wideString;
  separator: integer;
  Error: boolean;
  newNode: TdomCMNode;
begin
  content:= XMLTrunc(contSpec);
  freq:= '';
  if (content[length(content)] = '*') then begin
    freq:= '*';
    dummy:= copy(content,1,length(content)-1);
    content:= dummy;
  end;
  if length(content) = 0
    then raise EParserException.create('Parser error.');
  if wideChar(content[length(content)]) <> ')'
    then raise EParserException.create('Parser error.');
  XMLTruncRoundBrackets(content,dummy,Error);
  if Error or (dummy = '')
    then raise EParserException.create('Parser error.');
  content:= dummy;
  newNode:= refNode.appendChild(refNode.OwnerCMObject.CreateCMPcdataChoiceParticle);
  if content = '#PCDATA' then exit;
  if freq = '' then raise EParserException.create('Parser error.');
  separator:= pos(wideString('|'),content);
  if separator = 0 then raise EParserException.create('Parser error.');
  dummy:= XMLTrunc(copy(content,separator+1,length(content)-separator));
  content:= dummy;
  while content <> '' do begin
    separator:= pos(wideString('|'),content);
    if separator = 0 then begin
      piece:= content;
      content:= '';
    end else begin
      piece:= XMLTrunc(copy(content,1,separator-1));
      dummy:= XMLTrunc(copy(content,separator+1,length(content)-separator));
      content:= dummy;
      if content = '' then raise EParserException.create('Parser error.');
    end; {if ...}
    if not IsXmlName(piece) then raise EParserException.create('Parser error.');
    newNode.appendChild(newNode.OwnerCMObject.CreateCMElementParticle(piece,''));
  end; {while ...}
end;

procedure TdomDTDContentModelHandler.insertChildrenContent(const sender: TdomCustomParser;
                                                           const refNode: TdomCMNode;
                                                           const contSpec: wideString);
var
  piece,dummy,content,freq: wideString;
  SeparatorChar: WideChar;
  j,i,bracketNr: integer;
  newNode: TdomCMNode;
  Error: boolean;
begin
  content:= XMLTrunc(contSpec);
  freq:= '';
  if (content[length(content)] = WideChar('?')) or
     (content[length(content)] = WideChar('*')) or
     (content[length(content)] = WideChar('+')) then begin
    freq:= content[length(content)];
    dummy:= copy(content,1,length(content)-1);
    content:= dummy;
  end;
  if length(content) = 0
    then raise EParserException.create('Parser error.');
  if wideChar(content[length(content)]) <> ')'
    then raise EParserException.create('Parser error.');
  XMLTruncRoundBrackets(content,dummy,Error);
  if Error or (dummy = '')
    then raise EParserException.create('Parser error.');
  content:= dummy;

  bracketNr:= 0;
  SeparatorChar:= ',';
  for i:= 1 to length(content) do begin
    if (content[i] = ',') and (bracketNr = 0) then begin
      SeparatorChar:= ',';
      break;
    end; {if ...}
    if (content[i] = '|') and (bracketNr = 0) then begin
      SeparatorChar:= '|';
      break;
    end; {if ...}
    if content[i] = '(' then inc(bracketNr);
    if content[i] = ')' then begin
      if bracketNr = 0 then raise EParserException.create('Parser error.');
      dec(bracketNr);
    end;
  end; {for ...}

  if SeparatorChar = '|'
    then newNode:= refNode.appendChild(refNode.OwnerCMObject.CreateCMChoiceParticle(freq))
    else newNode:= refNode.appendChild(refNode.OwnerCMObject.CreateCMSequenceParticle(freq));

  bracketNr:= 0;
  i:= 0;
  j:= 1;
  while i < length(content) do begin
    inc(i);
    if content[i] = '(' then inc(bracketNr);
    if content[i] = ')' then begin
      if bracketNr = 0 then raise EParserException.create('Parser error.');
      dec(bracketNr);
    end;
    if ((content[i] = SeparatorChar) and (bracketNr = 0)) or
       (i = length(content)) then begin
      if bracketNr > 0 then raise EParserException.create('Parser error.');
      if i = length(content)
        then piece:= XmlTrunc(copy(content,j,i+1-j))
        else piece:= XmlTrunc(copy(content,j,i-j));
      j:= i+1;

      if piece[1] = '(' then begin
        insertChildrenContent(sender,NewNode,piece);
      end else begin
        freq:= '';
        if (piece[length(piece)] = wideChar('?')) or
           (piece[length(piece)] = wideChar('*')) or
           (piece[length(piece)] = wideChar('+')) then begin
          freq:= piece[length(piece)];
          dummy:= copy(piece,1,length(piece)-1);
          piece:= dummy;
        end;
        if not IsXmlName(piece)
          then raise EParserException.create('Parser error.');
        NewNode.appendChild(refNode.OwnerCMObject.CreateCMElementParticle(piece,freq));
      end; {if ...}

    end; {if ...}
  end; {while ...}

end;

procedure TdomDTDContentModelHandler.insertNotationOrEnumerationContent(const sender: TdomCustomParser;
                                                                        const refCMAttribute: TdomCMAttribute;
                                                                        const contSpec: wideString);
var
  dummy,content,piece: wideString;
  separator: integer;
  Error: boolean;
begin
  XMLTruncRoundBrackets(contSpec,content,Error);
  if Error or (content = '')
    then raise EParserException.create('Parser error.');
  while content <> '' do begin
    separator:= pos(wideString('|'),content);
    if separator = 0 then begin
      piece:= content;
      content:= '';
    end else begin
      piece:= XMLTrunc(copy(content,1,separator-1));
      dummy:= XMLTrunc(copy(content,separator+1,length(content)-separator));
      content:= dummy;
      if content = '' then raise EParserException.create('Parser error.');
    end; {if ...}
    if refCMAttribute.attributeType = 'NOTATION' then begin
      if not IsXmlName(piece) then raise EParserException.create('Parser error.');
      refCMAttribute.appendChild(refCMAttribute.OwnerCMObject.CreateCMNameParticle(piece));
    end else begin
      if not IsXmlNmtoken(piece) then raise EParserException.create('Parser error.');
      refCMAttribute.appendChild(refCMAttribute.OwnerCMObject.CreateCMNmtokenParticle(piece));
    end;
  end; {while ...}
end;

procedure TdomDTDContentModelHandler.CDataNormalization(const s: wideString;
                                                          var result: wideString;
                                                          var error: boolean);
const
  TAB:       WideChar = #$9;   // Horizontal Tabulation
  LF:        WideChar = #$A;   // Line Feed
  CR:        WideChar = #$D;   // Carriage Return
  SPACE:     WideChar = #$20;  // ' '
var
  i,j,indexpos: integer;
  SChar, SChar2: widechar;
  name,ref: wideString;
  content: TdomCustomStr;
  Entity: TdomCMEntity;
begin
  Result:= '';
  Error:= false;
  content:= TdomCustomStr.create;
  try
    i:= 1;
    while i <= length(S) do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if IsUtf16LowSurrogate(sChar)
        then raise EConvertError.CreateFmt('%S must not start with a UTF-16 low surrogate.',[S]);
      if IsUtf16HighSurrogate(SChar) then begin
        if i+1 > length(s)
          then raise EConvertError.CreateFmt('%S must not end with a UTF-16 high surrogate.',[S]);
        inc(i);
        content.addWideChar(SChar);
        SChar:= WideChar((PWideChar(S)+i-1)^);
        if not IsUtf16LowSurrogate(SChar)
          then raise EConvertError.CreateFmt('%S contains an UTF-16 high surrogate without its corresponding low surrogate.',[S]);
      end;
      if not IsXmlChar(sChar)
        then raise EConvertError.CreateFmt('%S contains an invalid character.',[S]);
      if SChar = '&' then begin // Reference?
        indexpos:= -1;
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = ';' then begin indexpos:= j; break; end;
        end;
        if indexpos = -1
          then raise EConvertError.CreateFmt('%S contains an ''&'' without a '';''.',[S]);
        ref:= copy(S,i,j-i+1);
        if IsXmlEntityRef(ref) then begin
          name:= copy(ref,2,length(ref)-2);
          Entity:= FContentModel.Entities.GetNamedItem(name);
          if assigned(Entity) then begin
              try
                content.addWideString(Entity.normalizedValue);
              except
                error:= true;
              end;
            end else begin
              content.addWideString(ref);
              error:= true;
            end;
        end else if IsXmlCharRef(ref) then begin
          content.addWideString(XmlCharRefToStr(ref));
        end else raise EConvertError.CreateFmt('%S contains an invalid reference.',[S]);
        i:= j;
      end else if (SChar = TAB) or (SChar = LF) or (SChar = CR) // White space?
        then content.addWideChar(SPACE)
        else content.addWideChar(SChar);
      inc(i);
    end; {while ...}
    Result:= content.value;
  finally
    content.free;
  end;
end;

procedure TdomDTDContentModelHandler.ResolveCharRefsAndPERefs(const s: wideString;
                                                                var result: wideString;
                                                                var error: boolean);
var
  i,j,indexpos: integer;
  SChar, SChar2: widechar;
  name,ref: wideString;
  content: TdomCustomStr;
  PEntity: TdomCMParameterEntity;
begin
  Result:= '';
  Error:= false;
  content:= TdomCustomStr.create;
  try
    i:= 1;
    while i <= length(S) do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if IsUtf16LowSurrogate(sChar)
        then raise EConvertError.CreateFmt('%S must not start with a UTF-16 low surrogate.',[S]);
      if IsUtf16HighSurrogate(SChar) then begin
        if i+1 > length(s)
          then raise EConvertError.CreateFmt('%S must not end with a UTF-16 high surrogate.',[S]);
        inc(i);
        content.addWideChar(SChar);
        SChar:= WideChar((PWideChar(S)+i-1)^);
        if not IsUtf16LowSurrogate(SChar)
          then raise EConvertError.CreateFmt('%S contains an UTF-16 high surrogate without its corresponding low surrogate.',[S]);
      end;
      if not IsXmlChar(sChar)
        then raise EConvertError.CreateFmt('%S contains an invalid character.',[S]);
      if SChar = '&' then begin {Reference?}
        indexpos:= -1;
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = ';' then begin indexpos:= j; break; end;
        end;
        if indexpos = -1
          then raise EConvertError.CreateFmt('%S contains an ''&'' without a '';''.',[S]);
        ref:= copy(S,i,j-i+1);
        if IsXmlEntityRef(ref) then begin
          content.addWideString(ref);
        end else if IsXmlCharRef(ref) then begin
          content.addWideString(XmlCharRefToStr(ref));
        end else raise EConvertError.CreateFmt('%S contains an invalid reference.',[S]);
        i:= j;
      end else if SChar = '%' then begin {PEReference?}
        indexpos:= -1;
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = ';' then begin indexpos:= j; break; end;
        end;
        if indexpos = -1
          then raise EConvertError.CreateFmt('%S contains an ''%'' without a '';''.',[S]);
        ref:= copy(S,i,j-i+1);
        if IsXmlPEReference(ref) then begin
          name:= copy(ref,2,length(ref)-2);
          PEntity:= (FContentModel.parameterEntities.GetNamedItem(name) as TdomCMParameterEntity);
          if assigned(PEntity) then begin
              content.addWideString(PEntity.NodeValue);
              if PEntity.isUnusable then error:= true;
            end else begin
              content.addWideString(ref);
              error:= true;
            end;
        end else raise EConvertError.CreateFmt('%S contains an invalid parameter entity reference.',[S]);
        i:= j;
      end else content.addWideChar(SChar);
      inc(i);
    end; {while ...}
    Result:= content.value;
  finally
    content.free;
  end;
end;

procedure TdomDTDContentModelHandler.attributeDefinition(const sender: TdomCustomParser;
                                                         const locator: TdomStandardLocator;
                                                         const name,
                                                               attType,
                                                               bracket,
                                                               defaultDecl,
                                                               attValue: wideString);
const
  LT: WideChar  = #60;  // '<'
var
  errHandler: TdomCustomErrorHandler;
  e: EParserDouble_AttDef_Warning;
  newCMAttribute: TdomCMAttribute;
  replacementText: wideString;
  error: boolean;
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if FCurrentAttListName = ''
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
  if assigned(FContentModel.attributes.GetNamedItem(FCurrentAttListName,name)) then begin
    errHandler:= nil;
    if sender is TXmlToDomParser
      then errHandler:= TXmlToDomParser(sender).ErrorHandler;
    if sender is TdomDtdAnalyzer
      then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
    if assigned(errHandler) then begin
      e:= EParserDouble_AttDef_Warning.create('EParserDouble_AttDef_Warning');
      try
        errHandler.warning(sender,locator,e,name);
      finally
        e.free;
      end;
    end;
  end else begin

    try
      CDataNormalization(attValue,replacementText,error);
    except
      raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
    end; {try ...}
    if error then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');

    // WFC: No < in Attribute Values (XML 1.0, � 3.3.2)
    if pos(LT,replacementText) > 0 then raise EParserLtInAttributeValue_Err.create('< in default attribute value error');

    newCMAttribute:= FContentModel.CreateCMAttribute(FCurrentAttListName,name,attType,defaultDecl,replacementText);
    try
      if Bracket <> ''
        then insertNotationOrEnumerationContent(sender,newCMAttribute,Bracket);
        // xxx no well-formedness testing is performed for 'Bracket'
    except
      FContentModel.FreeAllCMNodes(TdomCMNode(newCMAttribute));
      raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
    end; {try ...}
    FContentModel.Attributes.appendNamedItem(newCMAttribute);
  end; {if ... else ...}
end;

procedure TdomDTDContentModelHandler.comment(const sender: TdomCustomParser;
                                             const locator: TdomStandardLocator;
                                             const data: wideString);
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
end;

procedure TdomDTDContentModelHandler.conditionalSection(const sender: TdomCustomParser;
                                                        const locator: TdomStandardLocator;
                                                        const includeStmt,
                                                              data: wideString);
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
end;

procedure TdomDTDContentModelHandler.elementTypeDeclaration(const sender: TdomCustomParser;
                                                            const locator: TdomStandardLocator;
                                                            const name,
                                                                  data: wideString);
var
  contSpec: wideString;
  contspecType: TdomContentspecType;
  newElementTypeDecl: TdomCMElementTypeDeclaration;
  errHandler: TdomCustomErrorHandler;
  e: EParserDouble_Element_Type_Declaration_Err;
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
  if not IsXmlName(name)
    then raise EParserInvalidElementDeclaration_Err.create('Invalid element declaration error.');

  if assigned(FContentModel.elementTypes.GetNamedItem(name)) then begin
    errHandler:= nil;
    if sender is TXmlToDomParser
      then errHandler:= TXmlToDomParser(sender).ErrorHandler;
    if sender is TdomDtdAnalyzer
      then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
    if assigned(errHandler) then begin
      e:= EParserDouble_Element_Type_Declaration_Err.create('Missing_Entity_Declaration_Err');
      try
        errHandler.error(sender,locator,e,name);
      finally
        e.free;
      end;  
    end;
    exit;
  end;

  contSpec:= XMLTrunc(data);
  contspecType:= ctChildren;
  if contSpec = 'EMPTY'
    then contspecType:= ctEmpty
    else if contSpec = 'ANY'
      then contspecType:= ctAny
      else if pos('#PCDATA',contSpec) > 0
        then contspecType:= ctMixed;
  try
    newElementTypeDecl:= FContentModel.CreateCMElementTypeDeclaration(name,contspecType);
  except
    raise EParserInvalidElementDeclaration_Err.create('Invalid element declaration error.');
  end; {try ...}

  try
    case contspecType of
      ctMixed: insertMixedContent(sender,newElementTypeDecl,contSpec);
      ctChildren: insertChildrenContent(sender,newElementTypeDecl,contSpec);
    end; {case ...}
  except
    FContentModel.FreeAllCMNodes(TdomCMNode(newElementTypeDecl));
    raise EParserInvalidElementDeclaration_Err.create('Invalid element declaration error.');
  end; {try ...}

  FContentModel.elementTypes.setNamedItem(newElementTypeDecl);
end;

procedure TdomDTDContentModelHandler.endAttListDeclaration(const sender: TdomCustomParser;
                                                           const locator: TdomStandardLocator);
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if FCurrentAttListName = ''
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
  FCurrentAttListName:= '';
end;

procedure TdomDTDContentModelHandler.endDtd(const sender: TdomCustomParser);
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
end;

procedure TdomDTDContentModelHandler.entityDeclaration(const sender: TdomCustomParser;
                                                       const locator: TdomStandardLocator;
                                                       const name,
                                                             entityValue,
                                                             pubId,
                                                             sysId,
                                                             notaName: wideString);
var
  InputSrc: TXmlInputSource;
  stream: TStream;
  entValue,PId,SId: wideString;
  action: TXmlParserAction;
  newEntity: TdomCMEntity;
  errHandler: TdomCustomErrorHandler;
  e1: EParserDouble_Entity_Decl_Warning;
  e2: EParserUnusable_Entity_Decl_Warning;
  e3: EParserExternal_Entity_Not_Found_Err;
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
  // Resolve value of external parsed entity:
  if (notaName = '') and not ( (pubId = '') and (sysId = '')) then begin
    stream:= nil;
    entValue:= '';
    PId:= pubId;
    SId:= sysId;
    action:= paFail;
    try
      if assigned(FContentModel.domImplementation.OnExternalParsedEntity) then begin
        repeat
          FContentModel.domImplementation.OnExternalParsedEntity(FContentModel,FContentModel.associatedDocument.systemId,PId,SId,stream,action);
        until action <> paRetry;
      end;
      if action = paFail then begin
        errHandler:= nil;
        if sender is TXmlToDomParser
          then errHandler:= TXmlToDomParser(sender).ErrorHandler;
        if sender is TdomDtdAnalyzer
          then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
        if assigned(errHandler) then begin
          e3:= EParserExternal_Entity_Not_Found_Err.create('External_Entity_Not_Found_Err');
          try
            errHandler.error(sender,locator,e3,name);
          finally
            e3.free;
          end;
        end;
        exit;
      end;

      // convert external entity value to UTF-16BE:
      if assigned(stream) then begin
        InputSrc:= TXmlInputSource.create(stream,'','');
        try
          entValue:= InputSrc.streamAsWideString;
        finally
          InputSrc.free;
        end; {try}
      end else entValue:= '';
    finally
      if assigned(stream) then stream.free;
    end;
  end else entValue:= entityValue;

  if assigned(FContentModel.Entities.GetNamedItem(name)) then begin
    errHandler:= nil;
    if sender is TXmlToDomParser
      then errHandler:= TXmlToDomParser(sender).ErrorHandler;
    if sender is TdomDtdAnalyzer
      then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
    if assigned(errHandler) then begin
      e1:= EParserDouble_Entity_Decl_Warning.create('Double_Entity_Decl_Warning');
      try
        errHandler.warning(sender,locator,e1,name);
      finally
        e1.free;
      end;
    end;
  end else begin
    newEntity:= nil;
    try
      newEntity:= FContentModel.CreateCMEntity(name,entValue,pubId,sysId,'',notaName);
      FContentModel.Entities.appendNamedItem(newEntity);
      newEntity.testForCircularReference(true);
      if newEntity.isUnusable then begin
        errHandler:= nil;
        if sender is TXmlToDomParser
          then errHandler:= TXmlToDomParser(sender).ErrorHandler;
        if sender is TdomDtdAnalyzer
          then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
        if assigned(errHandler) then begin
          e2:= EParserUnusable_Entity_Decl_Warning.create('Unusable_Entity_Decl_Warning');
          try
            errHandler.warning(sender,locator,e2,name);
          finally
            e2.free;
          end;
        end; {if assigned ...}
      end; {if newEntity.isUnsuable ...}
    except // Occures, when newEntity contains a circular reference
      if assigned(newEntity) then begin
        if assigned(newEntity.parentNode)
          then FContentModel.Entities.removeLastItem;
        FContentModel.FreeAllCMNodes(TdomCMNode(newEntity));
      end;
      raise EParserInvalidEntityDeclaration_Err.create('EParserInvalidEntityDeclaration_Err');
    end; {try ...}
  end; {if ... else ...}
end;

procedure TdomDTDContentModelHandler.notationDeclaration(const sender: TdomCustomParser;
                                                         const locator: TdomStandardLocator;
                                                         const name,
                                                               pubId,
                                                               sysId: wideString);
var
  newNotation: TdomCMNotation;
  errHandler: TdomCustomErrorHandler;
  e: EParserDuplicate_Notation_Decl_Err;
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
  if assigned(FContentModel.Notations.GetNamedItem(name)) then begin
    errHandler:= nil;
    if sender is TXmlToDomParser
      then errHandler:= TXmlToDomParser(sender).ErrorHandler;
    if sender is TdomDtdAnalyzer
      then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
    if assigned(errHandler) then begin
      e:= EParserDuplicate_Notation_Decl_Err.create('Duplicate_Notation_Decl_Err');
      try
        errHandler.error(sender,locator,e,name);
      finally
        e.free;
      end;
    end;
  end else begin
    try
      newNotation:= FContentModel.CreateCMNotation(name,pubId,sysId);
      FContentModel.Notations.SetNamedItem(newNotation);
    except
      raise EParserInvalidNotationDeclaration_Err.create('Invalid notation declaration error.');
    end; {try ...}
  end;
end;

procedure TdomDTDContentModelHandler.parameterEntityDeclaration(const sender: TdomCustomParser;
                                                                const locator: TdomStandardLocator;
                                                                const name,
                                                                      entityValue,
                                                                      pubId,
                                                                      sysId: wideString);
var
  InputSrc: TXmlInputSource;
  stream: TStream;
  entValue,replacementText,PId,SId: wideString;
  action: TXmlParserAction;
  newPE: TdomCMParameterEntity;
  errHandler: TdomCustomErrorHandler;
  e: EParserDouble_Parameter_Entity_Decl_Warning;
  e2: EParserMissing_Entity_Declaration_Err;
  e3: EParserExternal_Entity_Not_Found_Err;
  error: boolean;
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
  // Resolve value of external parsed entity:
  if not ( (pubId = '') and (sysId = '')) then begin
    stream:= nil;
    entValue:= '';
    PId:= pubId;
    SId:= sysId;
    action:= paFail;
    try
      if assigned(FContentModel.domImplementation.OnExternalParsedEntity) then begin
        repeat
          FContentModel.domImplementation.OnExternalParsedEntity(FContentModel,FContentModel.associatedDocument.systemId,PId,SId,stream,action);
        until action <> paRetry;
      end;
      if action = paFail then begin
        errHandler:= nil;
        if sender is TXmlToDomParser
          then errHandler:= TXmlToDomParser(sender).ErrorHandler;
        if sender is TdomDtdAnalyzer
          then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
        if assigned(errHandler) then begin
          e3:= EParserExternal_Entity_Not_Found_Err.create('External_Entity_Not_Found_Err');
          try
            errHandler.error(sender,locator,e3,name);
          finally
            e3.free;
          end;
        end;
        exit;
      end;

      // convert external entity value to UTF-16BE:
      if assigned(stream) then begin
        InputSrc:= TXmlInputSource.create(stream,'','');
        try
          entValue:= InputSrc.streamAsWideString;
        finally
          InputSrc.free;
        end; {try}
      end else entValue:= '';

    finally
      if assigned(stream) then stream.free;
    end;

  end else entValue:= entityValue;

  if assigned(FContentModel.parameterEntities.GetNamedItem(name)) then begin
    errHandler:= nil;
    if sender is TXmlToDomParser
      then errHandler:= TXmlToDomParser(sender).ErrorHandler;
    if sender is TdomDtdAnalyzer
      then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
    if assigned(errHandler) then begin
      e:= EParserDouble_Parameter_Entity_Decl_Warning.create('Double_Parameter_Entity_Decl_Warning');
      try
        errHandler.warning(sender,locator,e,name);
      finally
        e.free;
      end;
    end;
  end else begin
    try
      ResolveCharRefsAndPERefs(entValue,replacementText,error);
      if error then begin
        errHandler:= nil;
        if sender is TXmlToDomParser
          then errHandler:= TXmlToDomParser(sender).ErrorHandler;
        if sender is TdomDtdAnalyzer
          then errHandler:= TdomDtdAnalyzer(sender).ErrorHandler;
        if assigned(errHandler) then begin
          e2:= EParserMissing_Entity_Declaration_Err.create('Missing_Entity_Declaration_Err');
          try
            errHandler.error(sender,locator,e2,name);
          finally
            e2.free;
          end;
        end;
      end;
      newPE:= FContentModel.CreateCMParameterEntity(name,replacementText,pubId,sysId,'');
      newPE.setIsUnusable(error);
      FContentModel.parameterEntities.SetNamedItem(newPE);
    except
      raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
    end; {try ...}
  end;
end;

procedure TdomDTDContentModelHandler.parameterEntityRef(const sender: TdomCustomParser;
                                                        const locator: TdomStandardLocator;
                                                        const name: wideString);
var
  newParEnt: TdomCMParameterEntity;
  dtdAnalyzer: TdomDtdAnalyzer;
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
  newParEnt:= (FContentModel.ParameterEntities.GetNamedItem(name) as TdomCMParameterEntity);
  if not assigned(newParEnt)
    then raise EParserUnresolvable_Parameter_Entity_Reference_Err.create('Unresolvable Parameter Entity Reference.');
  if newParEnt.isUnusable
    then raise EParserUnresolvable_Parameter_Entity_Reference_Err.create('Unresolvable Parameter Entity Reference.');

  dtdAnalyzer:= TdomDtdAnalyzer.create(nil);
  try
    try
      dtdAnalyzer.analyzeIntDTDStr(newParEnt.nodeValue,FContentModel);
    finally
      dtdAnalyzer.free;
    end;
  except
    raise EParserInvalidEntityName_Err.create('Invalid entity name error.');
  end;
end;

procedure TdomDTDContentModelHandler.processingInstruction(const sender: TdomCustomParser;
                                                           const locator: TdomStandardLocator;
                                                           const targ,
                                                                 data : wideString);
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
end;

procedure TdomDTDContentModelHandler.startAttListDeclaration(const sender: TdomCustomParser;
                                                             const locator: TdomStandardLocator;
                                                             const name: wideString);
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
  FCurrentAttListName:= name;
end;

procedure TdomDTDContentModelHandler.startDtd(const sender: TdomCustomParser;
                                              const pubId,
                                                    sysId: wideString);
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  FCurrentAttListName:= '';
end;

procedure TdomDTDContentModelHandler.textDeclaration(const sender: TdomCustomParser;
                                                     const locator: TdomStandardLocator;
                                                     const version,
                                                           encDl: wideString);
begin
  if not assigned(FContentModel)
    then raise EInternalParserException.create('Content model object not specified.');
  if not (FCurrentAttListName = '')
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
end;



// +++++++++++++++++++ TdomStandardIntSubsetBuilder +++++++++++++++++++
constructor TdomStandardIntSubsetBuilder.create;
begin
  inherited create;
  FReferenceNode:= nil;
  FRefNode:= nil;
end;

function TdomStandardIntSubsetBuilder.getPEFromCurrentCMObject(const PEReferenceName: wideString): wideString;
var
  parEntIndex: integer;
begin
  if not (FRefNode is TdomCustomCMIEObject)
    then raise EInvalid_Access_Err.create('Reference node is not of type TdomCustomCMIEObject.');
  parEntIndex:= TdomCustomCMIEObject(FRefNode).FParameterEntitiesList.indexOfName(PEReferenceName);
  if parEntIndex = -1
    then raise ENot_Found_Err.create('Parameter entity not found.');
  result:= TdomCustomCMIEObject(FRefNode).FParameterEntitiesList.values[parEntIndex];
end;

procedure TdomStandardIntSubsetBuilder.ResolveCharRefsAndPERefs(const s: wideString;
                                                                  var result: wideString;
                                                                  var error: boolean);
var
  i,j,indexpos: integer;
  SChar, SChar2: widechar;
  name,ref,value: wideString;
  content: TdomCustomStr;
begin
  Result:= '';
  Error:= false;
  content:= TdomCustomStr.create;
  try
    i:= 1;
    while i <= length(S) do begin
      SChar:= WideChar((PWideChar(S)+i-1)^);
      if IsUtf16LowSurrogate(sChar)
        then raise EConvertError.CreateFmt('%S must not start with a UTF-16 low surrogate.',[S]);
      if IsUtf16HighSurrogate(SChar) then begin
        if i+1 > length(s)
          then raise EConvertError.CreateFmt('%S must not end with a UTF-16 high surrogate.',[S]);
        inc(i);
        content.addWideChar(SChar);
        SChar:= WideChar((PWideChar(S)+i-1)^);
        if not IsUtf16LowSurrogate(SChar)
          then raise EConvertError.CreateFmt('%S contains an UTF-16 high surrogate without its corresponding low surrogate.',[S]);
      end;
      if not IsXmlChar(sChar)
        then raise EConvertError.CreateFmt('%S contains an invalid character.',[S]);
      if SChar = '&' then begin {Reference?}
        indexpos:= -1;
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = ';' then begin indexpos:= j; break; end;
        end;
        if indexpos = -1
          then raise EConvertError.CreateFmt('%S contains an ''&'' without a '';''.',[S]);
        ref:= copy(S,i,j-i+1);
        if IsXmlEntityRef(ref) then begin
          content.addWideString(ref);
        end else if IsXmlCharRef(ref) then begin
          content.addWideString(XmlCharRefToStr(ref));
        end else raise EConvertError.CreateFmt('%S contains an invalid reference.',[S]);
        i:= j;
      end else if SChar = '%' then begin {PEReference?}
        indexpos:= -1;
        for j:= i+1 to length(S) do begin
          SChar2:= WideChar((PWideChar(S)+j-1)^);
          if SChar2 = ';' then begin indexpos:= j; break; end;
        end;
        if indexpos = -1
          then raise EConvertError.CreateFmt('%S contains an ''%'' without a '';''.',[S]);
        ref:= copy(S,i,j-i+1);
        if IsXmlPEReference(ref) then begin
          name:= copy(ref,2,length(ref)-2);
          value:= getPEFromCurrentCMObject(name);
          content.addWideString(value);
        end else raise EConvertError.CreateFmt('%S contains an invalid parameter entity reference.',[S]);
        i:= j;
      end else content.addWideChar(SChar);
      inc(i);
    end; {while ...}
    Result:= content.value;
  finally
    content.free;
  end;
end;

procedure TdomStandardIntSubsetBuilder.insertMixedContent(const sender: TdomCustomParser;
                                                          const refNode: TdomCMNode;
                                                          const contSpec: wideString);
var
  freq, dummy, content,piece: wideString;
  separator: integer;
  Error: boolean;
  newNode: TdomCMNode;
begin
  content:= XMLTrunc(contSpec);
  freq:= '';
  if (content[length(content)] = '*') then begin
    freq:= '*';
    dummy:= copy(content,1,length(content)-1);
    content:= dummy;
  end;
  if length(content) = 0
    then raise EParserException.create('Parser error.');
  if wideChar(content[length(content)]) <> ')'
    then raise EParserException.create('Parser error.');
  XMLTruncRoundBrackets(content,dummy,Error);
  if Error or (dummy = '')
    then raise EParserException.create('Parser error.');
  content:= dummy;
  newNode:= refNode.appendChild(refNode.OwnerCMObject.CreateCMPcdataChoiceParticle);
  if content = '#PCDATA' then exit;
  if freq = '' then raise EParserException.create('Parser error.');
  separator:= pos(wideString('|'),content);
  if separator = 0 then raise EParserException.create('Parser error.');
  dummy:= XMLTrunc(copy(content,separator+1,length(content)-separator));
  content:= dummy;
  while content <> '' do begin
    separator:= pos(wideString('|'),content);
    if separator = 0 then begin
      piece:= content;
      content:= '';
    end else begin
      piece:= XMLTrunc(copy(content,1,separator-1));
      dummy:= XMLTrunc(copy(content,separator+1,length(content)-separator));
      content:= dummy;
      if content = '' then raise EParserException.create('Parser error.');
    end; {if ...}
    if not IsXmlName(piece) then raise EParserException.create('Parser error.');
    newNode.appendChild(newNode.OwnerCMObject.CreateCMElementParticle(piece,''));
  end; {while ...}
end;

procedure TdomStandardIntSubsetBuilder.insertChildrenContent(const sender: TdomCustomParser;
                                                             const refNode: TdomCMNode;
                                                             const contSpec: wideString);
var
  piece,dummy,content,freq: wideString;
  SeparatorChar: WideChar;
  j,i,bracketNr: integer;
  newNode: TdomCMNode;
  Error: boolean;
begin
  content:= XMLTrunc(contSpec);
  freq:= '';
  if (content[length(content)] = WideChar('?')) or
     (content[length(content)] = WideChar('*')) or
     (content[length(content)] = WideChar('+')) then begin
    freq:= content[length(content)];
    dummy:= copy(content,1,length(content)-1);
    content:= dummy;
  end;
  if length(content) = 0
    then raise EParserException.create('Parser error.');
  if wideChar(content[length(content)]) <> ')'
    then raise EParserException.create('Parser error.');
  XMLTruncRoundBrackets(content,dummy,Error);
  if Error or (dummy = '')
    then raise EParserException.create('Parser error.');
  content:= dummy;

  bracketNr:= 0;
  SeparatorChar:= ',';
  for i:= 1 to length(content) do begin
    if (content[i] = ',') and (bracketNr = 0) then begin
      SeparatorChar:= ',';
      break;
    end; {if ...}
    if (content[i] = '|') and (bracketNr = 0) then begin
      SeparatorChar:= '|';
      break;
    end; {if ...}
    if content[i] = '(' then inc(bracketNr);
    if content[i] = ')' then begin
      if bracketNr = 0 then raise EParserException.create('Parser error.');
      dec(bracketNr);
    end;
  end; {for ...}

  if SeparatorChar = ','
    then newNode:= refNode.appendChild(refNode.OwnerCMObject.CreateCMSequenceParticle(freq))
    else newNode:= refNode.appendChild(refNode.OwnerCMObject.CreateCMChoiceParticle(freq));

  bracketNr:= 0;
  i:= 0;
  j:= 1;
  while i < length(content) do begin
    inc(i);
    if content[i] = '(' then inc(bracketNr);
    if content[i] = ')' then begin
      if bracketNr = 0 then raise EParserException.create('Parser error.');
      dec(bracketNr);
    end;
    if ((content[i] = SeparatorChar) and (bracketNr = 0)) or
       (i = length(content)) then begin
      if bracketNr > 0 then raise EParserException.create('Parser error.');
      if i = length(content)
        then piece:= XmlTrunc(copy(content,j,i+1-j))
        else piece:= XmlTrunc(copy(content,j,i-j));
      j:= i+1;

      if piece[1] = '(' then begin
        insertChildrenContent(sender,NewNode,piece);
      end else begin
        freq:= '';
        if (piece[length(piece)] = wideChar('?')) or
           (piece[length(piece)] = wideChar('*')) or
           (piece[length(piece)] = wideChar('+')) then begin
          freq:= piece[length(piece)];
          dummy:= copy(piece,1,length(piece)-1);
          piece:= dummy;
        end;
        if not IsXmlName(piece)
          then raise EParserException.create('Parser error.');
        NewNode.appendChild(refNode.OwnerCMObject.CreateCMElementParticle(piece,freq));
      end; {if ...}

    end; {if ...}
  end; {while ...}

end;

procedure TdomStandardIntSubsetBuilder.insertNotationOrEnumerationContent(const sender: TdomCustomParser;
                                                                          const refCMAttrDefinition: TdomCMAttrDefinition;
                                                                          const contSpec: wideString);
var
  dummy,content,piece: wideString;
  separator: integer;
  Error: boolean;
begin
  XMLTruncRoundBrackets(contSpec,content,Error);
  if Error or (content = '')
    then raise EParserException.create('Parser error.');
  while content <> '' do begin
    separator:= pos(wideString('|'),content);
    if separator = 0 then begin
      piece:= content;
      content:= '';
    end else begin
      piece:= XMLTrunc(copy(content,1,separator-1));
      dummy:= XMLTrunc(copy(content,separator+1,length(content)-separator));
      content:= dummy;
      if content = '' then raise EParserException.create('Parser error.');
    end; {if ...}
    if refCMAttrDefinition.attributeType = 'NOTATION' then begin
      if not IsXmlName(piece) then raise EParserException.create('Parser error.');
      refCMAttrDefinition.appendChild(refCMAttrDefinition.OwnerCMObject.CreateCMNameParticle(piece));
    end else begin
      if not IsXmlNmtoken(piece) then raise EParserException.create('Parser error.');
      refCMAttrDefinition.appendChild(refCMAttrDefinition.OwnerCMObject.CreateCMNmtokenParticle(piece));
    end;
  end; {while ...}
end;

procedure TdomStandardIntSubsetBuilder.setReferenceNode(const node: TdomCMNode);
begin
  if assigned(node)
    then if not (node.OwnerCMObject is TdomCMInternalObject)
      then raise EInvalid_Access_Err.create('Owner content model object is not of type TdomCMInternalObject.');
  FReferenceNode:= node;
end;

procedure TdomStandardIntSubsetBuilder.attributeDefinition(const sender: TdomCustomParser;
                                                           const locator: TdomStandardLocator;
                                                           const name,
                                                                 attType,
                                                                 bracket,
                                                                 defaultDecl,
                                                                 attValue: wideString);
var
  newAttDef: TdomCMAttrDefinition;
begin
  if not assigned(FRefNode) then exit;
  if not (FRefNode.nodeType = ctAttributeList)
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  try
    newAttDef:= FRefNode.OwnerCMObject.CreateCMAttributeDefinition(name,attType,defaultDecl,attValue);
    try
      if Bracket <> ''
        then insertNotationOrEnumerationContent(sender,newAttDef,Bracket);
        // xxx no well-formedness testing is performed for 'Bracket'
      FRefNode.appendChild(newAttDef);
    except
      if assigned(newAttDef.ParentNode)
        then newAttDef.ParentNode.RemoveChild(newAttDef);
      FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newAttDef));
      raise;
    end; {try ...}
  except
    raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  end; {try ...}
end;

procedure TdomStandardIntSubsetBuilder.comment(const sender: TdomCustomParser;
                                               const locator: TdomStandardLocator;
                                               const data: wideString);
var
  newComment: TdomCMComment;
begin
  if not assigned(FRefNode) then exit;
  try
    newComment:= FRefNode.OwnerCMObject.CreateCMComment(data);
    try
      FRefNode.appendChild(newComment);
    except
      if assigned(newComment.ParentNode)
        then newComment.ParentNode.RemoveChild(newComment);
      FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newComment));
      raise;
    end; {try ...}
  except
    raise EParserInvalidCharacter_Err.create('Invalid character error.');
  end; {try ...}
end;

procedure TdomStandardIntSubsetBuilder.conditionalSection(const sender: TdomCustomParser;
                                                          const locator: TdomStandardLocator;
                                                          const includeStmt,
                                                                data: wideString);
begin
  if not assigned(FRefNode) then exit;
  raise EParserInvalidConditionalSection_Err.create('Invalid conditional section error.');
end;

procedure TdomStandardIntSubsetBuilder.elementTypeDeclaration(const sender: TdomCustomParser;
                                                              const locator: TdomStandardLocator;
                                                              const name,
                                                                    data: wideString);
var
  contSpec: wideString;
  contspecType: TdomContentspecType;
  newElementTypeDecl: TdomCMElementTypeDeclaration;
begin
  if not assigned(FRefNode) then exit;
  if not IsXmlName(name)
    then raise EParserInvalidElementDeclaration_Err.create('Invalid element declaration error.');

  contSpec:= XMLTrunc(data);
  contspecType:= ctChildren;
  if contSpec = 'EMPTY'
    then contspecType:= ctEmpty
    else if contSpec = 'ANY'
      then contspecType:= ctAny
      else if pos('#PCDATA',contSpec) > 0
        then contspecType:= ctMixed;
  try
    newElementTypeDecl:= FRefNode.OwnerCMObject.CreateCMElementTypeDeclaration(name,contspecType);
    try
      FRefNode.appendChild(newElementTypeDecl);
    except
      if assigned(newElementTypeDecl.ParentNode)
        then newElementTypeDecl.ParentNode.RemoveChild(newElementTypeDecl);
      FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newElementTypeDecl));
      raise;
    end; {try ...}
  except
    raise EParserInvalidElementDeclaration_Err.create('Invalid element declaration error.');
  end; {try ...}
  try
    case contspecType of
      ctMixed: insertMixedContent(sender,newElementTypeDecl,contSpec);
      ctChildren: insertChildrenContent(sender,newElementTypeDecl,contSpec);
    end; {case ...}
  except
    FRefNode.RemoveChild(newElementTypeDecl);
    FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newElementTypeDecl));
    raise EParserInvalidElementDeclaration_Err.create('Invalid element declaration error.');
  end; {try ...}
end;

procedure TdomStandardIntSubsetBuilder.endAttListDeclaration(const sender: TdomCustomParser;
                                                             const locator: TdomStandardLocator);
begin
  if not assigned(FRefNode) then exit;
  if not (FRefNode.nodeType = ctAttributeList)
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  FRefNode:= FRefNode.ParentNode;
end;

procedure TdomStandardIntSubsetBuilder.endDtd;
begin
  if not assigned(FRefNode) then exit;
  if FRefNode <> FReferenceNode
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid Attribute Declaration error.');
end;

procedure TdomStandardIntSubsetBuilder.entityDeclaration(const sender: TdomCustomParser;
                                                         const locator: TdomStandardLocator;
                                                         const name,
                                                               entityValue,
                                                               pubId,
                                                               sysId,
                                                               notaName: wideString);
const
  sQuote: wideString  = #$0027;
  dQuote: wideString  = '"';
var
  newEntDecl: TdomCMEntityDeclaration;
begin
  if not assigned(FRefNode) then exit;
  if not ( IsXmlEntityValue(concat(dQuote,entityValue,dQuote)) or
             IsXmlEntityValue(concat(sQuote,entityValue,sQuote)) )
    then raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
  try
    newEntDecl:= FRefNode.OwnerCMObject.CreateCMEntityDeclaration(name,entityValue,pubId,sysId,notaName);
    try
      FRefNode.appendChild(newEntDecl);
    except
      if assigned(newEntDecl) then begin
        if assigned(newEntDecl.ParentNode)
          then newEntDecl.ParentNode.RemoveChild(newEntDecl);
        FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newEntDecl));
      end;
      raise;
    end; {try ...}
  except
    raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
  end; {try ...}
end;

procedure TdomStandardIntSubsetBuilder.notationDeclaration(const sender: TdomCustomParser;
                                                           const locator: TdomStandardLocator;
                                                           const name,
                                                                 pubId,
                                                                 sysId: wideString);
var
  newNotaDecl: TdomCMNotationDeclaration;
begin
  if not assigned(FRefNode) then exit;
  try
    newNotaDecl:= FRefNode.OwnerCMObject.CreateCMNotationDeclaration(name,pubId,sysId);
    try
      FRefNode.appendChild(newNotaDecl);
    except
      if assigned(newNotaDecl) then begin
        if assigned(newNotaDecl.ParentNode)
          then newNotaDecl.ParentNode.RemoveChild(newNotaDecl);
        FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newNotaDecl));
      end;
      raise;
    end; {try ...}
  except
    raise EParserInvalidNotationDeclaration_Err.create('Invalid notation declaration error.');
  end; {try ...}
end;

procedure TdomStandardIntSubsetBuilder.parameterEntityDeclaration(const sender: TdomCustomParser;
                                                                  const locator: TdomStandardLocator;
                                                                  const name,
                                                                        entityValue,
                                                                        pubId,
                                                                        sysId: wideString);
var
  InputSrc: TXmlInputSource;
  stream: TStream;
  dummyReplacementText,replacementText,PId,SId: wideString;
  newParamEntDecl: TdomCMParameterEntityDeclaration;
  error: boolean;
  action: TXmlParserAction;
begin
  if not assigned(FRefNode) then exit;
  try
    newParamEntDecl:= FRefNode.OwnerCMObject.CreateCMParameterEntityDeclaration(name,entityValue,pubId,sysId);
    try
      FRefNode.appendChild(newParamEntDecl);
    except
      if assigned(newParamEntDecl) then begin
        if assigned(newParamEntDecl.ParentNode)
          then newParamEntDecl.ParentNode.RemoveChild(newParamEntDecl);
        FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newParamEntDecl));
      end;
      raise;
    end; {try ...}
  except
    raise EParserInvalidEntityDeclaration_Err.create('Invalid entity declaration error.');
  end; {try ...}

  dummyReplacementText:= '';
  if not ( (pubId = '') and (sysId = '')) then begin
    // Resolve value of external parsed entity:
    stream:= nil;
    PId:= pubId;
    SId:= sysId;
    action:= paFail;
    try
      if assigned(FRefNode.OwnerCMObject.domImplementation.OnExternalParsedEntity) then begin
        repeat
          FRefNode.OwnerCMObject.domImplementation.OnExternalParsedEntity(
            sender,
            (FRefNode.OwnerCMObject as TdomCustomCMIEObject).systemId,
            PId,
            SId,
            stream,
            action);
        until action <> paRetry;
      end;

      // convert replacement text to UTF-16BE:
      if assigned(stream) then begin
        InputSrc:= TXmlInputSource.create(stream,'','');
        try
          replacementText:= InputSrc.streamAsWideString;
        finally
          InputSrc.free;
        end; {try}
      end else replacementText:= '';

      (FRefNode.OwnerCMObject as TdomCustomCMIEObject).FParameterEntitiesList.add(name,replacementText);
      if action = paFail
        then raise EParserExternal_Entity_Not_Found_Err.create('External_Entity_Not_Found_Err');
    finally
      if assigned(stream) then stream.free;
    end;
  end else begin
    try
      ResolveCharRefsAndPERefs(entityValue,replacementText,error);
    except
      error:= true;
    end;
    (FRefNode.OwnerCMObject as TdomCustomCMIEObject).FParameterEntitiesList.add(name,replacementText);
    if error
      then raise EParserInvalidEntityDeclaration_Err.create('InvalidEntityDeclaration_Err');
  end; {if ... else ...}
end;

procedure TdomStandardIntSubsetBuilder.parameterEntityRef(const sender: TdomCustomParser;
                                                          const locator: TdomStandardLocator;
                                                          const name: wideString);
var
  newParamEntRef: TdomCMParameterEntityReference;
begin
  if not assigned(FRefNode) then exit;
  if not IsXmlName(name)
    then raise EParserInvalidEntityName_Err.create('Invalid entity name error.');
  newParamEntRef:= FRefNode.OwnerCMObject.CreateCMParameterEntityReference(name);
  try
    FRefNode.appendChild(newParamEntRef);
  except
    if assigned(newParamEntRef.ParentNode)
      then newParamEntRef.ParentNode.RemoveChild(newParamEntRef);
    FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newParamEntRef));
    raise EParserInvalidEntityName_Err.create('Invalid entity name error.');
  end; {try ...}
end;

procedure TdomStandardIntSubsetBuilder.processingInstruction(const sender: TdomCustomParser;
                                                             const locator: TdomStandardLocator;
                                                             const targ,
                                                                   data : wideString);
var
  newPI: TdomCMProcessingInstruction;
begin
  if not assigned(FRefNode) then exit;
  if targ = 'xml'
    then raise EParserInvalidProcessingInstruction_Err.create('Invalid processing instruction error.');
  try
    newPI:= FRefNode.OwnerCMObject.CreateCMProcessingInstruction(targ,data);
    try
      FRefNode.appendChild(newPI);
    except
      if assigned(newPI.ParentNode)
        then newPI.ParentNode.RemoveChild(newPI);
      FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newPI));
      raise;
    end;
  except
    raise EParserInvalidProcessingInstruction_Err.create('Invalid processing instruction error.');
  end;
end;

procedure TdomStandardIntSubsetBuilder.startAttListDeclaration(const sender: TdomCustomParser;
                                                               const locator: TdomStandardLocator;
                                                               const name: wideString);
var
  newAttList: TdomCMAttrList;
begin
  if not assigned(FRefNode) then exit;
  if not IsXmlName(name)
    then raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  try
    newAttList:= FRefNode.OwnerCMObject.CreateCMAttributeList(name);
    try
      FRefNode.appendChild(newAttList);
    except
      if assigned(newAttList.ParentNode)
        then newAttList.ParentNode.RemoveChild(newAttList);
      FRefNode.OwnerCMObject.FreeAllCMNodes(TdomCMNode(newAttList));
      raise;
    end; {try ...}
  except
    raise EParserInvalidAttributeDeclaration_Err.create('Invalid attribute declaration error.');
  end; {try ...}
  FRefNode:= newAttList;
end;

procedure TdomStandardIntSubsetBuilder.startDtd(const sender: TdomCustomParser;
                                                const pubId,
                                                      sysId: wideString);
begin
  FRefNode:= FReferenceNode;
end;

procedure TdomStandardIntSubsetBuilder.textDeclaration(const sender: TdomCustomParser;
                                                       const locator: TdomStandardLocator;
                                                       const version,
                                                             encDl: wideString);
begin
  if not assigned(FRefNode) then exit;
  raise EParserInvalidTextDeclaration_Err.create('Invalid text-declaration error.');
end;



// +++++++++++++++++++ TdomStandardExtSubsetBuilder +++++++++++++++++++
constructor TdomStandardExtSubsetBuilder.create;
begin
  inherited create;
end;

function TdomStandardExtSubsetBuilder.getPEFromCurrentCMObject(const PEReferenceName: wideString): wideString;
var
  parEntIndex: integer;
  intCM: TdomCMInternalObject;
begin
  if not (FRefNode is TdomCustomCMIEObject)
    then raise EInvalid_Access_Err.create('Reference node is not of type TdomCustomCMIEObject.');
  intCM:= TdomCustomCMIEObject(FRefNode).associatedContentModel.internalCM;
  if assigned(intCM) then begin
    parEntIndex:= intCM.FParameterEntitiesList.indexOfName(PEReferenceName);
    if parEntIndex = -1
      then result:= inherited getPEFromCurrentCMObject(PEReferenceName)
      else result:= intCM.FParameterEntitiesList.values[parEntIndex];
   end else result:= inherited getPEFromCurrentCMObject(PEReferenceName);
end;

procedure TdomStandardExtSubsetBuilder.setReferenceNode(const node: TdomCMNode);
begin
  if assigned(node)
    then if not (node.OwnerCMObject is TdomCMExternalObject)
      then raise EInvalid_Access_Err.create('Owner content model object is not of type TdomCMExternalObject.');
  FReferenceNode:= node;
end;

procedure TdomStandardExtSubsetBuilder.conditionalSection(const sender: TdomCustomParser;
                                                          const locator: TdomStandardLocator;
                                                          const includeStmt,
                                                                data: wideString);
var
  parser: TXmlToDomParser;
begin
  if not assigned(FRefNode) then exit;
  if not ((IncludeStmt = 'INCLUDE') or (IncludeStmt = 'IGNORE'))
    then raise EParserInvalidConditionalSection_Err.create('Invalid conditional section error.');

  try
    if (IncludeStmt = 'INCLUDE') and (data <> '') then begin
      parser:= TXmlToDomParser.create(sender);
      parser.domImpl:= FRefNode.OwnerCMObject.domImplementation;
      try
        if assigned(locator)
          then parser.extDtdWideStringToDom(data,locator.publicId,locator.systemId,FRefNode)
          else parser.extDtdWideStringToDom(data,'','',FRefNode);
      finally
        parser.free;
      end; {try ...}
    end; {if ...}
  except
    raise EParserInvalidConditionalSection_Err.create('Invalid conditional section error.');
  end; {try ...}
end;

procedure TdomStandardExtSubsetBuilder.parameterEntityRef(const sender: TdomCustomParser;
                                                          const locator: TdomStandardLocator;
                                                          const name: wideString);
const
  SPACE: WideString = #$20;
var
  parEntIndex: integer;
  parser: TXmlToDomParser;
  value: wideString;
begin
  if not assigned(FRefNode) then exit;
  if not IsXmlName(name)
    then raise EParserInvalidEntityName_Err.create('Invalid entity name error.');
  parEntIndex:= (FRefNode as TdomCMExternalObject).FParameterEntitiesList.indexOfName(name);
  if parEntIndex = -1
    then raise EParserUnresolvable_Parameter_Entity_Reference_Err.create('Unresolvable Parameter Entity Reference.');
  value:= concat(SPACE,(FRefNode as TdomCMExternalObject).FParameterEntitiesList.values[parEntIndex],SPACE); // SPACE is required by XML 1.0 Spec, � 4.4.8
  try
    parser:= TXmlToDomParser.create(sender);
    parser.domImpl:= FRefNode.OwnerCMObject.domImplementation;
    try
      if assigned(locator)
        then parser.extDtdWideStringToDom(value,locator.publicId,locator.systemId,FRefNode)
        else parser.extDtdWideStringToDom(value,'','',FRefNode);
    finally
      parser.free;
    end; {try ...}
  except
    raise EParserInvalidEntityName_Err.create('Invalid entity name error.');
  end; {try ...}
end;

procedure TdomStandardExtSubsetBuilder.startDtd(const sender: TdomCustomParser;
                                                const pubId,
                                                      sysId: wideString);
begin
  FRefNode:= FReferenceNode;
  if FRefNode.nodeType = ctExternalObject
    then FTextDeclarationAllowed:= true
    else FTextDeclarationAllowed:= false;
end;

procedure TdomStandardExtSubsetBuilder.textDeclaration(const sender: TdomCustomParser;
                                                       const locator: TdomStandardLocator;
                                                       const version,
                                                             encDl: wideString);
begin
  if not assigned(FRefNode) then exit;
  if (FRefNode.nodeType <> ctExternalObject)
    or (FRefNode.HasChildNodes)
    or not FTextDeclarationAllowed
    then raise EParserWrongOrder_Err.create('Wrong order error.');
  if not (IsXmlEncName(EncDl) or (EncDl = ''))
    then raise EParserInvalidTextDeclaration_Err.create('Invalid text-declaration error.');
  if not ( IsXmlVersionNum(Version) or (Version = '') )
    then raise EParserInvalidTextDeclaration_Err.create('Invalid text-declaration error.');

  FTextDeclarationAllowed:= false;
  (FRefNode as TdomCMExternalObject).version:= version;
  (FRefNode as TdomCMExternalObject).encoding:= encDl;
end;



// ++++++++++++++++++++++++++ TdomDtdAnalyzer ++++++++++++++++++++++++++
constructor TdomDtdAnalyzer.create(aOwner: TComponent);
begin
  Inherited create(aOwner);
  FErrorHandler:= nil;
  FDtdHandler:= TdomDTDContentModelHandler.create;
  FDtdReader:= TdomStandardContentModelReader.create;
  FIntDtdReader:= TdomStandardIntSubsetXMLReader.create;
  FIntDtdReader.DtdHandler:= FDtdHandler;
  FIntDtdReader.ErrorHandler:= FErrorHandler;
end;

destructor TdomDtdAnalyzer.destroy;
begin
  FDtdHandler.free;
  FDtdReader.free;
  FIntDtdReader.free;
  inherited destroy;
end;

procedure TdomDtdAnalyzer.analyzeCM(const source: TdomCustomCMIEObject;
                                    const contentModel: TdomCMObject);
begin
  DtdHandler.FContentModel:= contentModel;
  DtdReader.parse(self,source);
end;

procedure TdomDtdAnalyzer.analyzeIntDTDStr(      str: wideString;
                                           const contentModel: TdomCMObject);
var
  ptr: pointer;
  size: longint;
  MStream: TXmlMemoryStream;
  InputSrc: TXmlInputSource;
begin
  DtdHandler.FContentModel:= contentModel;
  if str = '' then exit;
  if str[1] <> #$feff
    then str:= concat(wideString(#$feff),str);
  ptr:= pointer(str);
  size:= length(str)*2;
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    InputSrc:= TXmlInputSource.create(MStream,'','');
    try
      if not IntDtdReader.parse(self,InputSrc)
        then raise EParserException.create('Parser error.');
    finally
      InputSrc.free;
    end; {try}
  finally
    MStream.free;
  end; {try}
end;



// ++++++++++++++++++++++++++ TXmlToDomParser ++++++++++++++++++++++++++
constructor TXmlToDomParser.create(aOwner: TComponent);
// Note: If you derive your own parser class from TXmlToDomParser
// which is calling the inherited create constructor of TXmlToDomParser
// you should take care of freeing the Handlers, Builders and Readers
// created here which are not longer of use. Code example:
//
// type TMyParser = class(TXmlToDomParser)  ...
// type TMyXMLReader = class(TdomStandardDocXMLReader) ...
//
// constructor TMyParser.create(aOwner:TComponent);
// begin
//   Inherited create(aOwner);
//   FDocXMLReader.free;
//   FDocXMLReader:= TMyXMLReader.create;
//   FDocXMLReader.ContentHandler:= FDocBuilder;
//   FDocXMLReader.ErrorHandler:= FErrorHandler;
// end;
begin
  Inherited create(aOwner);
  FDOMImpl:= nil;
  FErrorHandler:= TdomStandardErrorHandler.create;
  FDocBuilder:= TdomStandardDocBuilder.create;
  FDocXMLReader:= TdomStandardDocXMLReader.create;
  FDocXMLReader.ContentHandler:= FDocBuilder;
  FDocXMLReader.ErrorHandler:= FErrorHandler;
  FExtDtdBuilder:= TdomStandardExtSubsetBuilder.create;
  FExtDtdReader:= TdomStandardExtSubsetXMLReader.create;
  FExtDtdReader.DtdHandler:= FExtDtdBuilder;
  FExtDtdReader.ErrorHandler:= FErrorHandler;
  FIntDtdBuilder:= TdomStandardIntSubsetBuilder.create;
  FIntDtdReader:= TdomStandardIntSubsetXMLReader.create;
  FIntDtdReader.DtdHandler:= FIntDtdBuilder;
  FIntDtdReader.ErrorHandler:= FErrorHandler;
end;

destructor TXmlToDomParser.destroy;
begin
  FDocBuilder.free;
  FDocXMLReader.free;
  FErrorHandler.free;
  FExtDtdBuilder.free;
  FExtDtdReader.free;
  FIntDtdBuilder.free;
  FIntDtdReader.free;
  inherited destroy;
end;

procedure TXmlToDomParser.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (Operation = opRemove) and (AComponent = FDomImpl)
    then FDomImpl:= nil;
end;

procedure TXmlToDomParser.SetDomImpl(const impl: TDomImplementation);
begin
  FDOMImpl:= impl;
  if impl <> nil then impl.FreeNotification(Self); // xxx necessary?
end;

function TXmlToDomParser.GetDomImpl: TDomImplementation;
begin
  Result:= FDOMImpl;
end;

procedure TXmlToDomParser.parseDtd(const locator: TdomStandardLocator;
                                   const name,
                                         pubId,
                                         sysId,
                                         data: wideString;
                                   const standalone: boolean);
var
  ExtDtdStream: TStream;
  PId,SId: wideString;
  CMObj: TdomCMObject;
  IntCMObj: TdomCMInternalObject;
  ExtCMObj: TdomCMExternalObject;
  action: TXmlParserAction;
begin
  if assigned(docBuilder.ReferenceDocument.contentmodel)
    then raise EInternalParserException.create('Internal parser exception: Content model already assigned in parsedtd() procedure.');
  if (data = '') and (pubId = '') and (sysId = '')
    then exit;  // xxx Raise an exception instead?
  CMObj:= DOMImpl.createCMObject;
  ExtCMObj:= nil;
  IntCMObj:= nil;
  try
    if (data <> '') then begin
      IntCMObj:= self.DOMImpl.createCMInternalObject(locator.publicId,locator.systemId);
      CMObj.setInternalCM(IntCMObj);
      intDtdWideStringToDom(data,locator.publicId,locator.systemId,IntCMObj);
    end;

    if (not standalone) and ((pubId <> '') or (sysId <> '')) then begin
      extDtdStream:= nil;
      PId:= pubId;
      SId:= sysId;
      action:= paFail;
      try
        if assigned(OnExternalSubset) then begin
          repeat
            OnExternalSubset(self,locator.systemId,PId,SId,extDtdStream,action);
          until action <> paRetry;
        end;
        if action = paFail  // xxx Should that be treated as an XML-error and not raise an exception?
          then raise EParserExternal_Subset_Not_Found_Err.create('External_Subset_Not_Found_Err');
        if assigned(extDtdStream) then begin
          extCMObj:= self.DOMImpl.createCMExternalObject(PId,SId);
          CMObj.setExternalCM(ExtCMObj);
          extDtdStreamToDom(extDtdStream,PId,SId,ExtCMObj);
        end; {if ...}
      finally
        if assigned(extDtdStream) then extDtdStream.free;
      end;
    end; {if ...}
    if assigned(CMObj.internalCM) or assigned(CMObj.externalCM) then begin
      docBuilder.ReferenceDocument.setContentModel(CMObj);
      CMObj.prepareCM(ErrorHandler);
    end else begin
      DOMImpl.FreeCMObject(CMObj);
      CMObj:= nil;
    end;
  except
    if assigned(ExtCMObj)
      then DOMImpl.FreeCMExternalObject(ExtCMObj); //xxx Should external subset reuse be implemented? -- No. Problems with parameter entities.
    if assigned(IntCMObj)
      then DOMImpl.FreeCMInternalObject(IntCMObj);
    if assigned(CMObj)
      then DOMImpl.FreeCMObject(CMObj);
    raise;
  end; {try ...}
end;

procedure TXmlToDomParser.docSourceCodeToDom(const docSourceCode: TXmlSourceCode;
                                             const pubId,
                                                   sysId: wideString;
                                             const refNode: TdomNode);
var
  content: TdomCustomStr;
  i: integer;
begin
  content:= TdomCustomStr.create;
  try
    for i:= 0 to docSourceCode.Count -1 do
      content.addWideString(TXmlSourceCodePiece(docSourceCode[i]).text);
    docWideStringToDom(content.value,pubId,sysId,refNode);
  finally
    content.free;
  end;
end;

procedure TXmlToDomParser.docStreamToDom(const stream: TStream;
                                         const pubId,
                                               sysId: wideString;
                                         const refNode: TdomNode);
var
  InputSrc: TXmlInputSource;
  oldRefNode: TdomNode;
begin
  oldRefNode:= docBuilder.ReferenceNode;
  InputSrc:= TXmlInputSource.create(stream,pubId,sysId);
  try
    docBuilder.ReferenceNode:= refNode;
    if not DocXMLReader.parse(self,InputSrc) then begin
      if assigned(docBuilder)
        then if assigned(docBuilder.FRefDocument)
          then DOMImpl.FreeDocument(docBuilder.FRefDocument);
      raise EParserException.create('Parser error.');
    end;
  finally
    docBuilder.ReferenceNode:= oldRefNode;
    InputSrc.free;
  end; {try}
end;

procedure TXmlToDomParser.docMemoryToDom(const ptr: pointer;
                                         const size: longint;
                                         const pubId,
                                               sysId: wideString;
                                         const refNode: TdomNode);
var
  MStream: TXmlMemoryStream;
begin
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    docStreamToDom(MStream,pubId,sysId,refNode);
  finally
    MStream.free;
  end; {try}
end;

procedure TXmlToDomParser.docStringToDom(const str: string;
                                         const pubId,
                                               sysId: wideString;
                                         const refNode: TdomNode);
var
  ptr: PChar;
  size: longint;
begin
  ptr:= pointer(str);
  size:= length(str);
  if size = 0 then exit;
  docMemoryToDom(ptr,size,pubId,sysId,refNode);
end;


procedure TXmlToDomParser.docWideStringToDom(      str: wideString;
                                             const pubId,
                                                   sysId: wideString;
                                             const refNode: TdomNode);
var
  ptr: pointer;
  size: longint;
begin
  if str = '' then exit;
  if str[1] <> #$feff
    then  str:= concat(wideString(#$feff),str);
  ptr:= pointer(str);
  size:= length(str)*2;
  docMemoryToDom(ptr,size,pubId,sysId,refNode);
end;

procedure TXmlToDomParser.extDtdSourceCodeToDom(const ExtDtdSourceCode: TXmlSourceCode;
                                                const pubId,
                                                      sysId: wideString;
                                                const refNode: TdomCMNode);
var
  content: TdomCustomStr;
  i: integer;
begin
  content:= TdomCustomStr.create;
  try
    for i:= 0 to ExtDtdSourceCode.Count -1 do
      content.addWideString(TXmlSourceCodePiece(ExtDtdSourceCode[i]).text);
    extDtdWideStringToDom(content.value,pubId,sysId,refNode);
  finally
    content.free;
  end;
end;

procedure TXmlToDomParser.extDtdStreamToDom(const stream: TStream;
                                            const pubId,
                                                  sysId: wideString;
                                            const refNode: TdomCMNode);
var
  InputSrc: TXmlInputSource;
  oldRefNode: TdomCMNode;
begin
  oldRefNode:= ExtDtdBuilder.ReferenceNode;
  InputSrc:= TXmlInputSource.create(stream,pubId,sysId);
  try
    ExtDtdBuilder.ReferenceNode:= refNode;
    if not ExtDtdReader.parse(self,InputSrc)
      then raise EParserException.create('Parser error.');
  finally
    ExtDtdBuilder.ReferenceNode:= oldRefNode;
    InputSrc.free;
  end; {try}
end;

procedure TXmlToDomParser.extDtdMemoryToDom(const ptr: pointer;
                                            const size: longint;
                                            const pubId,
                                                  sysId: wideString;
                                            const refNode: TdomCMNode);
var
  MStream: TXmlMemoryStream;
begin
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    extDtdStreamToDom(MStream,pubId,sysId,refNode);
  finally
    MStream.free;
  end; {try}
end;

procedure TXmlToDomParser.extDtdStringToDom(const str: string;
                                            const pubId,
                                                  sysId: wideString;
                                            const refNode: TdomCMNode);
var
  ptr: PChar;
  size: longint;
begin
  if str = '' then exit;
  ptr:= pointer(str);
  size:= length(str);
  extDtdMemoryToDom(ptr,size,pubId,sysId,refNode);
end;


procedure TXmlToDomParser.extDtdWideStringToDom(      str: wideString;
                                                const pubId,
                                                      sysId: wideString;
                                                const refNode: TdomCMNode);
var
  ptr: pointer;
  size: longint;
begin
  if str = '' then exit;
  if str[1] <> #$feff
    then   str:= concat(wideString(#$feff),str);
  ptr:= pointer(str);
  size:= length(str)*2;
  extDtdMemoryToDom(ptr,size,pubId,sysId,refNode);
end;

procedure TXmlToDomParser.intDtdSourceCodeToDom(const intDtdSourceCode: TXmlSourceCode;
                                                const pubId,
                                                      sysId: wideString;
                                                const refNode: TdomCMNode);
var
  content: TdomCustomStr;
  i: integer;
begin
  content:= TdomCustomStr.create;
  try
    for i:= 0 to intDtdSourceCode.Count -1 do
      content.addWideString(TXmlSourceCodePiece(intDtdSourceCode[i]).text);
    intDtdWideStringToDom(content.value,pubId,sysId,refNode);
  finally
    content.free;
  end;
end;

procedure TXmlToDomParser.intDtdStreamToDom(const stream: TStream;
                                            const pubId,
                                                  sysId: wideString;
                                            const refNode: TdomCMNode);
var
  InputSrc: TXmlInputSource;
  oldRefNode: TdomCMNode;
begin
  oldRefNode:= IntDtdBuilder.ReferenceNode;
  InputSrc:= TXmlInputSource.create(stream,pubId,sysId);
  try
    IntDtdBuilder.ReferenceNode:= refNode;
    if not IntDtdReader.parse(self,InputSrc)
      then raise EParserException.create('Parser error.');
  finally
    IntDtdBuilder.ReferenceNode:= oldRefNode;
    InputSrc.free;
  end; {try}
end;

procedure TXmlToDomParser.intDtdMemoryToDom(const ptr: pointer;
                                            const size: longint;
                                            const pubId,
                                                  sysId: wideString;
                                            const refNode: TdomCMNode);
var
  MStream: TXmlMemoryStream;
begin
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    intDtdStreamToDom(MStream,pubId,sysId,refNode);
  finally
    MStream.free;
  end; {try}
end;

procedure TXmlToDomParser.intDtdStringToDom(const str: string;
                                            const pubId,
                                                  sysId: wideString;
                                            const refNode: TdomCMNode);
var
  ptr: PChar;
  size: longint;
begin
  ptr:= pointer(str);
  size:= length(str);
  if size = 0 then exit;
  intDtdMemoryToDom(ptr,size,pubId,sysId,refNode);
end;


procedure TXmlToDomParser.intDtdWideStringToDom(      str: wideString;
                                                const pubId,
                                                      sysId: wideString;
                                                const refNode: TdomCMNode);
var
  ptr: pointer;
  size: longint;
begin
  if str = '' then exit;
  if str[1] <> #$feff
    then   str:= concat(wideString(#$feff),str);
  ptr:= pointer(str);
  size:= length(str)*2;
  intDtdMemoryToDom(ptr,size,pubId,sysId,refNode);
end;

function TXmlToDomParser.fileToDom(const filename: TFileName): TdomDocument;
var
  MStream: TMemoryStream;
begin
  if not assigned(FDOMImpl)
    then raise EAccessViolation.create('DOMImplementation not specified.');
  if Filename = ''
    then raise EAccessViolation.create('Filename not specified.');
  MStream:= TMemoryStream.create;
  try
    MStream.LoadFromFile(Filename);
    ErrorHandler.clearErrorList;
    docStreamToDom(MStream,'',Filename,nil);
    Result:= docBuilder.ReferenceDocument;
  finally
    MStream.free;
  end; {try}
end;

function TXmlToDomParser.memoryToDom(const ptr: pointer;
                                     const size: longint): TdomDocument;
var
  MStream: TXmlMemoryStream;
begin
  if not assigned(FDOMImpl) then raise EAccessViolation.create('DOMImplementation not specified.');
  if not assigned(ptr) then raise EAccessViolation.create('pointer not specified.');
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    ErrorHandler.clearErrorList;
    docStreamToDom(MStream,'','',nil);
    Result:= docBuilder.ReferenceDocument;
  finally
    MStream.free;
  end; {try}
end;

function TXmlToDomParser.sourceCodeToDom(const intDtdSourceCode: TXmlSourceCode): TdomDocument;
var
  content: TdomCustomStr;
  i: integer;
begin
  if not assigned(intDtdSourceCode) then raise EAccessViolation.create('Stream not specified.');
  content:= TdomCustomStr.create;
  try
    for i:= 0 to intDtdSourceCode.Count -1 do
      content.addWideString(TXmlSourceCodePiece(intDtdSourceCode[i]).text);
    result:= wideStringToDom(content.value);
  finally
    content.free;
  end;
end;

function TXmlToDomParser.streamToDom(const stream: TStream): TdomDocument;
begin
  if not assigned(FDOMImpl) then raise EAccessViolation.create('DOMImplementation not specified.');
  if not assigned(stream) then raise EAccessViolation.create('Stream not specified.');
  ErrorHandler.clearErrorList;
  docStreamToDom(stream,'','',nil);
  Result:= docBuilder.ReferenceDocument;
end;

function TXmlToDomParser.stringToDom(const str: String): TdomDocument;
var
  ptr: PChar;
  size: longint;
  MStream: TXmlMemoryStream;
begin
  if not assigned(FDOMImpl)
    then raise EAccessViolation.create('DOMImplementation not specified.');
  ptr:= pointer(str);
  size:= length(str);
  if size = 0 then raise EAccessViolation.create('Empty string.');
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    ErrorHandler.clearErrorList;
    docStreamToDom(MStream,'','',nil);
    Result:= docBuilder.ReferenceDocument;
  finally
    MStream.free;
  end; {try}
end;

function TXmlToDomParser.wideStringToDom(str: wideString): TdomDocument;
var
  ptr: PChar;
  size: longint;
  MStream: TXmlMemoryStream;
begin
  if not assigned(FDOMImpl)
    then raise EAccessViolation.create('DOMImplementation not specified.');
  if str = '' then raise EAccessViolation.create('Empty string.');
  if str[1] <> #$feff
    then  str:= concat(wideString(#$feff),str);
  ptr:= pointer(str);
  size:= length(str)*2;
  MStream:= TXmlMemoryStream.create;
  try
    MStream.SetPointer(ptr,size);
    ErrorHandler.clearErrorList;
    docStreamToDom(MStream,'','',nil);
    Result:= docBuilder.ReferenceDocument;
  finally
    MStream.free;
  end; {try}
end;

end.
