
for create database 
CREATE TABLE user (
    id INT NOT NULL AUTO_INCREMENT,
    uname VARCHAR(20) ,
    pwd VARCHAR(20) ,
    contact INT ,
    email VARCHAR(20) ,
    type VARCHAR(10) ,
    PRIMARY KEY (id),
    KEY (uname)
);

.. tells Ruby to look one folder up

product 
(Primary key)id, name,(Forain Key)category, price, stock
create table product(id int AUTO_INCREMENT PRIMARY KEY, name varchar(20),category varchar(20),price decimal(10,2),stock bigint, FOREIGN KEY (category) REFERENCES category(name));


category
id, (Primary Key)name
create table category(id int AUTO_INCREMENT UNIQUE,name varchar(20) PRIMARY KEY);

cart
create table cart(id int auto_increment PRIMARY KEY,product_id int,quantity int CHECK (quantity >= 0), foreign key (product_id) references product(id));

ssh
rails@rails:~$ ssh-keygen -t ed25519 -C "suhanikaushal57@gmail.com"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/rails/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/rails/.ssh/id_ed25519
Your public key has been saved in /home/rails/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:f2Vpey3Wlj1JtoODsiXlshUznRpz83VIkqxUZb07LZY suhanikaushal57@gmail.com
The key's randomart image is:
+--[ED25519 256]--+
|            ..o. |
|           o o  .|
|          . + . .|
|         . ..o.+ |
|        S .B =*+=|
|         .o X+E=X|
|         +.*.++OB|
|          O. ..+o|
|         o       |
+----[SHA256]-----+
rails@rails:~$ 
git config --global user.email "you@example.com"

rails@rails:~$ pwd
/home/rails
rails@rails:~$ cd .ssh
rails@rails:~/.ssh$ cd id_ed25519.pub
bash: cd: id_ed25519.pub: Not a directory
rails@rails:~/.ssh$ touch id_ed25519.pub
rails@rails:~/.ssh$ ls 
id_ed25519  id_ed25519.pub
rails@rails:~/.ssh$ eval "$(ssh-agent -s)"
Agent pid 4906
rails@rails:~/.ssh$ ssh-add ~/.ssh/id_ed25519
Enter passphrase for /home/rails/.ssh/id_ed25519: 
Bad passphrase, try again for /home/rails/.ssh/id_ed25519: 
Identity added: /home/rails/.ssh/id_ed25519 (suhanikaushal57@gmail.com)
rails@rails:~/.ssh$ cat ~/.ssh/id_ed25519.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4syiAXRMBW1BzmdWcq4LPcfsOALBqDPLDhYmQ/gBa8 suhanikaushal57@gmail.com
rails@rails:~/.ssh$ ssh -T git@github.com
The authenticity of host 'github.com (20.207.73.82)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com,20.207.73.82' (ECDSA) to the list of known hosts.
Hi Suhhanii! You've successfully authenticated, but GitHub does not provide shell access.
rails@rails:~/.ssh$ ssh -T git@github.com
Hi Suhhanii! You've successfully authenticated, but GitHub does not provide shell access.
rails@rails:~/.ssh$ 

private key 
SHA256:f2Vpey3Wlj1JtoODsiXlshUznRpz83VIkqxUZb07LZY suhanikaushal57@gmail.com

public key 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4syiAXRMBW1BzmdWcq4LPcfsOALBqDPLDhYmQ/gBa8 suhanikaushal57@gmail.com

*global config username and email 
Is It Permanent
change it
unset it
edit .gitconfig
git config --global user.name "Suhani"

*local config username and email , only accessable for local folder 
git config --global user.name "suhani"
git config --global user.email "suhanikaushal57@gmail.com"

*for check local config
git config --list

*for check global config
git config -- global --list