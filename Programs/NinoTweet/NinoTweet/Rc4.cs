using System;

namespace NinoTweet
{
    public static class Rc4
    {
        public static byte[] Run(byte[] data, byte[] key)
        {
            byte[] s = CreateArrayS(key);
            byte[] output = new byte[data.Length];

            for (int idx = 0, i = 0, j = 0; idx < data.Length; idx++) {
                i = (i + 1) % 256;
                j = (j + s[i]) % 256;

                byte swap = s[i];
                s[i] = s[j];
                s[j] = swap;

                byte k = s[(s[i] + s[j]) % 256];
                output[idx] = (byte)(data[idx] ^ k);
            }

            return output;
        }

        private static byte[] CreateArrayS(byte[] key)
        {
            byte[] s = new byte[256];
            byte[] t = new byte[256];

            for (int i = 0; i < 256; i++) {
                s[i] = (byte)i;
                t[i] = key[i % key.Length];
            }
                
            for (int i = 0, j = 0; i < 256; i++) {
                j = (j + s[i] + t[i]) % 256;

                byte swap = s[i];
                s[i] = s[j];
                s[j] = swap;
            }

            return s;
        }
    }
}

