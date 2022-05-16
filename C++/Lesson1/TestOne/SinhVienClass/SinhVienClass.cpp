

#include <iostream>
#include <conio.h>
#include <algorithm>
using namespace std;

class SinhVien {
private:
    string name;
    string yearOfBirth;
    double scores[9];
    string lectures[9] = { "math", "biology", "chesmistry", "physics", "science", "literature", "geography", "ethics", "economics"};
    double avgScore = 0;
    string thesis;
    string getFinalTest;
    string lecRetest[9];
    int numOfRetest = 0;
public:
    void input() {
        cout << "Input name: ";
        cin >> name;
        cout << "Input year of birth: ";
        cin >> yearOfBirth;
        cout << "Input scores of " << name << endl;
        for (int i = 0; i < 9; i++) {
            cout << lectures[i] << ": ";
            cin >> scores[i];
        }
    }

    void setAvgScore() {
        for (int i = 0; i < 9; i++)
        {
            avgScore += scores[i];
        }
        avgScore /= 9;
    }
    void checkRetest() {
        for (int i = 0; i < 9; i++) {
            if (scores[i] < 5)
            {   
                lecRetest[numOfRetest] = lectures[i];
                numOfRetest++;
            }
        }
    }
    string checkThesis() {
        if (avgScore >= 7 && numOfRetest == 0)
        {
            thesis = "Yes";
        }
        else {
            thesis = "No";
        }
        return thesis;
    }

    string checkFinalTest() {
        if (avgScore >= 7 && numOfRetest == 0)
        {
            getFinalTest = "No";
        }
        else {
            getFinalTest = "Yes";
        }
        return getFinalTest;
    }

    void getLecRetest() {
        if (getFinalTest == "Yes")
        {
            cout << "retake the exam of: " << endl;
                for (int i = 0; i < numOfRetest-1; i++)
                {
                    cout << "\t" << lecRetest[i] << ",     ";
                }
                cout << lecRetest[numOfRetest - 1];
            cout << endl;
        }
        else {
            cout << name << " doesn't have to retake the exam";
        }
        
    }
    double getAvgScore() {
        return avgScore;
    }
    string getName() {
        return name;
    }
};
int main()
{
    SinhVien sv1;
    sv1.input();
    sv1.setAvgScore();
    sv1.checkRetest();
    cout << "Average score: " << sv1.getAvgScore() << endl;
    cout << "Get a thesis: " << sv1.checkThesis() << endl;
    cout << "Retake the exam: " << sv1.checkFinalTest() << endl;
    sv1.getLecRetest();
   
}
