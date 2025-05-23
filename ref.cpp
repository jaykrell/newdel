// This file references operator new.

extern "C"
{
void* ref()
{
	return new int;
}
}
