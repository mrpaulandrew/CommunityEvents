#pragma warning( disable : 4100 )
#pragma warning( disable : 4127 )
#pragma warning( disable : 4189 )
#pragma warning( disable : 4355 )
#pragma warning( disable : 4503 )
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
enum OperatorUID
{
UID_Extract_0 = 1,
UID_Extract_0_Data0 = 2,
UID_Process_1 = 3,
UID_Process_1_Data0 = 4,
UID_Process_2 = 5,
UID_Process_2_Data0 = 6,
UID_Process_3 = 7,
UID_Process_3_Data0 = 8,
UID_Process_4 = 9,
UID_Process_4_Data0 = 10,
UID_Process_5 = 11,
UID_Process_5_Data0 = 12,
UID_SV1_Extract_out0 = 13,
UID_Process_3_Prefix,
UID_ParallelUnionAll_Process_1
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


    class Extract_0_Data0
    {
    public:
        FString m_Requestdate;
        FString m_Enduser;
        FString m_CompanyName;
        FString m_Licensekey;
        FString m_Reseller;
        FString m_Product;
        FString m_Status;
        FString m_InvoiceDate;
        FString m_AmountDollars;
        FString m_AmountPounds;
        FString m_AmountEuros;
        FString m_ReportingAmount;
        FString m_POfilename;
        FString m_Beneficiary;
        FString m_Invoice;
        FString m_LicenseTerm;
        FString m_LicenseEnd;
        FString m_Column16;
        FString m_SalesRegion;
        Extract_0_Data0();
        Extract_0_Data0(const Extract_0_Data0 & c, IncrementalAllocator * alloc);

        template <typename Allocator>
        Extract_0_Data0(const Extract_0_Data0 & c, FixedArrayTypeMemoryManager<Allocator> * mmng);

        template <typename Allocator>
        void Delete(FixedArrayTypeMemoryManager<Allocator> * mmng);



        static const bool containsUDT = false;

        UINT8 GetScopeCEPEventType() const { return 0; }
        ScopeDateTime GetScopeCEPEventStartTime() const { return ScopeDateTime::MinValue; }
        void SetScopeCEPEventStartTime(ScopeDateTime& startTime) {}
        void SetScopeCEPEventType(int type) {}
        bool IsScopeCEPCTI() const { return false; }
        void ResetScopeCEPStatus(ScopeDateTime startTime, ScopeDateTime endTime, int type) { }
        
#if defined(SCOPE_DEBUG)
        friend ostream & operator<<(ostream & os, Extract_0_Data0 & row);
#endif // defined(SCOPE_DEBUG)
    };

#if defined(SCOPE_DEBUG)
    INLINE ostream & operator<<(ostream & os, Extract_0_Data0 & row)
    {
        os << "\t" << std::string{ u8"Requestdate" } << ":\t" << row.m_Requestdate << endl;
        os << "\t" << std::string{ u8"Enduser" } << ":\t" << row.m_Enduser << endl;
        os << "\t" << std::string{ u8"CompanyName" } << ":\t" << row.m_CompanyName << endl;
        os << "\t" << std::string{ u8"Licensekey" } << ":\t" << row.m_Licensekey << endl;
        os << "\t" << std::string{ u8"Reseller" } << ":\t" << row.m_Reseller << endl;
        os << "\t" << std::string{ u8"Product" } << ":\t" << row.m_Product << endl;
        os << "\t" << std::string{ u8"Status" } << ":\t" << row.m_Status << endl;
        os << "\t" << std::string{ u8"InvoiceDate" } << ":\t" << row.m_InvoiceDate << endl;
        os << "\t" << std::string{ u8"AmountDollars" } << ":\t" << row.m_AmountDollars << endl;
        os << "\t" << std::string{ u8"AmountPounds" } << ":\t" << row.m_AmountPounds << endl;
        os << "\t" << std::string{ u8"AmountEuros" } << ":\t" << row.m_AmountEuros << endl;
        os << "\t" << std::string{ u8"ReportingAmount" } << ":\t" << row.m_ReportingAmount << endl;
        os << "\t" << std::string{ u8"POfilename" } << ":\t" << row.m_POfilename << endl;
        os << "\t" << std::string{ u8"Beneficiary" } << ":\t" << row.m_Beneficiary << endl;
        os << "\t" << std::string{ u8"Invoice" } << ":\t" << row.m_Invoice << endl;
        os << "\t" << std::string{ u8"LicenseTerm" } << ":\t" << row.m_LicenseTerm << endl;
        os << "\t" << std::string{ u8"LicenseEnd" } << ":\t" << row.m_LicenseEnd << endl;
        os << "\t" << std::string{ u8"Column16" } << ":\t" << row.m_Column16 << endl;
        os << "\t" << std::string{ u8"SalesRegion" } << ":\t" << row.m_SalesRegion << endl;
        return os;
    }
#endif // defined(SCOPE_DEBUG)


    class Process_1_Data0
    {
    public:
        FString m_Reseller;
        __int64 m_partialagg0__;
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
        
#if defined(SCOPE_DEBUG)
        friend ostream & operator<<(ostream & os, Process_1_Data0 & row);
#endif // defined(SCOPE_DEBUG)
    };

#if defined(SCOPE_DEBUG)
    INLINE ostream & operator<<(ostream & os, Process_1_Data0 & row)
    {
        os << "\t" << std::string{ u8"Reseller" } << ":\t" << row.m_Reseller << endl;
        os << "\t" << std::string{ u8"partialagg0__" } << ":\t" << row.m_partialagg0__ << endl;
        return os;
    }
#endif // defined(SCOPE_DEBUG)


    class HashAggregatorKey_Process_2
    {
    public:
        FString m_Reseller;
        HashAggregatorKey_Process_2();
        HashAggregatorKey_Process_2(const HashAggregatorKey_Process_2 & c, IncrementalAllocator * alloc);

        template <typename Allocator>
        HashAggregatorKey_Process_2(const HashAggregatorKey_Process_2 & c, FixedArrayTypeMemoryManager<Allocator> * mmng);

