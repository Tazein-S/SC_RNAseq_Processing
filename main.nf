include {BAMTOFASTQ} from './modules/cellranger_bamtofastqc'
include {COUNT} from './modules/cellranger_count'


workflow {

    Channel.fromPath("local_samplesheet.csv")
        .splitCsv(header: true)
        .map { row -> tuple(row.sample, file(row.path)) }
        .set { bam_ch }

    ///bam_ch.view()

    fastq_ch = BAMTOFASTQ(bam_ch)
    ///fastq_ch.view()

    COUNT(fastq_ch,params.ref_genome)

}