#pragma warning( disable : 4100 )
#pragma warning( disable : 4127 )
#pragma warning( disable : 4189 )
#pragma warning( disable : 4355 )
#pragma warning( disable : 4503 )
#pragma warning( disable : 4505 )
#pragma warning( disable : 4512 )
#pragma warning( disable:  4651 )
#pragma warning( disable : 4691 )
#pragma warning( disable : 4723 )
#pragma warning( disable : 4702 )
#define SCOPE_NO_UDT
#if defined(COMPILE_NATIVE)
#include "ScopeCommonError.h"
#include "ScopeError.h"
#include "ScopeOperators.h"
#endif
#if defined(COMPILE_MANAGED)
#using <mscorlib.dll>
[assembly: System::Runtime::Versioning::TargetFrameworkAttribute(".NETFramework,Version=v4.5", FrameworkDisplayName = ".NET Framework, Version 4.5")];
#include "ScopeCommonError.h"
#include "SqlManaged.h"
#endif
#if defined(COMPILE_NATIVE)
#endif
using namespace ScopeEngine;
static ScopeEngine::CompilerSettings GetCompilerSettings()
{
    static ScopeEngine::CompilerSettings settings;
    settings.m_restrictOperatorMemorySpilling = false;
    settings.m_verboseRuntimeStatistic = false;
    return settings;
};

enum OperatorUID
{
UID_RowGenerator_0 = 1,
UID_RowGenerator_0_Data0 = 2,
UID_Process_1 = 3,
UID_Process_1_Data0 = 4,
UID_Process_2 = 5,
UID_Process_2_Data0 = 6,
UID_SV1_Extract_out0 = 7,
UID_Process_1_0,
UID_Process_1_1
};
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

//namespace ScopeGeneratedClasses
//{
    // IDs representing UDTs to be used in native code
    enum UserDefinedTypeId
    {
        
    };

#if defined(COMPILE_MANAGED)
// Explicit instantiations for templated functions that are defined in managed code
#endif // defined(COMPILE_MANAGED)


    class PartitionSchema_RowGenerator_0
    {
    public:
        PartitionSchema_RowGenerator_0();
        PartitionSchema_RowGenerator_0(const PartitionSchema_RowGenerator_0 & c, IncrementalAllocator * alloc);

        template <typename Allocator>
        PartitionSchema_RowGenerator_0(const PartitionSchema_RowGenerator_0 & c, FixedArrayTypeMemoryManager<Allocator> * mmng);

        template <typename Allocator>
        void Delete(FixedArrayTypeMemoryManager<Allocator> * mmng);


        static string GetDefinition()
        {
            return std::string{};
        }

        static const bool containsUDT = false;

        UINT8 GetScopeCEPEventType() const { return 0; }
        ScopeDateTime GetScopeCEPEventStartTime() const { return ScopeDateTime::MinValue; }
        void SetScopeCEPEventStartTime(ScopeDateTime& startTime) {}
        void SetScopeCEPEventType(int type) {}
        bool IsScopeCEPCTI() const { return false; }
        void ResetScopeCEPStatus(ScopeDateTime startTime, ScopeDateTime endTime, int type) { }

        static const std::string GetSchema()
        {
            return std::string{};
        }

        friend ostream & operator<<(ostream & os, PartitionSchema_RowGenerator_0 & row);

    };


    INLINE ostream & operator<<(ostream & os, PartitionSchema_RowGenerator_0 & row)
    {
        std::string schema = row.GetSchema();
        ScopeEngine::OutputRowContent(schema, &row, os);
        return os;
    }



    class Process_1_Data0
    {
    public:
        NativeNullable<__int64> m_RowNumber0__;
        Process_1_Data0();
        Process_1_Data0(const Process_1_Data0 & c, IncrementalAllocator * alloc);

        template <typename Allocator>
        Process_1_Data0(const Process_1_Data0 & c, FixedArrayTypeMemoryManager<Allocator> * mmng);

        template <typename Allocator>
        void Delete(FixedArrayTypeMemoryManager<Allocator> * mmng);



        static const bool containsUDT = false;

        UINT8 GetScopeCEPEventType() const { return 0; }
        ScopeDateTime GetScopeCEPEventStartTime() const { return ScopeDateTime::MinValue; }
        void SetScopeCEPEventStartTime(ScopeDateTime& startTime) {}
        void SetScopeCEPEventType(int type) {}
        bool IsScopeCEPCTI() const { return false; }
        void ResetScopeCEPStatus(ScopeDateTime startTime, ScopeDateTime endTime, int type) { }

        static const std::string GetSchema()
        {
            return std::string{ u8"RowNumber0__:long?" };
        }

        friend ostream & operator<<(ostream & os, Process_1_Data0 & row);

    };


    INLINE ostream & operator<<(ostream & os, Process_1_Data0 & row)
    {
        std::string schema = row.GetSchema();
        ScopeEngine::OutputRowContent(schema, &row, os);
        return os;
    }



    class Process_2_Data0
    {
    public:
        FString m_Field1;
        Process_2_Data0();
        Process_2_Data0(const Process_2_Data0 & c, IncrementalAllocator * alloc);

        template <typename Allocator>
        Process_2_Data0(const Process_2_Data0 & c, FixedArrayTypeMemoryManager<Allocator> * mmng);

        template <typename Allocator>
        void Delete(FixedArrayTypeMemoryManager<Allocator> * mmng);



        static const bool containsUDT = false;

        UINT8 GetScopeCEPEventType() const { return 0; }
        ScopeDateTime GetScopeCEPEventStartTime() const { return ScopeDateTime::MinValue; }
        void SetScopeCEPEventStartTime(ScopeDateTime& startTime) {}
        void SetScopeCEPEventType(int type) {}
        bool IsScopeCEPCTI() const { return false; }
        void ResetScopeCEPStatus(ScopeDateTime startTime, ScopeDateTime endTime, int type) { }

        static const std::string GetSchema()
        {
            return std::string{ u8"Field1:string" };
        }

        friend ostream & operator<<(ostream & os, Process_2_Data0 & row);

    };


    INLINE ostream & operator<<(ostream & os, Process_2_Data0 & row)
    {
        std::string schema = row.GetSchema();
        ScopeEngine::OutputRowContent(schema, &row, os);
        return os;
    }