        template <typename Allocator>
        void Delete(FixedArrayTypeMemoryManager<Allocator> * mmng);



        static const bool containsUDT = false;

        UINT8 GetScopeCEPEventType() const { return 0; }
        ScopeDateTime GetScopeCEPEventStartTime() const { return ScopeDateTime::MinValue; }
        void SetScopeCEPEventStartTime(ScopeDateTime& startTime) {}
        void SetScopeCEPEventType(int type) {}
        bool IsScopeCEPCTI() const { return false; }
        void ResetScopeCEPStatus(ScopeDateTime startTime, ScopeDateTime endTime, int type) { }
        
#if defined(SCOPE_DEBUG)
        friend ostream & operator<<(ostream & os, HashAggregatorKey_Process_2 & row);
#endif // defined(SCOPE_DEBUG)
    };

#if defined(SCOPE_DEBUG)
    INLINE ostream & operator<<(ostream & os, HashAggregatorKey_Process_2 & row)
    {
        os << "\t" << std::string{ u8"Reseller" } << ":\t" << row.m_Reseller << endl;
        return os;
    }
#endif // defined(SCOPE_DEBUG)


    class HashAggregatorState_Process_2
    {
    public:
        __int64 m_UNCHECKED_SUM_partialagg0__;
        HashAggregatorState_Process_2();
        HashAggregatorState_Process_2(const HashAggregatorState_Process_2 & c, IncrementalAllocator * alloc);

        template <typename Allocator>
        HashAggregatorState_Process_2(const HashAggregatorState_Process_2 & c, FixedArrayTypeMemoryManager<Allocator> * mmng);

        template <typename Allocator>
        void Delete(FixedArrayTypeMemoryManager<Allocator> * mmng);



        static const bool containsUDT = false;

        UINT8 GetScopeCEPEventType() const { return 0; }
        ScopeDateTime GetScopeCEPEventStartTime() const { return ScopeDateTime::MinValue; }
        void SetScopeCEPEventStartTime(ScopeDateTime& startTime) {}
        void SetScopeCEPEventType(int type) {}
        bool IsScopeCEPCTI() const { return false; }
        void ResetScopeCEPStatus(ScopeDateTime startTime, ScopeDateTime endTime, int type) { }
        
#if defined(SCOPE_DEBUG)
        friend ostream & operator<<(ostream & os, HashAggregatorState_Process_2 & row);
#endif // defined(SCOPE_DEBUG)
    };

#if defined(SCOPE_DEBUG)
    INLINE ostream & operator<<(ostream & os, HashAggregatorState_Process_2 & row)
    {
        os << "\t" << std::string{ u8"UNCHECKED_SUM_partialagg0__" } << ":\t" << row.m_UNCHECKED_SUM_partialagg0__ << endl;
        return os;
    }
#endif // defined(SCOPE_DEBUG)


    class Process_5_Data0
    {
    public:
        FString m_Reseller;
        NativeNullable<__int64> m_RecordCount;
        Process_5_Data0();
        Process_5_Data0(const Process_5_Data0 & c, IncrementalAllocator * alloc);

        template <typename Allocator>
        Process_5_Data0(const Process_5_Data0 & c, FixedArrayTypeMemoryManager<Allocator> * mmng);

        template <typename Allocator>
        void Delete(FixedArrayTypeMemoryManager<Allocator> * mmng);



        static const bool containsUDT = false;

        UINT8 GetScopeCEPEventType() const { return 0; }
        ScopeDateTime GetScopeCEPEventStartTime() const { return ScopeDateTime::MinValue; }
        void SetScopeCEPEventStartTime(ScopeDateTime& startTime) {}
        void SetScopeCEPEventType(int type) {}
        bool IsScopeCEPCTI() const { return false; }
        void ResetScopeCEPStatus(ScopeDateTime startTime, ScopeDateTime endTime, int type) { }
        
#if defined(SCOPE_DEBUG)
        friend ostream & operator<<(ostream & os, Process_5_Data0 & row);
#endif // defined(SCOPE_DEBUG)
    };

#if defined(SCOPE_DEBUG)
    INLINE ostream & operator<<(ostream & os, Process_5_Data0 & row)
    {
        os << "\t" << std::string{ u8"Reseller" } << ":\t" << row.m_Reseller << endl;
        os << "\t" << std::string{ u8"RecordCount" } << ":\t" << row.m_RecordCount << endl;
        return os;
    }
#endif // defined(SCOPE_DEBUG)


#if defined(COMPILE_MANAGED)

#endif // defined(COMPILE_MANAGED)


//}

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

#if defined(COMPILE_NATIVE)
    template<> 
    class BinaryExtractPolicy<Process_1_Data0>
    {
    public:
        static bool Deserialize(BinaryInputStream * input, Process_1_Data0 & row)
        {
            try
            {
                char b = 0;
                input->Read(b);
                if (b==0)
                {
                    input->Read(row.m_Reseller);
                    input->Read(row.m_partialagg0__);
                }
                else
                {
                    char ___masking___[1];
                    ___masking___[0] = b;
                    if ((___masking___[0] & 2 ) != 2)
                    {
                        input->Read(row.m_Reseller);
                    }
                    else
                    {
                        row.m_Reseller.SetNull();
                    }
                    input->Read(row.m_partialagg0__);
                }
            }
            catch (ScopeStreamException &) 
            {
                // we reach the end of file
                return false;
            }

            return true;
        }
    };
#endif // defined(COMPILE_NATIVE)

    template<> 
    class BinaryOutputPolicy<Process_1_Data0>
    {
    public:
    
        static void SerializeHeader(BinaryOutputStream * output)
        {
            SCOPE_ASSERT(!"BinaryOutputPolicy::SerializeHeader method should not be invoked.");
        }
        
