#include <iostream>
#include <conio.h>
#include <stdio.h>

using namespace std;

class M {
protected:
	int m;
public:
	void getM(int x) {
		m = x;
	}
};

class N {
protected:
	int n;
public:
	void getN(int y) {
		n = y;
	}
};

class P : public M, public N {
public: 
	void display(void) {
		cout << "m = " << m << endl;
		cout << "n = " << n << endl;
		cout << "m * n = " << m * n << endl;
	}
};

int main()
{
	P ob;
	ob.getM(10);
	ob.getN(20);
	ob.display();
	return 0;
}
