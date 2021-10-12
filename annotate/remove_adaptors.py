import os
from sys import stdin,argv
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import IUPAC
from Bio import SeqIO




def seq_getter(filename1, outfile):
    """nasty func to mask adaptors found by NCBI.
    take in infile.fast and outfile.fasta
    paste in the adaptor region in the variable badboys. """
    # there is no elegance in the coding here!

    bad_boys = """scaffold14027	18298	1..22	adaptor:NGB01086.1
scaffold16339	16748	1..24	adaptor:NGB01088.1
scaffold19337	15070	1..28	adaptor:NGB01096.1
scaffold44416	7052	7024..7052	adaptor:NGB01088.1
scaffold76581	2614	2589..2614	adaptor:NGB01096.1
scaffold85172	1879	1..45	adaptor:NGB01090.1
scaffold87681	1701	1663..1701	adaptor:NGB01088.1
scaffold93841	1310	113..853	vector/etc""".split("\n")
    scaff_remove =  dict()
    for k_Reeves in bad_boys:
        data = k_Reeves.split()
        scaffold = data[0]
        elements = data[2]
        scaff_remove[scaffold] = elements

    f = open(outfile, "w")
    for seq_record in SeqIO.parse(filename1, "fasta"):
        #DNA_seq = seq_record.seq
        #translated_seq = DNA_seq.translate()
        #print translated_seq
        if seq_record.id in scaff_remove:
            elements = scaff_remove[seq_record.id]
            # print(elements)
            if elements.count(",") >= 1:
                more =  elements.split(",")
                for i in more:
                    start, stop = i.split("..")
                    start = int(start)
                    stop = int(stop)
                    if start < 10:
                        insert = int(stop) - int(start)
                        sequence = ""
                        seq = str(seq_record.seq)
                        seq_record.seq = Seq(seq.join([seq[:start -1], sequence, seq[stop:]]))
                    else:  
                        insert = int(stop) - int(start)
                        sequence = "N" * insert
                        seq = str(seq_record.seq)
                        seq_record.seq = Seq(seq.join([seq[:start -1], sequence, seq[stop:]]))
                    
                
            else:
                start, stop = elements.split("..")
                start = int(start)
                stop = int(stop)
                if start < 10:
                    insert = int(stop) - int(start)
                    sequence = ""
                    seq = str(seq_record.seq)
                    seq_record.seq = Seq(seq.join([seq[:start -1], sequence, seq[stop:]]))
                    print(seq_record.id, sequence, "removing the start")
                else:
                    insert = int(stop) - int(start)
                    sequence = "N" * insert
                    seq = str(seq_record.seq)
                    seq_record.seq = Seq(seq.join([seq[:start -1], sequence, seq[stop:]]))
        SeqIO.write(seq_record, f, "fasta")




# usage infile, outfile. 
seq_getter(argv[1],argv[2])
