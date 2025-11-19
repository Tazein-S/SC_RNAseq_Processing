process COUNT {
    label 'process_veryhigh'
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample), path(fastqs)
    path(index)

    output:
    path("*")

    script:
    """
    cellranger count --id=$sample \
        --transcriptome=$index \
        --fastqs=$fastqs \
        --create-bam=true \
        --localcores=16 \
        --localmem=256
    """

    stub:
    """
    touch stub.fastq
    """
}