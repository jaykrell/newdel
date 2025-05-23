// This file references operator new.

#include <new>
#if __cpp_aligned_new
using std::align_val_t;
#else
enum align_val_t : size_t { };
#endif
extern const struct NewLinkage g_NewLinkage;
__declspec(selectany) extern const struct NewLinkage2 {
    NewLinkage const * linkage = &g_NewLinkage;
    void* (*a)(size_t) = operator new;
    void* (*b)(size_t) = operator new[];
    void* (*c)(size_t, const std::nothrow_t&) noexcept = operator new;
    void* (*d)(size_t, const std::nothrow_t&) noexcept = operator new[];
    void (*e)(void*) noexcept = operator delete;
    void (*f)(void*) noexcept = operator delete[];
    void (*g)(void*, size_t) noexcept = operator delete;
    void (*h)(void*, size_t) noexcept = operator delete[];
    void (*i)(void*, const std::nothrow_t&) noexcept = operator delete;
    void (*j)(void*, const std::nothrow_t&) noexcept = operator delete[];
    void* (*k)(size_t, align_val_t) = operator new;
    void* (*l)(size_t, align_val_t) = operator new[];
    void* (*m)(size_t, align_val_t, const std::nothrow_t&) noexcept = operator new;
    void* (*n)(size_t, align_val_t, const std::nothrow_t&) noexcept = operator new[];
    void (*o)(void*, align_val_t) noexcept = operator delete;
    void (*p)(void*, align_val_t) noexcept = operator delete[];
    void (*q)(void*, size_t, align_val_t) noexcept = operator delete;
    void (*r)(void*, size_t, align_val_t) noexcept = operator delete[];
    void (*s)(void*, align_val_t, const std::nothrow_t&) noexcept = operator delete;
    void (*t)(void*, align_val_t, const std::nothrow_t&) noexcept = operator delete[];
} g_NewLinkage2{};

extern "C"
{
void* ref()
{
	g_NewLinkage2.a(1);
	return new int;
}
}
