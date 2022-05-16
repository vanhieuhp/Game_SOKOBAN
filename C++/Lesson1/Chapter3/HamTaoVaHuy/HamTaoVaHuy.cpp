#include <iostream>
#include <conio.h>

using namespace std;
class CS
{
public:
	CS()
	{
		cout << "\nHam tao lop co so";
	}
	~CS()
	{
		cout << "\nHam huy lop co so";
	}
};
class DX :public CS
{
public:
	DX()
	{
		cout << "\nHam tao lop dan xuat";
	}
	~DX()
	{
		cout << "\nHam huy lop dan xuat";
	}
};
int main()
{
	DX* ob = new DX;
	_getch();
	delete ob;
	_getch();
}


