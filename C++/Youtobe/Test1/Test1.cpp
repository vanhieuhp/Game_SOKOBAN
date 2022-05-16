// Test1.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <math.h>
#include <stdio.h>
#include <string>
#include <vector>
#include <sstream>
#include <map>

using namespace std;

void solve() {
	string s; cin >> s;
	int i = s.length() - 2;
	while (i >= 0 && s[i] <= s[i + 1]) {
		--i;
	}
	if (i == -1)
	{
		cout << "-1" << endl; return;
	}
	int j = s.length() - 1;
	while (s[i] <= s[j] || (s[j - 1] == s[j] && s[i] > s[j])) {
		--j;
	}
	swap(s[i], s[j]);
	if (s[0] == '0')
	{
		cout << "test" << endl;
	}
	else {
		cout << s;
	}
}

int main()
{
	solve();
}