        __declspec(noinline) static void Serialize(BinaryOutputStream * output, Process_1_Data0 & row)
        {
            SIZE_T rowStart =  output->GetOutputer().GetCurrentPosition();
            char b = 0;
            char ___masking___[1];
            ___masking___[0] = 1;
            bool hasNull = false;
            if (row.m_Reseller.IsNull())
            {
                hasNull = true;
                ___masking___[0] |= 2;
            }
            if (hasNull)
            {
                output->Write(___masking___[0]);
            }
            else
            {
                output->Write(b);
            }
            if (!row.m_Reseller.IsNull())
            {
                output->Write(row.m_Reseller);
            }
            output->Write(row.m_partialagg0__);
            SIZE_T rowSize =  output->GetOutputer().GetCurrentPosition() - rowStart;
            auto rowLimit = ScopeEngine::Configuration::GetGlobal().GetMaxOnDiskRowSize();
            if (rowSize > rowLimit)
            {
                throw RuntimeException(E_USER_ONDISKROW_TOO_BIG, {rowSize, rowLimit, "--- Printing row content is disabled. To enable, use '-ON ReportRowContentOnError'. ---"});
            }
        }
        static void Serialize(DummyOutputStream * output, const Process_1_Data0 & row)
        {
            SCOPE_ASSERT(false); 
        }
            static void SerializeKeyForSS(MemoryOutputStream* output, const Process_1_Data0 & row)
            {
                SCOPE_ASSERT(false); // there is no partition key in the schema
            }
    };

#pragma region Schema Constructors
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    INLINE Extract_0_Data0::Extract_0_Data0()
    {
    }

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    INLINE Process_1_Data0::Process_1_Data0()
    {
        m_partialagg0__ = 0;
    }
    INLINE Process_1_Data0::Process_1_Data0(const Process_1_Data0 & c, IncrementalAllocator * alloc) :
            m_Reseller(c.m_Reseller, alloc)
    {
        m_partialagg0__ = c.m_partialagg0__;
    }

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    INLINE HashAggregatorKey_Process_2::HashAggregatorKey_Process_2()
    {
    }
    INLINE HashAggregatorKey_Process_2::HashAggregatorKey_Process_2(const HashAggregatorKey_Process_2 & c, IncrementalAllocator * alloc) :
            m_Reseller(c.m_Reseller, alloc)
    {
    }

    template <typename Allocator>
    INLINE HashAggregatorKey_Process_2::HashAggregatorKey_Process_2(const HashAggregatorKey_Process_2 & c, FixedArrayTypeMemoryManager<Allocator> * memoryManager)
    {

        m_Reseller = c.m_Reseller;
        memoryManager->Copy(m_Reseller);
    }

    template <typename Allocator>
    INLINE void HashAggregatorKey_Process_2::Delete(FixedArrayTypeMemoryManager<Allocator> * memoryManager)
    {
        memoryManager->Delete(m_Reseller);
    }


// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    INLINE HashAggregatorState_Process_2::HashAggregatorState_Process_2()
    {
        m_UNCHECKED_SUM_partialagg0__ = 0;
    }
    INLINE HashAggregatorState_Process_2::HashAggregatorState_Process_2(const HashAggregatorState_Process_2 & c, IncrementalAllocator * alloc)
    {
        m_UNCHECKED_SUM_partialagg0__ = c.m_UNCHECKED_SUM_partialagg0__;
    }

    template <typename Allocator>
    INLINE HashAggregatorState_Process_2::HashAggregatorState_Process_2(const HashAggregatorState_Process_2 & c, FixedArrayTypeMemoryManager<Allocator> * memoryManager)
    {

        m_UNCHECKED_SUM_partialagg0__ = c.m_UNCHECKED_SUM_partialagg0__;
    }

    template <typename Allocator>
    INLINE void HashAggregatorState_Process_2::Delete(FixedArrayTypeMemoryManager<Allocator> * memoryManager)
    {
    }


// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    INLINE Process_5_Data0::Process_5_Data0()
    {
    }

#pragma endregion Schema Constructors
#pragma hdrstop
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
#endif
#if defined(COMPILE_NATIVE)
ScopeEngine::ScopeCEPCheckpointManager* g_scopeCEPCheckpointManager = NULL;
extern "C" __declspec(dllexport) void __stdcall InitVertexNative(VertexExecutionInfo * vertexExecutionInfo)
{
#if defined(FORCEMANAGEDDATETIMESER)
    ScopeEngine::ScopeDateTime::ForceManagedSerialization = true;
#endif
    ErrorManager::GetGlobal()->EnableJSON();

}
extern "C" __declspec(dllexport) void __stdcall SV_CopyThrough_execute(std::string * argv, int argc, InputFileInfo* inputs, int inputCnt, OutputFileInfo* outputs, int outputCnt, VertexExecutionInfo * vertexExecutionInfo)
{
    SCOPE_ASSERT(inputCnt == 1 && outputCnt == 1);
    IOManager::CopyStream(IOManager::GetGlobal()->GetDevice(inputs[0].inputFileName), IOManager::GetGlobal()->GetDevice(outputs[0].outputFileName));
}
#endif
#endif
#pragma region SV1_Extract
#if defined(COMPILE_SV1_EXTRACT) || defined(COMPILE_ALL_VERTICES)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    template<> 
    class KeyComparePolicy<Process_1_Data0,UID_Process_4>
    {
    public:
        struct KeyStruct
        {
            FString m_Reseller;

            KeyStruct(Process_1_Data0 & c) :
                m_Reseller(c.m_Reseller)
            {
            }

            KeyStruct(const Process_1_Data0 & c, IncrementalAllocator * alloc) :
                m_Reseller(const_cast<Process_1_Data0&>(c).m_Reseller, alloc)
            {
            }

            KeyStruct(KeyStruct & c) :
                m_Reseller(c.m_Reseller)
            {
            }

            KeyStruct(const KeyStruct & c, IncrementalAllocator * alloc) :
                m_Reseller(const_cast<KeyStruct&>(c).m_Reseller, alloc)
            {
            }

            KeyStruct() :
                m_Reseller()
            {
            }
#if defined(SCOPE_DEBUG)
            friend ostream & operator<<(ostream & os, KeyStruct & row)
            {
                os << "\tReseller:\t" << row.m_Reseller << endl;
              return os;
            }
#endif // defined(SCOPE_DEBUG)
        };

