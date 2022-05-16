
#include <iostream>
using namespace std;
class Father {
public: 
     virtual void area() {
        cout << "This is father" << endl;
     }
      void test() {
          cout << "Father is best!" << endl;
      }
};

class Son :  public Father {
public: 
        void area() {
            cout << "This is Son" << endl;
        }
        void test() {
            cout << "Son is best" << endl;
        }
};

class Mother :  public Father {
public: 
    void area() {
        cout << "This is Mother" << endl;
    }
    void test() {
        cout << "Mother is best" << endl;
    }
};
int main()
{
    Father* father;
    Son son;
    Mother mother;
    father = &son;
    cout << "Father address: " << father << ", Son address: " << &son << endl;
    father->area();
    father = &mother;
    father->area();
    father = new Father();
    cout << endl;
    cout << "Father address: " << &father;

}
