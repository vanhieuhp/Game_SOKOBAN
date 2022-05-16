
#include <iostream>
#include <conio.h>
using namespace std;

class Time {
private:
    int second, minute, hour;
public:
    Time() {
        second = minute = hour = 0;
    }
    Time(int s, int m, int h) {
        second = s;
        minute = m;
        hour = h;
    }
    void inputTime() {
        char bf;
        cout << "Input time(hh:mm:ss): ";
        cin >> hour >> bf >> minute >> bf >> second;
    }

    void reset(int h,int m, int s) {
        second = s;
        minute = m;
        hour = h;
    }
    friend Time operator + (Time t1, int second) {
        Time t = t1;
        t.minute += second;
        t.normalize();
        return t;
    }
    void normalize() {
        while (second >= 60) {
            second -= 60;
            minute++;
        }

        while (minute >= 60) {
            minute -= 60;
            hour++;
        }

        if (hour >= 24) {
            hour = 0;
        }
    }
    void outputTime() {
        cout << hour << ":" << minute << ":" << second << endl;
    }
};

int main()
{
    Time t1;
    t1.inputTime();
    t1.normalize();
    t1.outputTime();
    Time t2;
    t2 = t1 + 60;
    cout << "After adding up 1 hour: ";
    t2.outputTime();
    t1 = t1 + 50;
    cout << "After adding up 50 minutes: ";
    t1.outputTime();
}