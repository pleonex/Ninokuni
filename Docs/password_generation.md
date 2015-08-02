# How to create familiar's passwords

## Convert to text
The last operation is to mess the current password replacing each char with another. To do so, it's used the function `0x020C8BD0` with the following steps.

1. Check input is not null.
2. For each char:
    1. Get the index of char in the input encoding alphabet. In this alphabet     each char is one-byte.
    2. Get the char from the output encoding alphabet. In this case, there are     two bytes per char.
    3. Write the output char.
3. Write a null char at the end.

For the Spanish translation with the hack *Assembly/password/alphabet.asm* we replace the chars from the output alphabet that were Japanese kanjis with ASCII chars and some UNICODE symbols like arrows and circles.
