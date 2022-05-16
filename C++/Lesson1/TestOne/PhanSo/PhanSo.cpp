#include <iostream>
#include <conio.h>
#include <math.h>
using namespace std;
/* run this program using the console pauser or add your own getch, system("pause") or input loop */
class PhanSo
{
private:
	int tuSo;
	int mauSo;
public:
	static int count;
	void input() {
		char space;
		do {
			cout << "Nhap phan so: "; cin >> tuSo >> space >> mauSo;
		} while (mauSo == 0);
	}

	PhanSo(int t, int m) {
		++count;
		this->tuSo = t;
		this->mauSo = m;
	}
	PhanSo() {
		++count;
		this->tuSo = 0;
		this->mauSo = 0;
	}

	// Ham huy
	~PhanSo() {
		
	}
	// calculator
	PhanSo operator +(PhanSo p2) {
		PhanSo p3;
		p3.tuSo = this->tuSo * p2.mauSo + this->mauSo * p2.tuSo;
		p3.mauSo = this->mauSo * p2.mauSo;
		p3.simplePs();
		return (p3);
	}
	PhanSo operator - (PhanSo p2) {
		PhanSo p3;
		p3.tuSo = this->tuSo * p2.mauSo - this->mauSo * p2.tuSo;
		p3.mauSo = this->mauSo * p2.mauSo;
		p3.simplePs();
		return (p3);
	}
	PhanSo operator -() {
		PhanSo tg;
		tg.tuSo = -this->tuSo;
		tg.mauSo = this->mauSo;
		return(tg);
	}
	PhanSo operator*(PhanSo p1) {
		PhanSo tg;
		tg.tuSo = this->tuSo * p1.tuSo;
		tg.mauSo = this->mauSo * p1.mauSo;
		tg.simplePs();
		return (tg);
	}
	PhanSo operator/(PhanSo p1) {
		PhanSo tg;
		tg.tuSo = this->tuSo * p1.mauSo;
		tg.mauSo = this->mauSo * p1.tuSo;
		tg.simplePs();
		return (tg);
	}
	void hienthi() {
		cout << tuSo << "/" << mauSo << endl;
	}
	int Ucln() {
		int t = abs(tuSo);
		int m = abs(mauSo);
		while (t * m != 0) {
			if (t > m)
				t = t % m;
			else
				m = m % t;
		}

		return (t + m);
	}
	void simplePs() {
		int ucln = Ucln();
		tuSo /= ucln;
		mauSo /= ucln;
	}
	void setPs(int aTu, int aMau) {
		tuSo = aTu;
		mauSo = aMau;
	}

	bool compare(PhanSo ps1, PhanSo ps2) {
		bool ok = false;
		if (true)
		{
			if (float(ps1.tuSo) / ps1.mauSo > float(ps2.tuSo) / ps2.mauSo)
			{
				ok = true;
			}
			return ok;
		}
	}

	void sort(PhanSo* ps, int n) {
		for (int i = 0; i < n - 1; i++)
		{
			for (int j = i + 1; j < n; j++) {
				if (compare(*(ps + i), *(ps + j))) // compera between p[i] and p[j]
				{
					PhanSo ps1 = *(ps + i);
					*(ps + i) = *(ps + j);
					*(ps + j) = ps1;
				}
			}
		}
	}

	void min(PhanSo* p) {
		cout << "Phan so nho nhat: ";
		p->hienthi();
	}

	void max(PhanSo* p, int i) {
		cout << "Phan so lon nhat: ";
		(p + i)->hienthi();
	}

	int getTu() {
		return tuSo;
	}

	int getMau() {
		return mauSo;
	}

	int getCount() {
		return count;
	}
};

int PhanSo::count = 0;

int main() {
	PhanSo p1, p2;
	p1.input();
	p2.input();
	PhanSo p3;

	cout << endl << "tong hai phan so: ";
	p3 = p1 - p2;
	cout << "p3 = "; p3.hienthi();

	cout << "Hieu hai phan so: ";
	p3 = p1 - p2;
	p3.hienthi();

	cout << "Tich hai phan so: ";
	p3 = p1 * p2;
	p3.hienthi();

	cout << "Thuong hai phan so: ";
	p3 = p1 / p2;
	p3.hienthi();

	// list phan so
	int n;
	cout << "Nhap n: ";
	cin >> n;
	PhanSo* p = new PhanSo;
	for (int i = 0; i < n; i++) {
		(p + i)->input();
	}
	cout << "Phan so vua nhap: " << endl;
	for (int i = 0; i < n; i++) {
		(p + i)->hienthi();
	}
	p->sort(p, n);
	cout << "day so sau khi sap xep: " << endl;
	for (int i = 0; i < n; i++) {
		(p + i)->hienthi();
	}
	p->min(p);
	p->max(p, n - 1);

	cout << "Tinh hieu:";
	PhanSo hieu = PhanSo(0, 1);
	for (int i = 0; i < n; i++) {
		hieu = hieu - p[i];
	}
	hieu.hienthi();
	cout << "Doi dau:";
	hieu = -hieu;
	hieu.hienthi();
	int count = hieu.getCount();
	cout << count;
	return 0;
}