        typedef KeyStruct KeyType;

        static int Compare(Process_1_Data0 & row, KeyType & key)
        {
            int r = 0;
            if ((r = ScopeTypeCompare(row.m_Reseller, key.m_Reseller)) != 0)
                return r;
            return r;
        }

        static int Compare(Process_1_Data0 * n1, Process_1_Data0 * n2)
        {
            int r = 0;
            if ((r = ScopeTypeCompare((*n1).m_Reseller, (*n2).m_Reseller)) != 0)
                return r;
            return r;
        }

    };

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

#if defined(COMPILE_NATIVE)
    template<> 
    class AggregationPolicy<typename Process_1_Data0, typename Process_1_Data0, UID_Process_4> 
    {
    public:
        
        AggregationPolicy()
            :
            m_Reseller_Reseller_FIRST("FIRST_Reseller_Reseller"),
            m_partialagg0___partialagg0___UNCHECKED_SUM("UNCHECKED_SUM_partialagg0___partialagg0__")
        {
        }
        
        // begin key range (copy grouping key to output)
        void BeginKey(KeyComparePolicy<Process_1_Data0,UID_Process_4>::KeyType * input, Process_1_Data0 * output)
        {
            (*output).m_Reseller = (*input).m_Reseller;
        }

        // process input row, called for each row in key range
        void AddRow(Process_1_Data0 * input)
        {
            m_Reseller_Reseller_FIRST.Add((*input).m_Reseller);
            m_partialagg0___partialagg0___UNCHECKED_SUM.Add((*input).m_partialagg0__);
        }

        // write aggregated data, called after key is completely scanned
        void Aggregate(Process_1_Data0 * output)
        {
            m_Reseller_Reseller_FIRST.Aggregate(&(*output).m_Reseller);
            m_partialagg0___partialagg0___UNCHECKED_SUM.Aggregate(&(*output).m_partialagg0__);
        }

        // write aggregated data
        void GetValue(Process_1_Data0 * output)
        {
            m_Reseller_Reseller_FIRST.GetValue(&(*output).m_Reseller);
            m_partialagg0___partialagg0___UNCHECKED_SUM.GetValue(&(*output).m_partialagg0__);
        }

        // reset for new key
        void Reset()
        {
            m_Reseller_Reseller_FIRST.Reset();
            m_partialagg0___partialagg0___UNCHECKED_SUM.Reset();
        }

        // store statistics
		__declspec(noinline)
        void WriteRuntimeStats(TreeNode & root)
        {
            m_Reseller_Reseller_FIRST.WriteRuntimeStats(root);
            m_partialagg0___partialagg0___UNCHECKED_SUM.WriteRuntimeStats(root);
        }

        // get operator resource requirements
        OperatorRequirements GetOperatorRequirements()
        {
            OperatorRequirements result;
            result.Add(m_Reseller_Reseller_FIRST.GetOperatorRequirements());
            result.Add(m_partialagg0___partialagg0___UNCHECKED_SUM.GetOperatorRequirements());
            return result;
        }

    private:
        Aggregate_FIRST<FString> m_Reseller_Reseller_FIRST;
        Aggregate_UNCHECKED_SUM<__int64,__int64> m_partialagg0___partialagg0___UNCHECKED_SUM;
    };
#endif // defined(COMPILE_NATIVE)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.


    template<> 
    class KeyComparePolicy<Process_1_Data0,UID_Process_3>
    {
    public:
        struct KeyStruct
        {
            FString m_Reseller;

            KeyStruct(Process_1_Data0 & c) :
                m_Reseller(c.m_Reseller)
            {
            }

            KeyStruct(const Process_1_Data0 & c, IncrementalAllocator * alloc) :
                m_Reseller(const_cast<Process_1_Data0&>(c).m_Reseller, alloc)
            {
            }

            KeyStruct(KeyStruct & c) :
                m_Reseller(c.m_Reseller)
            {
            }

            KeyStruct(const KeyStruct & c, IncrementalAllocator * alloc) :
                m_Reseller(const_cast<KeyStruct&>(c).m_Reseller, alloc)
            {
            }

            KeyStruct() :
                m_Reseller()
            {
            }
#if defined(SCOPE_DEBUG)
            friend ostream & operator<<(ostream & os, KeyStruct & row)
            {
                os << "\tReseller:\t" << row.m_Reseller << endl;
              return os;
            }
#endif // defined(SCOPE_DEBUG)
        };

        typedef KeyStruct KeyType;

        static int Compare(Process_1_Data0 & row, KeyType & key)
        {
            int r = 0;
            if ((r = ScopeTypeCompare(row.m_Reseller, key.m_Reseller)) != 0)
                return r;
            return r;
        }

        static int Compare(Process_1_Data0 * n1, Process_1_Data0 * n2)
        {
            int r = 0;
            if ((r = ScopeTypeCompare((*n1).m_Reseller, (*n2).m_Reseller)) != 0)
                return r;
            return r;
        }

        // Key function for MKQsort algorithm
        static __int64 Key(Process_1_Data0 * p, int depth)
        {
            if (depth < 1 && (*p).m_Reseller.IsNull())
            {
                // Special case for "null" string
                return (__int64)(256);
            }
            else if (depth == (int) (*p).m_Reseller.size())
            {
                // Special case for end-of-string (field separator)
                return (__int64)(-1);
            }
            else if (depth < (int) (*p).m_Reseller.size())
            {
                // For string convert to unsigned char first. Otherwise, unicode will have negative value which will have different order than binary comparison.
                return (__int64)((unsigned char)((*p).m_Reseller.buffer()[depth]));
            }

            depth -= (int) ((*p).m_Reseller.size() + 1);


            return 0;
        }

