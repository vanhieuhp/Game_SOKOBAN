#include <iostream>
#include <conio.h>
#include <cstdlib>
#include <cstdio>
#include <stdio.h>
using namespace std;


class SinhVien {
	char hoTen[25];
protected:
	int sbd;
public:
	void nhap() {
		cout << endl << "Ho ten: "; //gets(hoTen);
		cin >> hoTen;
		cout << endl << "So bao danh: "; cin >> sbd;
		cin.ignore(1);
	}

	void hienThi() {
		cout << endl << "So bao danh:" << sbd;
		cout << endl << "Ho va ten sinh vien: " << hoTen;
	}
};

class DiemThi : public SinhVien {
protected:
	float d1, d2;
public:
	void nhapDiem() {
		cout << "Nhap diem hai mon thi: \n";
		cin >> d1 >> d2;
	}
	void hienThiDiem() {
		cout << endl << "Diem mon 1: " << d1;
		cout << endl << "Diem mon 2: " << d2;
	};
};



class KetQua : public DiemThi {
protected:
public:
	float tong;

	void display() {
		tong = d1 + d2;
		hienThiDiem();
		cout << endl << "Tong so diem: " << tong;
	}
	float getTong() {
		return tong;
	}
};

class UuTien: public KetQua{
protected:
	int diemThuong = 1;
public: 
	UuTien() {

	}
	void setDiemThuong(float tong) {
		if (tong <= 10)
			diemThuong = 0;
		else if (tong <= 15)
			diemThuong = 1;
		else
			diemThuong = 2;
	}
	int getDiemThuong() {
		return diemThuong;
	}
};
int main()
{
	int i, n;
	UuTien sv[100];
	cout << "\n Nhap so sinh vien: ";
	cin >> n;
	cin.ignore(1);
	for (int i = 0; i < n; i++)
	{
		sv[i].nhap();
		sv[i].nhapDiem();
	}
	float diemTong = sv[0].getTong();
	cout << endl << diemTong;
	for (int i = 0; i < n; i++)
	{

		
		sv[i].setDiemThuong(diemTong);
		sv[i].display();
		cout << endl << "Diem thuong la: " << sv[i].getDiemThuong();
		cout << endl << "Diem tong la: " << sv[i].getTong();
	}
}
