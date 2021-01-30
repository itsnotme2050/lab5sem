import java.util.Scanner;
public class CRC {
int W;
String P;
String checksum;
String message;
CRC()
{
W = 16;
P = "10001000000100001"; //0, 5, 12, 16
}
void crc()
{
String msg = message + "0000000000000000";
char[] rem = new char[P.length()];
// augmented message
for (int i=0; i < msg.length(); i++)
{
// take the next digit
rem[W] = msg.charAt(i);
// compute the reminder and shift left
boolean xor = rem[0] == '1';
for (int j=1; j <= W; j++)
{
if (xor) rem[j] = (rem[j]==P.charAt(j)) ? '0':'1';
rem[j-1] = rem[j];
}
}
checksum = String.valueOf(rem).substring(0, W); //excludes W
}
void input()
{
Scanner scanner = new Scanner(System.in);
System.out.print("MESSAGE:");
message = scanner.next();
scanner.close();
}
void output()
{
System.out.println("Checksum:"+checksum);
}
public static void main(String[] args)
{
CRC crc = new CRC();
crc.input();
crc.crc();
crc.output();
}
}
