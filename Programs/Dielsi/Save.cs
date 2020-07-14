namespace Dielsi
{
    using System;
    using Yarhl.IO;

    public class Save
    {
        // It's a bitset, one bit set to enable each DLC item.
        const uint DlcOffset = 0xF32F;
        const uint DlcSize = 0x10;

        public Save(DataStream stream)
        {
            Stream = stream ?? throw new ArgumentNullException(nameof(stream));
        }

        public DataStream Stream { get; }

        public void EnableDlcs()
        {
            Stream.Position = DlcOffset;
            for (int i = 0; i < DlcSize; i++) {
                Stream.WriteByte(0xFF);
            }
        }
    }
}