#if defined(COMPILE_MANAGED)

#endif // defined(COMPILE_MANAGED)


//}

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

#if defined(COMPILE_NATIVE)
    template<> 
    class BinaryExtractPolicy<PartitionSchema_RowGenerator_0>
    {
    public:
        static bool Deserialize(BinaryInputStream * input, PartitionSchema_RowGenerator_0 & row)
        {
            try
            {
                char b = 0;
                input->Read(b);
            }
            catch (ScopeStreamException &) 
            {
                // we reach the end of file
                return false;
            }

            return true;
        }
        static bool DeserializeKeyForSS(MemoryInputStream * input, PartitionSchema_RowGenerator_0 & row)
        {
            try
            {
                char b = 0;
                input->Read(b);
            }
            catch (ScopeStreamException &) 
            {
                // we reach the end of file
                return false;
            }

            return true;
        }
        static void DeserializeKey(ResourceInputStream * input, PartitionSchema_RowGenerator_0 & row)
        {
            char type = 0, null = 0;
        }
        static void DeserializePartitionSpec(ResourceInputStream * input, PartitionSchema_RowGenerator_0 & row)
        {
            return ;
        }

    };
#endif // defined(COMPILE_NATIVE)

    template<> 
    class BinaryOutputPolicy<PartitionSchema_RowGenerator_0>
    {
    public:
    
        static void SerializeHeader(BinaryOutputStream * output)
        {
            SCOPE_ASSERT(!"BinaryOutputPolicy::SerializeHeader method should not be invoked.");
        }
        
        __declspec(noinline) static void Serialize(BinaryOutputStream * output, PartitionSchema_RowGenerator_0 & row)
        {
            SIZE_T rowStart =  output->GetOutputer().GetCurrentPosition();
            char b = 0;
            output->Write(b);
            SIZE_T rowSize =  output->GetOutputer().GetCurrentPosition() - rowStart;
            auto rowLimit = ScopeEngine::Configuration::GetGlobal().GetMaxOnDiskRowSize();
            if (rowSize > rowLimit)
            {
                std::stringstream ss;
                ss << row << std::endl;
                throw RuntimeException(E_USER_ONDISKROW_TOO_BIG, {rowSize, rowLimit, ss.str()});
            }
        }
        static void Serialize(DummyOutputStream * output, const PartitionSchema_RowGenerator_0 & row)
        {
            SCOPE_ASSERT(false); 
        }
        static void SerializeKeyForSS(MemoryOutputStream* output, const PartitionSchema_RowGenerator_0 & row)        
        {
            output->Write(false);
        }
    };

