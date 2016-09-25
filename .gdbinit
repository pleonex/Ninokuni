set architecture arm
alias -a m-arm = set arm fallback-mode

# Print String 0
break *0x020DF1EC
commands
    silent
    printf "PrintString0: [%d, %d] -> %s\n", $r1, $r2, $r3
    cont
end

# Print String 1
break *0x020DE2D8
commands
    silent
    printf "PrintString1: [%d, %d] -> %s\n", $r1, $r2, $r3
    cont
end

# Print String 2
break *0x020DE3C4
commands
    silent
    printf "PrintString2: %s\n", $r1, $r2, *((int*)($sp+4))
    cont
end

# Print String 3
break *0x020DE350
commands
    silent
    # Not sure yet
    #printf "PrintString3: [%d, %d] -> %s\n", $r1, $r2, $r3
    #cont
end

# Set OAM positions
break *0x02043BD0
commands
    silent
    printf "OAMSetPos: [%d, %d]\n", $r1, $r2
    cont
end

target remote :23946


