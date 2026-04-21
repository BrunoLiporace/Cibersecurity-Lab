# File System Structure: Inode and Linking Analysis

## 1. Laboratory Objetive
Based on Module 5 (Types of Links), I performed a practical test on my **Debian 13 Home Server** to undersand how the Linux Kernel manage data pointers (Inodes) within the LVM architecture

## 2. Practical Evidence (Inode Mapping)
During the laboratory exercise on the `/mnt/secure_storeage` volume, I created three types of entries. The results obtained via `ls -i` were:

|File Name | Inode Number | Type |
|:--- | :--- | :--- |
| `original_file.txt` | **53477379** | Original Entry |
| `hard_link.txt` | **53477379** | Hard Link |
| `sym_link.txt` | **53477380** | Symbolic Link |

## Technical Analysis: 
* **Hard Link Redundancy:** Note that `original_file.txt` and `hard_link.txt` share the **exact same Inode**. In Linux, this means they are the same phyisical data on the disk with two differents names. The data will only be deleted when the link count reaches zero.
* **Symbolic Link Abstraction:** The `sym_link.txt` has a **different Inode**, confirming it is a new file that merely contains a text string pointing to the path of the original file.

## 3. Maintance and Health Monitoring
As part of the system diagnostic routine, I monitored the Inode table using `df -i`.
**Security Insight:** In a production enviroment, an attacker could perform a "Denial of Service" by creating millions of empty files to exhaust the Inode table, even if disk space is available. Monitoring these numbers is a critical task for a **Security Architect**. 
