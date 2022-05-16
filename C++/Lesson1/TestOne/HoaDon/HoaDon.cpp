
#include <iostream>
#include <iomanip>
using namespace std;
class HoaDon {
private:
    int shd;
    char tenhang[100];
    float tienban;
public:
    HoaDon() {

    }
    void nhap() {
        cout << endl << "Nhap so hoa don: "; cin >> shd;
        cout << endl << "Nhap ten ahng: "; cin.ignore(); cin.get(tenhang, 100);
        cout << endl << "Nhan tien ban: "; cin >> tienban;
    }
    void in() {
        cout << endl << setw(10) << shd << setw(50) << tenhang << setw(10) << tienban;
    }
    HoaDon* next;
};
int main()
{
    std::cout << "Hello World!\n";
    HoaDon* dau = NULL, *cuoi = NULL, * node = NULL;
    do {
        node = new HoaDon;
        node->nhap();
        node->next = NULL;
        if (dau == NULL)
        {
            dau = cuoi = node;
        }
        else {
            cuoi->next = node;
        }
    }
}