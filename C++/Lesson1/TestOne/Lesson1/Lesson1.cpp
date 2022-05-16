
#include <iostream>
using namespace std;
class AbtractEmployee {
    virtual void askForPromotion() = 0;
};
class Employee:AbtractEmployee{
private:
    
    string company;
    int age;
protected:
    string name;
public:
    void setName(string aName) {
        name = aName;
    }
    string getName() {
        return name;
    }
    void setCompany(string aCompany) {
        company = aCompany;
    }
    string getCompany() {
        return company;
    }
    void setAge(int aAge) {
        if (aAge >= 18)
        {
            age = aAge;
        }
    }
    int getAge() {
        return age;
    }
    void introduceYourself() {
        cout << "Name: " << name << endl;
        cout << "Company: " << company << endl;
        cout << "Age: " << age << endl;
    }
    Employee(string aName, string aCompany, int aAge) {
        name = aName;
        company = aCompany;
        age = aAge;
    }
    void askForPromotion() {
        if (age >= 30)
            cout << "Got promotion!" << endl;
        else
            cout << "Sory, no promotion for you" << endl;
    }
    virtual void work() {
        cout << name << " is checking email, task backlog, running performance...." << endl;
    }
};

class Developer: public Employee {
public: 
    string favProgramingLanguage;
    Developer(string name, string company, int age, string aFavProgramingLanguage)
        :Employee(name,company,age)
    {
        favProgramingLanguage = aFavProgramingLanguage;
    }
    void fixBug() {
        cout << getName() << " Fixd bug using "<< favProgramingLanguage << endl;
    }
    void work() {
        cout << name << " is writing " << favProgramingLanguage << " code" << endl;
    }
};

class Teacher : public Employee {
public:
    string subject;
    Teacher(string name, string company, int age, string aSubject)
        :Employee(name, company, age) {
        subject = aSubject;
    }
    void prepareLesson() {
        cout << name << " prepare for " << subject << " lesson" << endl;
    }
    void work() {
        cout << name << " is teaching " << subject << " lesson" << endl;
    }
};

int main()
{
    Employee employee1("VanHieu", "Google", 20);
    Developer john = Developer("John", "Facebook", 29, "Java");
    Teacher jena = Teacher("Jena", "Hai Phong", 19, "History");
    Employee* e1 = &john;
    Employee* e2 = &jena;
    e1->work();
    e2->work();
}