#pragma region Schema Constructors
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    INLINE PartitionSchema_RowGenerator_0::PartitionSchema_RowGenerator_0()
    {
    }
    INLINE PartitionSchema_RowGenerator_0::PartitionSchema_RowGenerator_0(const PartitionSchema_RowGenerator_0 & c, IncrementalAllocator * alloc)
    {
    }

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    INLINE Process_1_Data0::Process_1_Data0()
    {
    }
    INLINE Process_1_Data0::Process_1_Data0(const Process_1_Data0 & c, IncrementalAllocator * alloc) :
            m_RowNumber0__(c.m_RowNumber0__)
    {
    }

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    INLINE Process_2_Data0::Process_2_Data0()
    {
    }

#pragma endregion Schema Constructors
#pragma hdrstop
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


#if defined(COMPILE_INIT_SHUTDOWN)
#if defined(COMPILE_MANAGED)
extern "C" __declspec(dllexport) void __stdcall InitVertexManaged(std::string * argv, int argc)
{
#if defined(FORCEMANAGEDDATETIMESER)
    ScopeEngine::ScopeDateTime::ForceManagedSerialization = true;
#endif
    cli::array<String^>^ arguments = ScopeEngineManaged::GroupArguments(argv, argc);
    ScopeEngineManaged::InitializeScopeEngineManaged(arguments);
}

extern "C" __declspec(dllexport) void __stdcall ShutdownVertexManaged(CLRMemoryStat& stat)
{
    ScopeEngineManaged::FinalizeScopeEngineManaged(stat);
}
#endif //#if defined(COMPILE_MANAGED)

#if defined(COMPILE_NATIVE)
ScopeEngine::ScopeCEPCheckpointManager* g_scopeCEPCheckpointManager = NULL;

extern "C" __declspec(dllexport) void __stdcall InitVertexNative(VertexExecutionInfo * vertexExecutionInfo)
{
#if defined(FORCEMANAGEDDATETIMESER)
    ScopeEngine::ScopeDateTime::ForceManagedSerialization = true;
#endif

    ErrorManager::GetGlobal()->EnableJSON();
}

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.



// Add broadcast vertex code
extern "C" __declspec(dllexport) void __stdcall SV_CopyThrough_execute(std::string * argv, int argc, InputFileInfo* inputs, int inputCnt, OutputFileInfo* outputs, int outputCnt, VertexExecutionInfo * vertexExecutionInfo)
{
    SCOPE_ASSERT(inputCnt == 1 && outputCnt == 1);
    IOManager::CopyStream(IOManager::GetGlobal()->GetDevice(inputs[0].inputFileName), IOManager::GetGlobal()->GetDevice(outputs[0].outputFileName));
}

#endif //#if defined(COMPILE_NATIVE)


#endif //#if defined(COMPILE_INIT_SHUTDOWN)
#pragma region SV1_Extract
#if defined(COMPILE_SV1_EXTRACT) || defined(COMPILE_ALL_VERTICES)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

#if defined(COMPILE_NATIVE)
    template<>
    class RowGeneratePolicy<PartitionSchema_RowGenerator_0, UID_RowGenerator_0>
    {
    public:
        static const unsigned __int64 m_cRows = 1;
        typedef PartitionSchema_RowGenerator_0 PartitionSchema;
        static const bool m_generateMetadata = false;
        static const PartitioningType m_partitioning = Invalid;
        static const bool m_truncatedRangeKey = false;
    };

