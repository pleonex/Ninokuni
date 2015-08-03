# How to create familiar's passwords

## Convert to text
The game convert the current 64-bits value to a string with a dictionary / alphabet. First it does the modulo operation to get the index of the char and then divide the value until it become 0. The *alphabet1* is used with length `0x3A` (58 chars) and 8-bits per char.
```python
ALPHABET1 = "0123456789abcdefghijkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
```

The process in *Python* is the following (*Programs/script/Password.py*):
```python
text = ''
while data != 0:
    index = data % 0x3A
    text += ALPHABET1[index]
    data /= 0x3A
```

Once the password is in text format, the game checks if it can get back the value.
```
data_i = data_i-1 + (char_i_index * alphabet1_len^i)
```

In python (*Programs/scripts/Password.py*) it would be:
```python
ITERATION = 0xB
PASSWORD = "" # 11 password-len here

data = 0
for i in range(ITERATION):
    idx = ALPHABET1.find(PASSWORD[i])
    data = data + (idx * (len(ALPHABET1) ** i))
```

## Change of alphabet
The last operation is to mess the current password replacing each char with another. To do so, it's used the function `0x020C8BD0` with the following steps.

1. Check input is not null.
2. For each char:
    1. Get the index of char in the **alphabet 1**. In this alphabet     each char is one-byte. It's at `0x020CC8E8`. The size is fixed: 56 chars.
    2. Get the char in that index from the **alphabet 2**. In this case, there are two bytes per char. It's at `0x020CC924`. The size is variable, until found a null char.
    3. Write the output char.
3. Write a null char at the end.

```python
ALPHABET2 = ""
```

For the Spanish translation with the hack *Assembly/password/alphabet.asm* we replace the *alphabet 2* Japanese kanjis with ASCII chars and some UNICODE symbols like arrows and circles. The game continue to read two bytes to get a char, so if it's the index is in the ASCII part it replace one with two char.
A UNICODE char must start in an even position.
