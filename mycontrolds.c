#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib,"ws2_32.lib")


int main(){
char server_ip[16];
const int port=25565;


printf("Enter server IP (example:35.184.70.121):");

if(scanf("%15s",server_ip)!=1){
printf("Invalid input.\n");
return 1;}


WSADATA wsa;
if(WSAStartup(MAKEWORD(2,2),&wsa)!=0){
printf("WSAStartup failed:%d\n",WSAGetLastError());
return 1;}

SOCKET sock=socket(AF_INET,SOCK_STREAM,0);

if(sock==INVALID_SOCKET){
printf("Socket creation failed:%d\n",WSAGetLastError());
WSACleanup();
return 1;}


struct sockaddr_in server;
memset(&server,0,sizeof(server));
server.sin_family=AF_INET;
server.sin_port=htons(port);

if(inet_pton(AF_INET,server_ip,&server.sin_addr)<=0){
printf("Invalid IP address:%s\n",server_ip);
closesocket(sock);
WSACleanup();
return 1;}


printf("Connecting to %s:%d...\n",server_ip,port);
if(connect(sock,(struct sockaddr*)&server,sizeof(server))==SOCKET_ERROR){
printf("Connection failed:%d\n",WSAGetLastError());}
else{
printf("Server is reachable!\n");}
closesocket(sock);
WSACleanup();
return 0;}