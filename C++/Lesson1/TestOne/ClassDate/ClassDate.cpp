
#include <iostream>
#include <conio.h>

using namespace std;

class Date {
private:
    int day, month, year;
    int days[12] = { 31, 28, 31, 30, 31, 30,31,31,30,31,30,31 };
public:
    Date() {
        day = month = year = 0;
    }
    Date(int aDay, int aMonth, int aYear) {
        day = aDay;
        month = aMonth;
        year = aYear;
    }
    void inputDate() {
        char bf;
        cout << "Nhap ngay thang nam (dd//mm//yy): ";
        cin >> day >> bf >> month >> bf >> year;
        if (month <= 12)
        {
            int dayCheck = daysIn();
            if (day > dayCheck)
            {
                month = 13;
            }
        }
        while (month > 12) {
            cout << "Error! Please input again " << endl;
            inputDate();
        }
    }
    void normalize() {
        while (month > 12) {
            month -= 12;
            year++;
        }
        while (day > this->daysIn()) {
            day -= this->daysIn();
            month++;
            if (month > 12)
            {
                month = 1;
                year++;
            }
        }
    }
    int daysIn() {
        /*int days;
        switch (month) {
             case 1: case 3: case 5: case 7: case 8: case 10 : case 12:
                 days = 31;
                 break;
             case 4: case 6: case 9: case 11:
                 days = 30;
                 break;
             case 2:
                 if (year % 4 == 0) {
                     if (year % 100 != 0)
                         days = 29;
                     days = 28;
                 }
                 else {
                     days = 28;
                 }
        }*/
        int add = 0;
        if (year % 4 == 0) {
            if (year % 100 != 0)
                add = 1;
            add = 0;
        }
        else {
            add = 0;
        }
        return days[month - 1] + add;
    }
    void reset(int y, int m, int d) {
        year = y;
        month = m;
        day = d;
    }
    void printDate() {
        cout << day << "/" << month << "/" << year << endl;
    }

    friend Date operator + (Date date, int days) {
        Date d1 = date;
        d1.day += days;
        d1.normalize();
        return d1;
    }
    friend int operator -(Date d2, Date d1) {
        int count = 0;
        Date dbf = d1;
        while (dbf.day != d2.day || dbf.month != d2.month || dbf.year != d2.year) {
            dbf.day += 1;
            dbf.normalize();
            count++;
        }
        return count;
    }
    int getDay() {
        return this->day;
    }
    int getMonth() {
        return this->month;
    }
    int getYear() {
        return this->year;
    }
};

int main()
{
    Date d1;
    d1.inputDate();
    d1.normalize();
    d1.printDate();
    cout << "days of month: " << d1.daysIn() << endl;
    Date d2;
    d2 = d1 + (int)100;
    cout << "100 ngay sau la ngay ";
    d2.printDate();
    Date d3;
    d3.inputDate();
    int betweenDays = d3 - d1;
    cout << "Con " << betweenDays << " la den ngay " << d3.getDay() << "/" << d3.getMonth() << "/" << d3.getYear() << " ke tu ngay "; d1.printDate(); cout << endl;
    cout << "Hello Hieu coder!\n";
}
