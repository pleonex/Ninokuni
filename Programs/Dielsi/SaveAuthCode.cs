namespace Dielsi
{
    using System;
    using System.Linq;
    using Yarhl.IO;

    public class SaveAuthCode
    {
        const int SaveLength = 0x10000; // 64 KB

        const ushort StartCode = 0x28;
        const ulong EndCode = 0x7D9A32EC84A53F0B;

        const long HashOffset = 0xFFE4;
        const uint KeyOffset = 0xC5EC;
        static readonly byte[] Key = { 0x6E, 0x6B, 0x6E, 0x6E }; // "nknn"

        public static bool Verify(DataStream stream)
        {
            if (stream == null)
                throw new ArgumentNullException(nameof(stream));

            if (stream.Length < SaveLength) {
                Console.WriteLine("ERROR: Invalid save length");
                return false;
            }

            var reader = new DataReader(stream);

            // Check start
            stream.Position = 0;
            if (reader.ReadUInt16() != StartCode) {
                Console.WriteLine("ERROR: Invalid start code");
                return false;
            }

            // Check end
            stream.Position = SaveLength - 8;
            if (reader.ReadUInt64() != EndCode) {
                Console.WriteLine("ERROR: Invalid end code");
                return false;
            }

            // Check hash in the substream with actual data (skip check codes)
            using var dataStream = new DataStream(stream, 2, HashOffset - 2);
            byte[] expectedHash = KeyedHash.GetHash(dataStream, KeyOffset - 2, Key);

            stream.Position = HashOffset;
            byte[] actualHash = reader.ReadBytes(KeyedHash.DigestSize);

            if (!expectedHash.SequenceEqual(actualHash)) {
                Console.WriteLine("ERROR: Invalid hash");
                return false;
            }

            return true;
        }

        public static void UpdateHash(DataStream stream)
        {
            using var dataStream = new DataStream(stream, 2, HashOffset - 2);
            byte[] hash = KeyedHash.GetHash(dataStream, KeyOffset, Key);

            stream.Position = HashOffset;
            stream.Write(hash, 0, hash.Length);
        }
    }
}