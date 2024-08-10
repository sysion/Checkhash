# Script To Validate Hashes Of Downloaded Files/ISO

## checkhash.sh

This is a simple script that can validate hashes of files downloaded from the internet like
iso images. tar.gz etc.

Validation ensures that downloaded file's integrity is intact.

## Usage

To use this script, see below examples:

```bash
	$ ./checkhash.sh Django-5.0.7-py3-none-any.whl django_hashes_whl.txt md5
  $ ./checkhash.sh Django-5.0.7-py3-none-any.whl django_hashes_whl.txt sha256
  $ ./checkhash.sh Django-5.0.7-py3-none-any.whl c687175397b8d6d98b8e0e35e6f142fb md5
  $ ./checkhash.sh Django-5.0.7-py3-none-any.whl f216510ace3de5de01329463a315a629f33480e893a9024fc93d8c32c22913da sha256
```  
## Script Output

for success, the script outputs:

```bash
	$ OK
```  

and for failure:

```bash
	$ NOK
```  