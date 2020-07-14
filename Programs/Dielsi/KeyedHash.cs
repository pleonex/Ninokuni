namespace Dielsi
{
    using System;
    using System.Security.Cryptography;
    using Yarhl.IO;

    public static class KeyedHash
    {
        public static int DigestSize => 0x14; // 160 bits

        public static byte[] GetHash(DataStream stream, long keyOffset, byte[] key)
        {
            if (stream == null)
                throw new ArgumentNullException(nameof(stream));

            // Write key
            stream.Position = keyOffset;
            stream.Write(key, 0, key.Length);

            // Generate hash
            byte[] hash = GenerateHash(stream);

            // Remove the key
            stream.Position = keyOffset;
            for (int i = 0; i < key.Length; i++) {
                stream.WriteByte(0x00);
            }

            return hash;
        }

        static byte[] GenerateHash(DataStream stream)
        {
            stream.Position = 0;
            byte[] data = new byte[stream.Length];
            stream.Read(data, 0, data.Length);

            using var sha1 = SHA1.Create();
            return sha1.ComputeHash(data);
        }
    }
}