#endif // defined(COMPILE_NATIVE)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    template<> 
    class KeyComparePolicy<PartitionSchema_RowGenerator_0,UID_Process_1_0>
    {
    public:
        struct KeyStruct
        {

            KeyStruct(PartitionSchema_RowGenerator_0 & c) 

            {
            }

            KeyStruct(const PartitionSchema_RowGenerator_0 & c, IncrementalAllocator * alloc) 

            {
            }

            KeyStruct(KeyStruct & c) 

            {
            }

            KeyStruct(const KeyStruct & c, IncrementalAllocator * alloc) 

            {
            }

            KeyStruct() 

            {
            }
#if defined(SCOPE_DEBUG)
            friend ostream & operator<<(ostream & os, KeyStruct & row)
            {
              return os;
            }
#endif // defined(SCOPE_DEBUG)
        };

        typedef KeyStruct KeyType;

        static int Compare(PartitionSchema_RowGenerator_0 & row, KeyType & key)
        {
            int r = 0;
            return r;
        }

        static int Compare(PartitionSchema_RowGenerator_0 * n1, PartitionSchema_RowGenerator_0 * n2)
        {
            int r = 0;
            return r;
        }

    };

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    template<> 
    class KeyComparePolicy<PartitionSchema_RowGenerator_0,UID_Process_1_1>
    {
    public:
        struct KeyStruct
        {

            KeyStruct(PartitionSchema_RowGenerator_0 & c) 

            {
            }

            KeyStruct(const PartitionSchema_RowGenerator_0 & c, IncrementalAllocator * alloc) 

            {
            }

            KeyStruct(KeyStruct & c) 

            {
            }

            KeyStruct(const KeyStruct & c, IncrementalAllocator * alloc) 

            {
            }

            KeyStruct() 

            {
            }
#if defined(SCOPE_DEBUG)
            friend ostream & operator<<(ostream & os, KeyStruct & row)
            {
              return os;
            }
#endif // defined(SCOPE_DEBUG)
        };

        typedef KeyStruct KeyType;

        static int Compare(PartitionSchema_RowGenerator_0 & row, KeyType & key)
        {
            int r = 0;
            return r;
        }

        static int Compare(PartitionSchema_RowGenerator_0 * n1, PartitionSchema_RowGenerator_0 * n2)
        {
            int r = 0;
            return r;
        }

    };

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    template<>
    class RowTransformPolicy<PartitionSchema_RowGenerator_0, Process_1_Data0, UID_Process_1>
    {
    public:

        static bool FilterTransformRow(PartitionSchema_RowGenerator_0 & input, Process_1_Data0 & output, IncrementalAllocator * alloc)
        {
}

            #pragma warning(push)
            #pragma warning(disable: 4100) // 'alloc': unreferenced formal parameter
            static void InitializeStatics(IncrementalAllocator * alloc)
            {
            #pragma warning(pop)
            }
    
            // get operator resource requirements
            static OperatorRequirements GetOperatorRequirements()
            {
                return OperatorRequirements();
            }
        };
    

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


#if defined(COMPILE_MANAGED)
#endif // defined(COMPILE_MANAGED)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

#if defined(COMPILE_NATIVE)
    template<> 
    class SequenceProjectPolicy<typename PartitionSchema_RowGenerator_0, typename Process_1_Data0, UID_Process_1> 
    {
    public:
        typedef KeyComparePolicy<PartitionSchema_RowGenerator_0, UID_Process_1_0> GroupKeyPolicy;
        typedef KeyComparePolicy<PartitionSchema_RowGenerator_0, UID_Process_1_1> ValueKeyPolicy;

        void SetVertexID(__int64 vertexID)
        {
            m_vertexID = vertexID;
        }

        // Advance all sequence functions to the next row, and copy their values to the output.
        //
        void AdvanceAndOutput(bool isNewGroup, bool isNewOrder, Process_1_Data0 &output, PartitionSchema_RowGenerator_0 &input)
        {
                output.m_RowNumber0__ = _function0.Step(isNewGroup);
        }

    private:
        __int64 m_vertexID;
            SequenceFunction_ROW_NUMBER _function0;
    };
