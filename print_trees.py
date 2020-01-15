from ete3 import Tree, TextFace

seq_info_csv = open('C:/Users/User/Desktop/GDAV/Genomics/additional_seq_info.tsv')
seq_info_dict ={}
header = seq_info_csv.readline()
for line in seq_info_csv.readlines():
    seqname,genename,spname,lineage,gene,function = line.replace('\n','').split('\t')
    seq_info_dict[seqname] = [genename,spname,lineage,function]

tree = Tree('C:/Users/User/Desktop/GDAV/Genomics/NP_Unk01_blast.alg.treefile')
for leafnode in tree:
    if leafnode.name == 'NP_Unk01':
        leafnode.name = ''
        name_face = TextFace('NP_Unk01, Aquifex aeolicus (Bacteria_Aquificae)',fsize=10,fgcolor='red')
        leafnode.add_face(name_face,column=0)
    elif leafnode.name == 'NP_Unk02':
        leafnode.name = ''
        name_face = TextFace('NP_Unk02, Aquifex aeolicus (Bacteria_Aquificae)',fsize=10,fgcolor='red')
        leafnode.add_face(name_face,column=0)
    else:
        genename,spname,lineage,function = seq_info_dict[leafnode.name]
        if genename == 'N/A': leafnode.name = str(genename+", ("+function+"), "+spname+", ("+lineage+")")
        else: leafnode.name = str(genename+", "+spname+", ("+lineage+")")
tree.show()