        // End of Key function for MKQSort algorithm
        static bool EofKey(Process_1_Data0 * p, int depth)
        {
            depth -= (int) ((*p).m_Reseller.size() + 1);
            if (depth < 0)
                return false;
            return true;
        }
    };

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

#if defined(COMPILE_NATIVE)
    template<> 
    class TextExtractPolicy<Extract_0_Data0, UID_Extract_0>
    {
    public:
        static bool Deserialize(TextInputStream<TextInputStreamTraitsConst<',', '\0', '\0', false, true, UTF8, true, false, false, 0, CharFormat_uint16>, CosmosInput> * input, Extract_0_Data0 & row)
        {
            for(;;)
            {
                try
                {
                    // When we start a new row we always skip all empty lines first.
                    if (!input->StartRow())
                    {
                        return false;
                    }

                    input->Read(row.m_Requestdate);
                    input->Read(row.m_Enduser);
                    input->Read(row.m_CompanyName);
                    input->Read(row.m_Licensekey);
                    input->Read(row.m_Reseller);
                    input->Read(row.m_Product);
                    input->Read(row.m_Status);
                    input->Read(row.m_InvoiceDate);
                    input->Read(row.m_AmountDollars);
                    input->Read(row.m_AmountPounds);
                    input->Read(row.m_AmountEuros);
                    input->Read(row.m_ReportingAmount);
                    input->Read(row.m_POfilename);
                    input->Read(row.m_Beneficiary);
                    input->Read(row.m_Invoice);
                    input->Read(row.m_LicenseTerm);
                    input->Read(row.m_LicenseEnd);
                    input->Read(row.m_Column16);
                    input->Read(row.m_SalesRegion);

                    if (!input->EndRow())
                    {
                        // Too many columns in row - report error.
                        throw ScopeStreamExceptionWithEvidence(
                            E_EXTRACT_ROW_DELIMITER_EXPECTED,
                            { input->CurrentLineNumber(), input->CurrentField() },
                            EvidenceFormatter::FormatText(
                                input->GetBufferStart(),
                                input->GetReadPosition(),
                                input->GetBufferEnd(),
                                input->rowDelimiter,
                                input->delimiter));
                    }
                    return true;
                }
                catch (const TextEncodingException& /* e */)
                {
                    std::throw_with_nested(ExtractException(
                        E_EXTRACT_ENCODING_ERROR,
                        { input->CurrentLineNumber() },
                        false));
                }
                catch (const TextConversionException& e)
                {
                    std::throw_with_nested(ExtractException(
                        E_EXTRACT_ROW_ERROR,
                        { e.GetRowNumber(), e.GetColumnIndex(), GetColumnName(e.GetColumnIndex()) },
                        false));
                }
                catch (const RuntimeMemoryException& /* e */)
                {
                    std::throw_with_nested(ScopeStreamExceptionWithEvidence(
                        E_EXTRACT_ROW_TOO_LONG,
                        { input->CurrentLineNumber(), Configuration::GetGlobal().GetMaxInMemoryRowSize() },
                        EvidenceFormatter::FormatText(
                            input->GetBufferStart(),
                            input->GetReadPosition(),
                            input->GetBufferEnd(),
                            input->rowDelimiter,
                            input->delimiter)));
                }
                catch (const ScopeStreamException& e)
                {
                    switch(e.Error())
                    {
                    // Following error will terminate read
                    case ScopeStreamException::EndOfFile:
                    case ScopeStreamException::BadDevice:
                        return false;

                    // Bad rows throw exception
                    case ScopeStreamException::UnexpectedNewLine:
                        // Wrong number of columns in row - report error
                        // At this point, line number is increased to point at the next line. Subtract 1 to get line
                        // number of the offending row.
                        throw ScopeStreamExceptionWithEvidence(
                            E_EXTRACT_UNEXPECTED_ROW_DELIMITER,
                            { input->CurrentLineNumber() - 1, 19, input->CurrentField() },
                            EvidenceFormatter::FormatText(
                                input->GetBufferStart(),
                                input->GetReadPosition(),
                                input->GetBufferEnd(),
                                input->rowDelimiter,
                                input->delimiter));

                    // All exceptions should be handled above.
                    default:
                        SCOPE_ASSERT(false);
                    }
                }
            }
        }
        static const char* GetColumnName(std::size_t columnIndex)
        {
            static const std::array<const char*, 20> c_columnNames =
            {
                "Requestdate",
                "Enduser",
                "CompanyName",
                "Licensekey",
                "Reseller",
                "Product",
                "Status",
                "InvoiceDate",
                "AmountDollars",
                "AmountPounds",
                "AmountEuros",
                "ReportingAmount",
                "POfilename",
                "Beneficiary",
                "Invoice",
                "LicenseTerm",
                "LicenseEnd",
                "Column16",
                "SalesRegion",
                "*** END ***"
            };

            auto idx = std::min(columnIndex, c_columnNames.size() - 1);
            return c_columnNames[idx];
        }
    };

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

    static const char * StringTable_Process_1 [] =
    {
        "Reseller == \"Fraggle Works\" || Reseller == \"Purple Frog Systems\" || Reseller == \"Wibble Ltd\"",
        "Reseller",
        "1L",
        "\"*** After Last Expression ***\"",
    };
    template<> 
    class RowTransformPolicy<typename Extract_0_Data0, typename Process_1_Data0, UID_Process_1>
    {
    public:

        static bool FilterTransformRow(Extract_0_Data0 & input, Process_1_Data0 & output, IncrementalAllocator * alloc)
        {
            int exceptionIndex = 0;
            try
            {
                if (input.m_Reseller == staticconstant_0 || input.m_Reseller == staticconstant_1 || input.m_Reseller == staticconstant_2)
                {
                    exceptionIndex++;
                    output.m_Reseller = input.m_Reseller;
                    exceptionIndex++;
                    output.m_partialagg0__ = 1LL;
                    exceptionIndex++;
    
                    return true;
            }

            return false;
            }
            catch(ExceptionWithStack& e)
            {
                throw RuntimeExpressionException(StringTable_Process_1[exceptionIndex], "<not supplied>", e);
            }
            catch(...)
            {
                throw RuntimeExpressionException(StringTable_Process_1[exceptionIndex]);
            }
        }