#endif // defined(COMPILE_NATIVE)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

    static const char * StringTable_Process_2 [] =
    {
        "new System.String[]{\"Hello World\"}[(int)(RowNumber0__ - 1L)]",
        "\"*** After Last Expression ***\"",
    };

    template<>
    class RowTransformPolicy<Process_1_Data0, Process_2_Data0, UID_Process_2>
    {
    public:

        static bool FilterTransformRow(Process_1_Data0 & input, Process_2_Data0 & output, IncrementalAllocator * alloc)
        {

            int exceptionIndex = 0;
            try
            {
                    output.m_Field1 = staticarray_0[scope_cast<int>((scope_cast<__int64>(input.m_RowNumber0__) - 1LL))];
                    exceptionIndex++;
                    return true;
                    }
                    catch(...)
                    {
                        std::throw_with_nested(RuntimeExpressionException(StringTable_Process_2[exceptionIndex]));
                    }
    }

        static const StaticArrayHelper<FString> staticarray_0;
        static const char * const staticarray_0_str[1];
        static const std::uint32_t staticarray_0_len[1];
            #pragma warning(push)
            #pragma warning(disable: 4100) // 'alloc': unreferenced formal parameter
            static void InitializeStatics(IncrementalAllocator * alloc)
            {
            #pragma warning(pop)
            }
    
            // get operator resource requirements
            static OperatorRequirements GetOperatorRequirements()
            {
                return OperatorRequirements().AddMemoryInRows(1, 1);
            }
        };
    
    #if defined(COMPILE_NATIVE)
        const StaticArrayHelper<FString> RowTransformPolicy<Process_1_Data0, Process_2_Data0, UID_Process_2>::staticarray_0
        {
            RowTransformPolicy<Process_1_Data0, Process_2_Data0, UID_Process_2>::staticarray_0_str,
            RowTransformPolicy<Process_1_Data0, Process_2_Data0, UID_Process_2>::staticarray_0_len
        };
        const char * const RowTransformPolicy<Process_1_Data0, Process_2_Data0, UID_Process_2>::staticarray_0_str[1] =
        {
            "Hello World"
        };
        const std::uint32_t RowTransformPolicy<Process_1_Data0, Process_2_Data0, UID_Process_2>::staticarray_0_len[1] =
        {
            11U
        };
    #endif // COMPILE_NATIVE
#if defined(COMPILE_NATIVE)
#pragma warning(push)
#pragma warning(disable:4592)
#pragma warning(pop)
#endif // defined(COMPILE_NATIVE)

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


#if defined(COMPILE_MANAGED)
#endif // defined(COMPILE_MANAGED)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

    template<> 
    class TextOutputPolicy<Process_2_Data0, UID_SV1_Extract_out0>
    {
    public:

        static void Serialize(TextOutputStream<TextOutputStreamTraitsConst<',', '\0', false, false, true, false, true, UTF8, true, CharFormat_uint16>, CosmosOutput> * output, Process_2_Data0 & row)
        {
            if (!row.m_Field1.IsNull())
            {
                output->Write<FString,true>(row.m_Field1);
            }
            output->WriteNewLine();
        }

        static void SerializeHeader(TextOutputStream<TextOutputStreamTraitsConst<',', '\0', false, false, true, false, true, UTF8, true, CharFormat_uint16>, CosmosOutput> * output)
        {
            SCOPE_ASSERT(!"TextOutputPolicy::SerializeHeader method should not be invoked.");
        }
    };

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


#if defined(COMPILE_MANAGED)
#endif // defined(COMPILE_MANAGED)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.



