#include<iostream>
#include<iomanip>
#define SIZE 16
using namespace std;
class Stack {
private:
	int elem[SIZE];
protected:
	int top; // allow you to know a number of elements in the stack
public:
	Stack() {
		top = -1;
	}

	bool isEmpty() {
		return (top == -1 ? true : false);
	}
	bool isFull() {
		return (top == SIZE - 1 ? true : false);
	}
	void push(int a) {
		if (!isFull())
		{
			top++;
			elem[top] = a;
		}
		else {
			cout << endl << "Stack overflow!";
		}
	}
	int pop() {
		int a;
		if (!isEmpty())
		{
			a = elem[top];
			top--;
		}
		return a;
	}
	void inStack() {
		while (!isEmpty()) {
			cout << setw(5) << pop();
		}
	}
};

// Encapsulation, Inherit, da hinh 
class Transfer: public Stack{ //extends // inherit
private:
	int n;
	int d;
	//Stack st;
public:
	void setDemand() {
		cout << endl << "Ban muon doi co so may? "; cin >> d;
	}
	void nhap() {
		cout << endl << "Nhap so nguyen: "; cin >> n;	
	}
	void transfer() {
		int k = n;
		while (k != 0) {
			push(k % d);
			k = k / d;
		}
	}
	void inStack() {
		int check = top;
		while (!check)
		{
			int bf = pop();
			if (bf < 10)
			{
				cout << setw(3) << bf;
			}
			else
				cout << setw(3) << char(bf + 55);
			check--;
		}
	}
	int getTop() {
		return top;
	}
};

int main() {
	
	Transfer transfer;
	transfer.setDemand();
	transfer.nhap();
	transfer.transfer();
	cout << "Dinh cua stack: " << transfer.getTop() << endl;
	transfer.inStack();
	transfer.Stack::inStack();
	cout<<endl<<transfer.getTop();
	return 1;

	// Viet mot chuong trinh doi 1 so nguyen bat ki sang co so 2.
	// chi duoc phep su dung lop, khong viet code doi co so trong ham main()
	// khong duoc thay doi noi dung cua lop Stack
}