        static FString staticconstant_0;
        static FString staticconstant_1;
        static FString staticconstant_2;

        #pragma warning(push)
        #pragma warning(disable: 4100) // 'alloc': unreferenced formal parameter
        static __declspec(noinline) void InitializeStatics(IncrementalAllocator * alloc)
        {
        #pragma warning(pop)
            staticconstant_0 = FString("Fraggle Works", 13);
            staticconstant_1 = FString("Purple Frog Systems", 19);
            staticconstant_2 = FString("Wibble Ltd", 10);
        }

        // get operator resource requirements
        static OperatorRequirements GetOperatorRequirements()
        {
            return OperatorRequirements().AddMemoryInRows(1, 1);
        }
    };

#if defined(COMPILE_NATIVE)
#pragma warning(push)
#pragma warning(disable:4592)
    FString RowTransformPolicy<Extract_0_Data0, Process_1_Data0, UID_Process_1>::staticconstant_0;
    FString RowTransformPolicy<Extract_0_Data0, Process_1_Data0, UID_Process_1>::staticconstant_1;
    FString RowTransformPolicy<Extract_0_Data0, Process_1_Data0, UID_Process_1>::staticconstant_2;
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
    class RowTransformPolicy<typename Process_1_Data0, typename Process_1_Data0, UID_Process_2>
    {
    public:

        static bool FilterTransformRow(Process_1_Data0 & input, Process_1_Data0 & output, IncrementalAllocator * alloc)
        {
        }


        #pragma warning(push)
        #pragma warning(disable: 4100) // 'alloc': unreferenced formal parameter
        static __declspec(noinline) void InitializeStatics(IncrementalAllocator * alloc)
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

#if defined(COMPILE_NATIVE)

    template<>
    struct HashAggregationPolicyV2<Process_1_Data0, Process_1_Data0, UID_Process_2>
    {
        struct Hash
        {
            const INT64 m_seed;

            Hash() : m_seed((INT64)0)
            {
            }

            Hash(INT64 seed) : m_seed(seed)
            {
            }

            INT64 operator () (const HashAggregatorKey_Process_2& schema) const
            {
                INT64 result = m_seed;
                result += ScopeHash(schema.m_Reseller);
                return result;
            }
        };
        struct EqualTo
        {
            bool operator () (const HashAggregatorKey_Process_2& left, const HashAggregatorKey_Process_2& right) const
            {
                if (!ScopeTypeCompare_EqualEqual(left.m_Reseller, right.m_Reseller)) return false;
                return true;
            }
        };
        struct RowHash
        {
            const INT64 m_seed;

            RowHash() : m_seed((INT64)0) {}
            RowHash(INT64 seed) : m_seed(seed) {}

            INT64 operator () (const Process_1_Data0& schema) const
            {
                INT64 result = m_seed;
                    result += ScopeHash(schema.m_Reseller);
                
                return result;
            }
        };

        struct RowEqualTo
        {
            bool operator () (const Process_1_Data0& left, const HashAggregatorKey_Process_2& right) const
            {
                if (!ScopeTypeCompare_EqualEqual(left.m_Reseller, right.m_Reseller)) return false;
                return true;
            }
        };
 
        typedef HashAggregatorKey_Process_2 KeySchema;
        typedef HashAggregatorState_Process_2 ValueSchema;

        static const RowHash& RowHashF()
        {
            static RowHash hash;
            return hash;
        }
        
        static const RowEqualTo& RowPredF()
        {
            static RowEqualTo pred;
            return pred;
        }

        static const size_t s_memoryQuota{ 3219128319ULL }; // Cosmos default is 2GB
        
        // the maximum number of buckets in the hashtable is defined as 
        // s_directorySize * 2^s_segmentSizeExponent => 67 108 864
        // s_directorySize has to be a power of two
        static const size_t s_directorySize{ 4096 };
        static const size_t s_segmentSizeExponent{ 14 }; // 16384 bucket per segment

         // initial number of buckets in the hashtable
         // s_initialSize has to be a power of two
        static const size_t s_initialSize { 128 * (1 << s_segmentSizeExponent) };

        static       double MaxLoadFactor() { return 2.; }
        static const bool   s_valueSchemaHasDeepData{ false };

        // Shallow copy input schema fields to key schema
        static void ShallowCopyRowToKey(const Process_1_Data0 & row, KeySchema & key)
        {
           key.m_Reseller = row.m_Reseller;
        }

        static void DeepCopyRowToKey(const Process_1_Data0 & row, KeySchema & key, IncrementalAllocator* alloc)
        {
           FString tmp_Reseller(row.m_Reseller, alloc);
           key.m_Reseller = tmp_Reseller;
        }

        // Init value schema fields with default aggregate states, shallow copy
        static void ShallowCopyRowToValue(const Process_1_Data0 & row, ValueSchema & value)
        {
           Aggregate_UNCHECKED_SUM<__int64, __int64>::Init(value.m_UNCHECKED_SUM_partialagg0__, row.m_partialagg0__);
        }

        // Init value schema fields with default aggregate states, deep copy
        static void DeepCopyRowToValue(const Process_1_Data0 & row, ValueSchema & value, IncrementalAllocator* alloc)
        {
           Aggregate_UNCHECKED_SUM<__int64, __int64>::Init(value.m_UNCHECKED_SUM_partialagg0__, row.m_partialagg0__);
        }

        // Init value schema fields with default aggregate states, deep copy
        static void UpdateValue(ValueSchema & state, const Process_1_Data0 & update, IncrementalAllocator* alloc)
        {
                Aggregate_UNCHECKED_SUM<__int64, __int64>::UpdateState(state.m_UNCHECKED_SUM_partialagg0__, update.m_partialagg0__);
        }


        // Shallow copy key and aggregated states to the output
        static void GetOutput(const KeySchema & key, const ValueSchema & value, Process_1_Data0 & row)
        {
            row.m_Reseller = key.m_Reseller;
            Aggregate_UNCHECKED_SUM<__int64, __int64>::GetAggregatedValue(value.m_UNCHECKED_SUM_partialagg0__, &row.m_partialagg0__);
        }


    };
#endif // defined(COMPILE_NATIVE)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.



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


#if defined(COMPILE_MANAGED)
#endif // defined(COMPILE_MANAGED)
// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.

