
#include <iostream>
#include <conio.h>
using namespace std;

class String {
private:
    int length;
    string text;
public:
    String() {
        text = "";
        length = 0;
    }
    String(string aText) {
        text = aText;
    }
    void inputString() {
        cout << "Input one string: ";
        cin >> text;
    }
    void outputString() {
        cout << "string inputted: " << text << endl;
    }
    string getString() {
        return text;
    }
    int getLength() {
        length = text.length();
        return length;
    }
    char getChar(int i) {
        int maxLength = getLength();
        if (i > maxLength)
        {
            i = 0;
        }
        char result = text[i];
        return result;
    }
};

int main()
{
    String s1;
    s1.inputString();
    s1.outputString();
    String s2 = String("hello I'm a");
    String s3 = String(" developer!");
    cout << s2.getString() << " " <<s1.getString() << s3.getString() << endl;
    cout << "Length of s1: " << s1.getLength() << endl;
    int i;
    cout << "input index you to find in string: ";
    cin >> i;
    cout << "The " << i << " element: " << s1.getChar(i) << endl;

}