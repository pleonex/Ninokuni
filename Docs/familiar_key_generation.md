# How to create familiar's keys
In the Familiar shelter / gutter there is a menu that **generates a key**. Pressing 'X' when you try to store or retrieve a familiar on the shelter a small dialog appear with some random text. **Nobody knows the meaning**, there is no information on the Internet and probably is a **forgotten feature**. There are some [hidden image](http://gbatemp.net/threads/spanish-v1-0-released-ninokuni-shikkoku-no-madoushi-translation-project.310214/page-34#post-5176232) on the game, probably of the Demo version, with buttons to *Insert a key*, but they do not appear in the final game. As you can read in this document, the key **contains information about the familiar** and some random numbers. In my opinion, it was a final-not-implemented-feature **to share familiar globally**, sharing codes, without Internet connection, similar to save-keys when there wasn't save memories on video games or like *Pokémon Mystery Dungeon* to rescue another user.

1. [Copy stats from familiar](#copy-stats-from-familiar)
2. [Add random number](#add-random-number)
3. [Reverse](#reverse)
4. [Encrypt](#encrypt)
5. [Append CRC](#append-crc)
6. [Encrypt2](#encrypt2)
7. [Swap](#swap)
8. [Convert to text](#convert-to-text)
9. [Change of alphabet](#change-of-alphabet)

## Copy stats from familiar
Firstly and most important, the game copies familiar's stats. This is the purpose of the key and the last step when doing the reverse operation. The information to copy is the following. Beware it copies bits, not bytes.

| Field          | Bits  | Notes |
| -------------- |:-----:| ----- |
| Name           | 4 * 8 | Copy only the first 4 characters. |
| Level          | 7     | |
| Unknown        | 3     | It's bits 1-3 from 0x27 save familiar structure. |
| Index          | 10    | |
| HP             | 7     | Divided by 8, less precision but higher values. |
| MP             | 7     | Divided by 8. |
| Attack         | 7     | Divided by 8. |
| Deffense       | 7     | Divided by 8. |
| Magic Attack   | 7     | Divided by 8. |
| Magic Deffense | 7     | Divided by 8. |
| Hability       | 7     | Divided by 8. |

## Add random number
Next step is to add some random bits. The game implements a *pseudo-random generator* for 32-bits values. In this case, it updated the *pseudo-random* number and take 11 bits, skipping the first 16 bits, to write in our stream. That is:
```
random_number = update_random_number()
random_number >>= 16
stream.write_bits(random_number, 11)
```

The *pseudo-random number generator* is initialize with a 4-bytes pseudo-random number (TODO: figure out how). Each time it's used, the number is updated as follow. The constants values are set at the initialization (function `0x020D13A4`) and the three values are stored at `0x02143100`.
```
CONSTANT1 = 0x5D588B65
CONSTANT2 = 0x269EC3
new_random_number = random_number * CONSTANT1 + CONSTANT2
```

## Reverse
Reverse the current bytes so last byte is not the first one.

## Encrypt
Encrypt the key with the `XOR` operator. The first operator will be like the key that it's updated each time the operation is applied. The second operator will be each byte of the current familiar key.

The encryption key is initialized with the first byte of the familiar key, this byte is not encrypted and remain the same thus. In this way, later doing the reverse operation we can know that value. After encrypting a byte, the key is updated moving its most significant bit to the less significant position and doing a `NOT` operation. The operation in python would be:

```python
FAMILIAR_KEY = [ ]  # 14 bytes key.
encrypt_key = FAMILIAR_KEY[0]

for i in range(1, len(FAMILIAR_KEY)):
    FAMILIAR_KEY[i] ^= encrypt_key
    encrypt_key = ((encrypt_key << 1) & 0xFF) | (encrypt_key >> 7)
    encrypt_key ^= 0xFF  # NOT operation, in this way no casting is needed.
```

## Append CRC
Next step is to generate some CRC-16 codes and mix them. The algorithm used is "CRC-16/GENIBUS" as described in this [CRC catalog](http://reveng.sourceforge.net/crc-catalogue) with this specification:
```
width=16 poly=0x1021 init=0xffff refin=false refout=false xorout=0xffff check=0xd64e
```

The first CRC is computed with the current 14-bytes length familra key. A second CRC value is calculated with the constant 8 bytes value:
```
21 6D EC 88 FF CC 85 EF  A2
```
so it's always `0x00D3`. This constant is at `0x020CC1A4`. The bytes are copied in reverse and with a `NOT` operation.

Once both CRC are calculated, they are mixed doing the following `XOR` operation: `CRC1 XOR CRC2 XOR 0x62D3`. This value is appended at the end of the familiar key so we get a 16 bytes length key.

## Encrypt2
By using the CRC the game encrypt again the password. In this case it's involved a *psuedo random generator* different to the one previously used. The way it updates the 32-bits value is described below:
```
rnd = (rnd * 0x021FC436) + 1
```

Firstly, it's initialized adding `0x05888F27` to the CRC. Then, for each byte, the game first update the random number and by using the last byte do the `XOR` operation over a key value. Obviously the CRC is not encrypted so it's possible to initialize the key again to decrypt.
```python
rnd = 0x05888F27 + CRC
for i in range(len(FAMILIAR_KEY) - 2):
    rnd = (rnd * 0x021FC436) + 1      # Update random number
    encrypt_key = (rnd >> 24) & 0xFF  # Take last byte
    FAMILIAR_KEY[i] ^= encrypt_key    # Encrypt
```

## Swap
After encrypt the key, one the CRC byte is swap with a key value, in this way the full CRC-16 value is not at the end of the key, making more difficult to guess it. To do that, the previously used *random generator* is initialized with the constant `0x014A76E0` and updated, so the final *random* number would be `0x6DD89341`. The modulo operation is applied to this value and the length of the key without CRC, 14. The result, 11 (0xB), is the position where the first CRC value will be swapped.

```
rnd = 0x014A76E0              # Init random number
rnd = (rnd * 0x021FC436) + 1  # Update random number
idx = rnd % (len(FAMILIAR_KEY) - 2)  # Get index

# Swap
crc_pos = len(FAMILIAR_KEY) - 2
tmp = FAMILIAR_KEY[crc_pos]
FAMILIAR_KEY[crc_pos] = FAMILIAR_KEY[idx]
FAMILIAR_KEY[idx] = tmp
```

## Convert to text
The game convert the current 64-bits value to a string with a dictionary / alphabet. First it does the modulo operation to get the index of the char and then divide the value until it become 0. The *alphabet1* is used with length `0x3A` (58 chars) and 8-bits per char. It's at `0x0x020CC8E8`.
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

Once the key is in text format, the game checks if it can get back the value.
```
data_i = data_i-1 + (char_i_index * alphabet1_len^i)
```

In python (*Programs/scripts/Password.py*) it would be:
```python
ITERATION = 0xB
KEY = "" # 11 key-len here

data = 0
for i in range(ITERATION):
    idx = ALPHABET1.find(KEY[i])
    data = data + (idx * (len(ALPHABET1) ** i))
```

## Change of alphabet
The last operation is to mess the current key replacing each char with another. To do so, it's used the function `0x020C8BD0` with the following steps.

1. Check input is not null.
2. For each char:
    1. Get the index of char in the **alphabet 1**.
    2. Get the char in that index from the **alphabet 2**.
    3. Write the output char.
3. Write a null char at the end.

The *alphabet2* it's at `0x020CC924` with two bytes per char. The size is variable, until found a null char.
```
ALPHABET2 = "０１２３４５６７８９あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん！？"
```

For the Spanish translation with the hack *Assembly/password/alphabet.asm* we replace the *alphabet 2* Japanese kanjis with ASCII chars and some UNICODE symbols like arrows and circles. The game continue to read two bytes to get a char, so if it's the index is in the ASCII part it replace one with two char.
A UNICODE char must start in an even position.
