// Replace operator new.
//
// There are 20 total non-member operator new/delete overloads documented on cppreference.

#pragma warning(disable:4100) // unused parameter
#include <stdlib.h>
#include <new>
#if __cpp_aligned_new
using std::align_val_t;
#else
enum align_val_t : size_t { };
#endif
using std::bad_alloc;
using std::nothrow;
using std::nothrow_t;
using std::size_t;
#include <stdio.h>

#ifndef NEW_NAME
#define STRING(x) x
#define NEW_NAME __FILE__
#else
#define STRINGx(x) #x
#define STRING(x) STRINGx(x)
#endif

void* operator new(size_t size) {
	printf("%s %d\n", STRING(NEW_NAME), __LINE__);
	return malloc(size);
}

void* operator new[](size_t size) {
	printf("%s %d\n", STRING(NEW_NAME), __LINE__);
	return malloc(size);
}

void* operator new(size_t size, align_val_t align) {
	printf("%s %d\n", STRING(NEW_NAME), __LINE__);
	return malloc(size);
}

void* operator new[](size_t size, align_val_t align) {
	printf("%s %d\n", STRING(NEW_NAME), __LINE__);
	return malloc(size);
}

void* operator new(size_t size, const nothrow_t&) noexcept {
	printf("%s %d\n", STRING(NEW_NAME), __LINE__);
	return malloc(size);
}

void* operator new[](size_t size, const nothrow_t&) noexcept {
	printf("%s %d\n", STRING(NEW_NAME), __LINE__);
	return malloc(size);
}

void* operator new(size_t size, align_val_t align, const nothrow_t&) noexcept {
	printf("%s %d\n", STRING(NEW_NAME), __LINE__);
	return malloc(size);
}

void* operator new[](size_t size, align_val_t align, const nothrow_t&) noexcept {
	printf("%s %d\n", STRING(NEW_NAME), __LINE__);
	return malloc(size);
}

void operator delete(void* p) noexcept {
    free(p);
}

/**
 * @brief Deallocate memory.
 * @param p memory to deallocate.
 */
void operator delete[](void* p) noexcept {
    free(p);
}

void operator delete(void* p, align_val_t align) noexcept {
    free(p);
}

void operator delete[](void* p, align_val_t align) noexcept {
    free(p);
}

void operator delete(void* p, size_t size) noexcept {
    free(p);
}

void operator delete[](void* p, size_t size) noexcept {
    free(p);
}

void operator delete(void* p, size_t size, align_val_t align) noexcept {
    free(p);
}

void operator delete[](void* p, size_t size, align_val_t align) noexcept {
    free(p);
}

void operator delete(void* p, const nothrow_t&) noexcept {
    free(p);
}

void operator delete[](void* p, const nothrow_t&) noexcept {
    free(p);
}

void operator delete(void* p, align_val_t align, const nothrow_t&) noexcept {
    free(p);
}

void operator delete[](void* p, align_val_t align, const nothrow_t&) noexcept {
    free(p);
}

#if NEW_LINKAGE
extern const struct NewLinkage {
    void* (*a)(size_t) = operator new;
    void* (*b)(size_t) = operator new[];
    void* (*c)(size_t, const nothrow_t&) noexcept = operator new;
    void* (*d)(size_t, const nothrow_t&) noexcept = operator new[];
    void (*e)(void*) noexcept = operator delete;
    void (*f)(void*) noexcept = operator delete[];
    void (*g)(void*, size_t) noexcept = operator delete;
    void (*h)(void*, size_t) noexcept = operator delete[];
    void (*i)(void*, const nothrow_t&) noexcept = operator delete;
    void (*j)(void*, const nothrow_t&) noexcept = operator delete[];
    void* (*k)(size_t, align_val_t) = operator new;
    void* (*l)(size_t, align_val_t) = operator new[];
    void* (*m)(size_t, align_val_t, const nothrow_t&) noexcept = operator new;
    void* (*n)(size_t, align_val_t, const nothrow_t&) noexcept = operator new[];
    void (*o)(void*, align_val_t) noexcept = operator delete;
    void (*p)(void*, align_val_t) noexcept = operator delete[];
    void (*q)(void*, size_t, align_val_t) noexcept = operator delete;
    void (*r)(void*, size_t, align_val_t) noexcept = operator delete[];
    void (*s)(void*, align_val_t, const nothrow_t&) noexcept = operator delete;
    void (*t)(void*, align_val_t, const nothrow_t&) noexcept = operator delete[];
} g_NewLinkage{};
#endif