#if defined(COMPILE_NATIVE)
namespace ScopeGeneratedClasses
{
    extern "C" __declspec(dllexport) void __stdcall SV1_Extract_execute(std::string * argv, int argc, InputFileInfo* inputs, int inputCnt, OutputFileInfo* outputs, int outputCnt, VertexExecutionInfo * vertexExecutionInfo)
    {
#ifdef USE_SSE4_2
        // check CPUID to make sure this machine supports SSE4_2 instructions
        // - this is incase we download a cluster vertex and try and debug it on a machine that doesn't support these instructions
        int cpuInfo[4];
        __cpuid(cpuInfo, 0x00000001);
        //Array index | Bit range | Description 
        // 2          | 20        | SSE4.2 extensions
        if ((cpuInfo[2] & (1 << 20)) == 0)
        {
            throw RuntimeException(E_USER_ERROR, "Please recompile __ScopeCodeGenEngine__.dll without /DUSE_SSE4_2");
            return;
        }
#endif

        Configuration::Create(ET_Azure, GetCompilerSettings(), vertexExecutionInfo);
        SIZE_T x_inputBufSize, x_outputBufSize, x_inputVirtualMemoryLimit;
        int    x_inputBufCnt, x_outputBufCnt;
        
        MemoryManager::CalculateIOBufferSize(inputCnt, outputCnt, MemoryManager::x_vertexMemoryLimit, MemoryManager::x_vertexReserveMemory, x_inputBufSize, x_inputBufCnt, x_outputBufSize, x_outputBufCnt, x_inputVirtualMemoryLimit, false);

        const bool IsNativeOnlyVertex = true;
                int x_partitionIndex_RowGenerator_0_0 = 0;
                SCOPE_ASSERT(x_partitionIndex_RowGenerator_0_0 >= 0);
                // Define extractor type and construct object
        typedef RowGenerator<PartitionSchema_RowGenerator_0, RowGeneratePolicy<PartitionSchema_RowGenerator_0, UID_RowGenerator_0>, UID_RowGenerator_0> ExtractorType1_SV1_Extract;        
        unique_ptr<ExtractorType1_SV1_Extract> extractor_0_ptr= make_unique<ExtractorType1_SV1_Extract>(x_partitionIndex_RowGenerator_0_0, "", UID_RowGenerator_0);
        ExtractorType1_SV1_Extract * extractor_0 = extractor_0_ptr.get();
        ULONG extractor_0_count = 1;
        // Define the type of the operator
        typedef SequenceProject<ExtractorType1_SV1_Extract, PartitionSchema_RowGenerator_0, Process_1_Data0, UID_Process_1> SequenceProjectType_Process_1;
        // Construct operator and initialize it.
        unique_ptr<SequenceProjectType_Process_1> sequence_project_Process_1_ptr (new SequenceProjectType_Process_1(extractor_0, UID_Process_1));
        SequenceProjectType_Process_1 * sequence_project_Process_1 = sequence_project_Process_1_ptr.get();
        ULONG sequence_project_Process_1_count = 1;
        __int64 sequence_project_vertexID_Process_1 = vertexExecutionInfo->m_vertexId;
        sequence_project_Process_1->SetVertexID(sequence_project_vertexID_Process_1);
        // Define the type of the operator
        typedef FilterTransformer<SequenceProjectType_Process_1, Process_1_Data0, Process_2_Data0, UID_Process_2> FilterTransformerType_Process_2;
        // Construct operator and initialize it.
        unique_ptr<FilterTransformerType_Process_2> filterTransformer_Process_2_ptr (new FilterTransformerType_Process_2(sequence_project_Process_1, UID_Process_2));
        FilterTransformerType_Process_2 * filterTransformer_Process_2 = filterTransformer_Process_2_ptr.get();
        ULONG filterTransformer_Process_2_count = 1;
        // Define outputer type
        typedef Outputer<FilterTransformerType_Process_2, Process_2_Data0, TextOutputPolicy<Process_2_Data0, UID_SV1_Extract_out0>, TextOutputStream<TextOutputStreamTraitsConst<',', '\0', false, false, true, false, true, UTF8, true, CharFormat_uint16>, CosmosOutput>, false> OutputerType2_SV1_Extract;
        // Construct operator and initialize it
        unique_ptr<OutputerType2_SV1_Extract> outputer_SV1_Extract_out0_ptr(new OutputerType2_SV1_Extract(filterTransformer_Process_2, outputs[0].outputFileName, false, x_outputBufSize, x_outputBufCnt, OutputStreamParameters(',', "\r\n", '\0', static_cast<const char*>(__nullptr), false, false, true, false, "O", UTF8, true, CharFormat_uint16), UID_SV1_Extract_out0));
        OutputerType2_SV1_Extract * outputer_SV1_Extract_out0 = outputer_SV1_Extract_out0_ptr.get();
        try
        {
            // Init operator chain
            outputer_SV1_Extract_out0->Init();

            // Execute the whole vertex by calling the GetNextRow on top operator
            Process_2_Data0 row;
            outputer_SV1_Extract_out0->GetNextRow(row);

            // Close operator chain
            outputer_SV1_Extract_out0->Close();
        }
        catch (const ExceptionWithStack& ex)
        {
            if (vertexExecutionInfo->m_reportStatusFunc != NULL)
            {
                ErrorManager::GetGlobal()->SetError(std::current_exception(), "VertexExecute");
                vertexExecutionInfo->m_reportStatusFunc(vertexExecutionInfo->m_statusReportContext);
            }
            
            std::cout << "Caught exception: " << ex.what() << std::endl << ex.GetStack() << std::endl;
            throw;
        }


        // Write out execution stats
        MemoryManager::GetGlobal()->WriteRuntimeStats(vertexExecutionInfo->m_statsRoot);
        outputer_SV1_Extract_out0->WriteRuntimeStats(vertexExecutionInfo->m_statsRoot);
    }
}
#endif // defined(COMPILE_NATIVE)

#if defined(COMPILE_MANAGED)
#endif // defined(COMPILE_MANAGED)
#if defined(COMPILE_NATIVE)
#endif // defined(COMPILE_NATIVE)

#endif
#pragma endregion SV1_Extract
// Empty footer
