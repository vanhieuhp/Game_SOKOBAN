#include <iostream>	
#include <cstdio>
#include <conio.h>
using namespace std;
class A {
	int a;
protected:
	int b;
public: 
	A() {
		
	}
	void setAb();
	int getA(void);
	void showA(void);
	void setB() {
		b = 20;
	}
};

class B : public A
{
	int c;
public: 
	void mul(void);
	void display(void);
};

void A::setAb(void) {
	a = 5;
	b = 10;
}

int A::getA() {
	return a;
}

void A::showA() {
	cout << "a = " << a << "\n";
}

void B::mul() {
	c = b * getA();
}

void B::display() {
	cout << "a = " << getA() << "\n";
	cout << "b = " << b << "\n";
	cout << "c = " << c << "\n";
}


int main() {
	B d;
	d.setAb();
	d.mul();
	d.showA();
	d.display();
	d.setB();
	d.mul();
	d.display();
	return 0;
}