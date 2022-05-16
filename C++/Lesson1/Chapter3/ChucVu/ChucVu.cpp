#include<iostream>
#include<iomanip>
using namespace std;
class Person
{
private:
	char name[30];
	string occupation;
protected:
	char maso;
	float salary;
public:
	void enterProfile()
	{
		cout << "Nhap ma so:  Bien che (b), Hop dong (h): ";
		cin >> maso;
		while (maso != 'b' && maso != 'h') {
			cout << "Nhap lai: b or h" << endl;
			cin >> maso;
		}
		cout << "Nhap ho ten: " << endl;
		cin.ignore();
		cin.get(name, 30);

		if (maso == 'b') {
			occupation = "Bien che";
		}
		else {
			occupation = "Hop Dong";
		}
	}
	void printProfile()
	{
		cout << setw(10) << occupation << setw(20) << name<< setprecision(0) << fixed << setw(30) << salary << " VND" << endl;
	}
};
class Permanent : virtual public Person
{
private:
	float heSoLuong, phuCap;
public:
	void nhapBienChe()
	{
		cout  << "Nhap he do luong: " << endl; 
		cin >> heSoLuong;
		cout  << "Nhap phu cap: " << endl; 
		cin >> phuCap;
		salary = heSoLuong * 7000000 + phuCap;
	}
};
class Contract : virtual public Person
{
private:
	float moneyPerDay, overtime;
	int workDays;
public:
	void nhapHopDong()
	{
		cout << endl << "Nhap ngay cong lao dong: "; cin >> workDays
			;
		cout << endl << "Nhap tien cong lao dong/ngay: "; cin >> moneyPerDay;
		cout << endl << "He so vuot gio: "; cin >> overtime;
		salary = workDays > 24 ? (24 + (workDays - 24) * overtime) * moneyPerDay : workDays * moneyPerDay;
	}
};
class JobTitle : public Permanent, public Contract
{
public:
	void inputVienChuc()
	{
		enterProfile();
		if (maso == 'b') {
			nhapBienChe();
		}
		else {
			nhapHopDong();
		}
	}
};
int main()
{
	JobTitle* vienChucs;
	int n;
	cout << "Nhap so vien chuc: ";
	cin >> n;
	vienChucs = new JobTitle[n];
	for (int i = 0; i < n; i++)
	{
		vienChucs[i].inputVienChuc();
	}
	cout << endl << setw(10) << "Job" << setw(20) << "Name" << setw(30) << "Salary" << " VND";
	for (int i = 0; i < n; i++)
		vienChucs[i].printProfile();
	return 0;
}