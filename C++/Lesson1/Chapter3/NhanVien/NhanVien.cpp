#include<iostream>
#include<iomanip>
using namespace std;
class Nguoi
{
	char hoten[30];
protected:
	char maso[5];
	float luong;
public:
	void nhaphoso()
	{
		cout << endl << "Nhap ma so: (b: Bien che, h: Hop dong, max>5): ";
		cin.ignore();
		cin.get(maso, 5);
		cout << endl << "Nhap ho ten: ";
		cin.ignore();
		cin.get(hoten, 30);
	}
	void in()
	{
		cout << endl << maso << " " << hoten << " ";
		cout << setprecision(2) << fixed << luong;
	}
};
class Bienche : virtual public Nguoi
{
	float hsl, tpc;
public:
	void nhapbienche()
	{
		cout << endl << "Nhap he do luong: "; cin >> hsl;
		cout << endl << "Nhap phu cap: "; cin >> tpc;
		luong = hsl * 1390000 + tpc;
	}
};
class Hopdong : virtual public Nguoi
{
	float tcld, hsvg;
	int songay;
public:
	void nhaphopdong()
	{
		cout << endl << "Nhap ngay cong lao dong: "; cin >> songay;
		cout << endl << "Nhap tien cong lao dong/ngay: "; cin >> tcld;
		cout << endl << "He so vuot gio: "; cin >> hsvg;
		luong = songay > 24 ? (24 + (songay - 24) * hsvg) * tcld : songay * tcld;
	}
};
class Vienchuc : public Bienche, public Hopdong
{
public:
	void nhap()
	{
		nhaphoso();
		if (maso[0] == 'b') nhapbienche();
		else nhaphopdong();
	}
};
main()
{
	Vienchuc* dsvc;
	int n;
	cout << endl << "Nhap so ho so vien chuc: ";
	cin >> n;
	dsvc = new Vienchuc[n];
	for (int i = 0; i < n; i++)
	{
		dsvc[i].nhap();
	}
	for (int i = 0; i < n; i++)
		dsvc[i].in();
}