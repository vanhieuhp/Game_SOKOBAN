#include <iostream>
#include <conio.h>
#include <string.h>
#include <iomanip>
using namespace std;
class Bill {
private:
    int number;
    char name[100];
    double price;
public:
    static int count;
    static int moneyTotal;
    Bill() {
    }
    void setBill() {
        cout << "Enter quantity : "; cin >> number;
        cout << "Enter item name: "; cin.ignore(); cin.get(name, 100);
        cout << "Enter price: "; cin >> price;
    }
    void getBill() {
        count++;
        cout << endl << setw(10) << name << setw(20) << number << setw(10) << price << endl;
        moneyTotal += this->price * this->number;
    }
    double getPrice() {
        return price;
    }
    string getName() {
        return name;
    }
    int getQuantity() {
        return number;
    }
    /*friend Bill swapBill(Bill& i, Bill& j) {
    	cout<<"before swapping "<<i.getPrice() << endl;
        Bill bill = Bill();
        bill.number = i.number; strcpy(bill.name, i.name); bill.price = i.price;
        i.number = j.number; strcpy(i.name, j.name); i.price = j.price;
        j.number = bill.number; strcpy(j.name, bill.name); j.price = bill.price;

    }*/
    Bill* next = NULL;
};

int Bill::count = 0;
int Bill::moneyTotal = 0;

int main()
{
    cout << "bill numbers: " << Bill::count << ", Money Total: " << Bill::moneyTotal << endl;
    Bill* list = NULL, * endList = NULL;
    char  ok = 'y';
    while (ok == 'y') {
        Bill* bill = new Bill;
        bill->setBill();
        bill->next = NULL;
        if (list == NULL)
        {
            list = bill;
            endList = bill;
        }
        else {
            endList->next = bill;
            endList = bill;
        }
        cout << "Do you want to continue insert bill(y or n)? ";
        cin.ignore();
        cin >> ok;
    }
    Bill* print = list;
    cout << endl << setw(10) << "Item Name" << setw(20) << "Quantity" << setw(10) << "Price" << endl;
    while (print != NULL) {
        print->getBill();
        print = print->next;
    }
    cout << "bill total: " << Bill::count << ", money total: " << Bill::moneyTotal << endl;
    Bill* i = NULL, * j = NULL;
    i = list;
    //cout << i;
    /*while (i != NULL) {
        j = i->next;
        while (j != NULL) {
            if (j->getPrice() < j->getPrice())
            {
                swapBill(*j, *i);
                j = j->next;
            }
            i = i->next;
        }
    }*/

///   cout << "After sorting " << endl;
   /* print = list;
    cout << endl << setw(10) << "Item Name" << setw(20) << "Quantity" << setw(10) << "Price" << endl;
    while (print != NULL) {
        print->getBill();
        print = print->next;
    }*/
    return 0;
}
