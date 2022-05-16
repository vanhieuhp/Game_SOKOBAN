#include <iostream>
#include <cstdio>
#include <conio.h>
using namespace std;

class Diem {
private:
	double x, y;
public:
	void nhap() {
		cout << "\n x = "; cin >> x;
		cout << "\n y = "; cin >> y;
	}
	void hienthi() {
		cout << "\n x = " << x << ", y = " << y;
	}
};

class Hinhtron :public Diem
{
private: double r;
public:
	void nhapR() {
		cout << "\n r =  "; cin >> r;
	}
	double getR() {
		return r;
	}
};
int main()
{
	Hinhtron h;
	cout << "\nNhap tao do tam va ban kinh hinh tron";
	h.nhap();
	h.nhapR();
	cout << "\n Hinh tron co tam: "; h.hienthi();
	cout << "\n Co ban kinh = "<< h.getR();
	return 0;
}