    template<> 
    class RowTransformPolicy<typename Process_1_Data0, typename Process_1_Data0, UID_Process_4>
    {
    public:

        static bool FilterTransformRow(Process_1_Data0 & input, Process_1_Data0 & output, IncrementalAllocator * alloc)
        {
        }


        #pragma warning(push)
        #pragma warning(disable: 4100) // 'alloc': unreferenced formal parameter
        static __declspec(noinline) void InitializeStatics(IncrementalAllocator * alloc)
        {
        #pragma warning(pop)
        }

        // get operator resource requirements
        static OperatorRequirements GetOperatorRequirements()
        {
            return OperatorRequirements().AddMemoryInRows(1, 1);
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

    static const char * StringTable_Process_5 [] =
    {
        "Reseller",
        "(long?)partialagg0__",
        "\"*** After Last Expression ***\"",
    };
    template<> 
    class RowTransformPolicy<typename Process_1_Data0, typename Process_5_Data0, UID_Process_5>
    {
    public:

        static bool FilterTransformRow(Process_1_Data0 & input, Process_5_Data0 & output, IncrementalAllocator * alloc)
        {
            int exceptionIndex = 0;
            try
            {
                output.m_Reseller = input.m_Reseller;
                exceptionIndex++;
                output.m_RecordCount = scope_cast<NativeNullable<__int64>>(input.m_partialagg0__);
                exceptionIndex++;

                return true;
            }
            catch(ExceptionWithStack& e)
            {
                throw RuntimeExpressionException(StringTable_Process_5[exceptionIndex], "<not supplied>", e);
            }
            catch(...)
            {
                throw RuntimeExpressionException(StringTable_Process_5[exceptionIndex]);
            }
        }


        #pragma warning(push)
        #pragma warning(disable: 4100) // 'alloc': unreferenced formal parameter
        static __declspec(noinline) void InitializeStatics(IncrementalAllocator * alloc)
        {
        #pragma warning(pop)
        }

        // get operator resource requirements
        static OperatorRequirements GetOperatorRequirements()
        {
            return OperatorRequirements().AddMemoryInRows(1, 1);
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

    template<> 
    class TextOutputPolicy<Process_5_Data0, UID_SV1_Extract_out0>
    {
    public:

        static void Serialize(TextOutputStream<TextOutputStreamTraitsConst<',', '\0', false, false, true, false, true, UTF8, true, CharFormat_uint16>, CosmosOutput> * output, Process_5_Data0 & row)
        {
            if (!row.m_Reseller.IsNull())
            {
                output->Write<FString,true>(row.m_Reseller);
            }
            output->WriteDelimiter();
            if (!row.m_RecordCount.IsNull())
            {
                output->Write<__int64,false>(row.m_RecordCount);
            }
            output->WriteNewLine();
        }

        static void SerializeHeader(TextOutputStream<TextOutputStreamTraitsConst<',', '\0', false, false, true, false, true, UTF8, true, CharFormat_uint16>, CosmosOutput> * output)
        {
            output->Write<string,true>(FString("Reseller", 8));
            output->WriteDelimiter();
            output->Write<string,true>(FString("RecordCount", 11));
            output->WriteNewLine();
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
        // check CPUID to make sure this machjine supports SSE4_2 instructions
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

        Configuration::Create(ET_Azure, false);

        SIZE_T x_inputBufSize, x_outputBufSize, x_inputVirtualMemoryLimit;
        int    x_inputBufCnt, x_outputBufCnt;
        
        MemoryManager::CalculateIOBufferSize(inputCnt, outputCnt, MemoryManager::x_vertexMemoryLimit, MemoryManager::x_vertexReserveMemory, x_inputBufSize, x_inputBufCnt, x_outputBufSize, x_outputBufCnt, x_inputVirtualMemoryLimit, false);

        const bool IsNativeOnlyVertex = true;
        // If we have more than one input, we will random shuffle it
        if (inputCnt - 0 > 1)
        {
            ScopeRandom scopeRandom((int)vertexExecutionInfo->m_vertexId);
            auto lambda = [&scopeRandom](int max)->int { return (scopeRandom.Next() % max + max) % max;}; // scopeRandom.Next() % max could be negative value
            random_shuffle(&inputs[0], inputs + inputCnt - 0, lambda ); 
        }
        // Define extractor type and construct objects
        // 
        typedef Extractor<Extract_0_Data0, TextExtractPolicy<Extract_0_Data0, UID_Extract_0>, TextInputStream<TextInputStreamTraitsConst<',', '\0', '\0', false, true, UTF8, true, false, false, 0, CharFormat_uint16>, CosmosInput>> ExtractorType1_SV1_Extract;
        unique_ptr<unique_ptr<ExtractorType1_SV1_Extract>[]> extractor_0_array(new unique_ptr<ExtractorType1_SV1_Extract>[inputCnt - 0]);
        
        for (int i = 0; i < inputCnt; i++)
        {
            // 
            extractor_0_array[i - 0].reset(new ExtractorType1_SV1_Extract(inputs[i], false, x_inputBufSize, x_inputBufCnt, x_inputVirtualMemoryLimit, InputStreamParameters(',', '\0', '\0', static_cast<const char*>(__nullptr), false, true, UTF8, true, false, 0, CharFormat_uint16), UID_Extract_0));
        }
        ExtractorType1_SV1_Extract ** extractor_0 = (ExtractorType1_SV1_Extract **)extractor_0_array.get();
        ULONG extractor_0_count = (ULONG) inputCnt - 0;
        // Define the type of the operator
        typedef FilterTransformer<ExtractorType1_SV1_Extract, Extract_0_Data0, Process_1_Data0, UID_Process_1> FilterTransformerType_Process_1;
        // Allocate memory for the operator array
        unique_ptr<unique_ptr<FilterTransformerType_Process_1>[]> filterTransformer_Process_1_array(new unique_ptr<FilterTransformerType_Process_1>[extractor_0_count]);
        
        // Construct operator objects
        for(ULONG i = 0; i < extractor_0_count; i++)
        {
            filterTransformer_Process_1_array[i].reset(new FilterTransformerType_Process_1(extractor_0[i], UID_Process_1)); 
        }
        
        FilterTransformerType_Process_1 ** filterTransformer_Process_1 = (FilterTransformerType_Process_1 **)filterTransformer_Process_1_array.get();
        ULONG filterTransformer_Process_1_count = extractor_0_count;
        // Merge streams N->1
        typedef ParallelUnionAll<FilterTransformerType_Process_1, Process_1_Data0, IsNativeOnlyVertex> UnionAllType_Process_1_Process_2_connector;
        unique_ptr<UnionAllType_Process_1_Process_2_connector> unionall_Process_1_Process_2_connector_ptr(new UnionAllType_Process_1_Process_2_connector(filterTransformer_Process_1,filterTransformer_Process_1_count,false,UID_ParallelUnionAll_Process_1));
        UnionAllType_Process_1_Process_2_connector * unionall_Process_1_Process_2_connector = unionall_Process_1_Process_2_connector_ptr.get();
        ULONG unionall_Process_1_Process_2_connector_count = 1;
        // Define hash aggregator type
        typedef LocalHashAggregatorV2<UnionAllType_Process_1_Process_2_connector, Process_1_Data0, Process_1_Data0, UID_Process_2> LocalHashAggregatorType_Process_2;
        // Construct operator and initialize it.
        unique_ptr<LocalHashAggregatorType_Process_2> localHashAggregator_Process_2_ptr (new LocalHashAggregatorType_Process_2(unionall_Process_1_Process_2_connector, UID_Process_2));
        LocalHashAggregatorType_Process_2 * localHashAggregator_Process_2 = localHashAggregator_Process_2_ptr.get();
        ULONG localHashAggregator_Process_2_count = 1;
        // Construct operator and initialize it.
        unique_ptr<OperatorDelegate<Process_1_Data0>> delegate_localHashAggregator_Process_2_ptr (new OperatorDelegate<Process_1_Data0>(OperatorDelegate<Process_1_Data0>::FromOperator(localHashAggregator_Process_2)));
        OperatorDelegate<Process_1_Data0> * delegate_localHashAggregator_Process_2 = delegate_localHashAggregator_Process_2_ptr.get();
        ULONG delegate_localHashAggregator_Process_2_count = 1;
        // Define sorter type
        typedef Sorter<Process_1_Data0> SorterType_Process_3;
        // Construct operator and initialize it.
        unique_ptr<SorterType_Process_3> sorter_Process_3_ptr (new SorterType_Process_3(delegate_localHashAggregator_Process_2, &MKQSort<Process_1_Data0>::Sort<KeyComparePolicy<Process_1_Data0, UID_Process_3>, (sizeof(Process_1_Data0)<=CACHELINE_SIZE)>, ScopeLoserTreeDelegate<Process_1_Data0>::CreateDelegate<UID_Process_3>(), false, 2250244095 /*memoryQuota*/, UID_Process_3));
        SorterType_Process_3 * sorter_Process_3 = sorter_Process_3_ptr.get();
        ULONG sorter_Process_3_count = 1;
        // Define stream aggregator type
        typedef StreamAggregator<SorterType_Process_3, Process_1_Data0, Process_1_Data0, UID_Process_4> StreamAggregatorType_Process_4;
        // Construct operator and initialize it.
        unique_ptr<StreamAggregatorType_Process_4> streamAggregator_Process_4_ptr (new StreamAggregatorType_Process_4(sorter_Process_3, false, UID_Process_4));
        StreamAggregatorType_Process_4 * streamAggregator_Process_4 = streamAggregator_Process_4_ptr.get();
        ULONG streamAggregator_Process_4_count = 1;
        // Define the type of the operator
        typedef FilterTransformer<StreamAggregatorType_Process_4, Process_1_Data0, Process_5_Data0, UID_Process_5> FilterTransformerType_Process_5;
        // Construct operator and initialize it.
        unique_ptr<FilterTransformerType_Process_5> filterTransformer_Process_5_ptr (new FilterTransformerType_Process_5(streamAggregator_Process_4, UID_Process_5));
        FilterTransformerType_Process_5 * filterTransformer_Process_5 = filterTransformer_Process_5_ptr.get();
        ULONG filterTransformer_Process_5_count = 1;
        // Define outputer type
        typedef Outputer<FilterTransformerType_Process_5, Process_5_Data0, TextOutputPolicy<Process_5_Data0, UID_SV1_Extract_out0>, TextOutputStream<TextOutputStreamTraitsConst<',', '\0', false, false, true, false, true, UTF8, true, CharFormat_uint16>, CosmosOutput>, false> OutputerType2_SV1_Extract;
        // Construct operator and initialize it
        unique_ptr<OutputerType2_SV1_Extract> outputer_SV1_Extract_out0_ptr(new OutputerType2_SV1_Extract(filterTransformer_Process_5, outputs[0].outputFileName, outputs[0].isFirstOutputPiece, x_outputBufSize, x_outputBufCnt, OutputStreamParameters(',', "\r\n", '\0', static_cast<const char*>(__nullptr), false, false, true, false, "O", UTF8, true, CharFormat_uint16), UID_SV1_Extract_out0));
        OutputerType2_SV1_Extract * outputer_SV1_Extract_out0 = outputer_SV1_Extract_out0_ptr.get();
        try
        {
            // Init operator chain
            outputer_SV1_Extract_out0->Init();

            // Execute the whole vertex by calling the GetNextRow on top operator
            Process_5_Data0 row;
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

// All of the templates will throw a CS1591 warning because we 
// have /doc turned on in the CSharp compiler.
// The only way to solve this is to move all of the templates to their own
// project, and then turn off /doc.



#endif
#pragma endregion SV1_Extract
// Empty footer
