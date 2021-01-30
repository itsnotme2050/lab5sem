import java.util.Scanner;
public class RSA
{
int x;
int y;
int n; // S=(x,n), P=(y,n)
String T;
// gcd(m,n) = gcd(n, m%n)
int gcd(int m, int n)
{
if (n == 0) return m;
return gcd(n, m%n);
}
// a^m % n
int pow(int a, int m, int n)
{
int r = 1;
while (m-- != 0)
r = (r*a) % n;
return r ;
}
void rsa()
{
int a;
int b;
int z;
//odd prime numbers 3, 5 (3, 11?)
a = 11;
b = 13;
n = a*b;
z = (a-1)*(b-1);
// choose e as relative prime
for (x=2; gcd(x, z) != 1; x++);
// choose d as inverse of e
for (y=2; (y*x) % z != 1; y++);
System.out.println("\n(x,n)=(" + x + "," + n + ")" + " Public Key");
System.out.println("\n(y,n)=(" + y + "," + n + ")" + " Private Key");
System.out.println("\n");
}
void cipher(char[] T, int k, int n) // k = e or d
{
for (int i=0; i < T.length; i++)
{
T[i] = (char)pow(T[i], k, n);
}
System.out.println("C: " + String.valueOf(T));
}
void input()
{
Scanner scanner = new Scanner(System.in);
System.out.print("Enter T:");
T = scanner.next();
scanner.close();
}
void output()
{
System.out.println("T: " + T);
char[] M = T.toCharArray();
cipher(M, x, n); // M^x % n
cipher(M, y, n); // C^y % n
}
public static void main(String[] args)
{
RSA r = new RSA();
r.rsa();
r.input();
r.output();
}
}