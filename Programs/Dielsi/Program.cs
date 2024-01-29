using System;
using System.IO;
using Yarhl.IO;

namespace Dielsi
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Dielsi v{0}", typeof(Program).Assembly.GetName().Version.ToString());
            if (args.Length != 1) {
                Console.WriteLine("Invalid arguments. Expecting path to single save file");
                Exit(1);
            }

            string savePath = args[0];
            if (!File.Exists(savePath)) {
                Console.WriteLine("Path doesn't exist: {0}", savePath);
                Exit(2);
            }

            try {
                CreateBackup(savePath);
                EnableDlc(savePath);
            } catch (Exception ex) {
                Console.WriteLine("Unexpected error: {0}", ex);
                Exit(3);
            }

            Console.WriteLine();
            Console.WriteLine("Save updated! :)");
            Console.ReadLine();
        }

        static void CreateBackup(string path)
        {
            string outputDir = Path.GetDirectoryName(path);
            string outputName = Path.GetFileNameWithoutExtension(path) + "_" + Path.GetRandomFileName();
            string outputExtension = Path.GetExtension(path);
            string outputPath = Path.Combine(outputDir, outputName + outputExtension);

            Console.WriteLine("Creating backup at: {0}", outputPath);
            File.Copy(path, outputPath);
        }

        static void EnableDlc(string path)
        {
            using var stream = DataStreamFactory.FromFile(path, FileOpenMode.ReadWrite);
            if (!SaveAuthCode.Verify(stream)) {
                Console.WriteLine("Invalid or corrupted save file");
                Exit(3);
            }

            var save = new Save(stream);
            save.EnableDlcs();

            SaveAuthCode.UpdateHash(stream);
        }

        static void Exit(int code)
        {
            Console.WriteLine("Press Enter to continue...");
            Console.ReadLine();
            Environment.Exit(code);
        }
    }
}
