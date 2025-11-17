include {WGET} from './modules/wget'
include {BAMTOFASTQ} from './modules/cellranger_bamtofastqc'
include {COUNT} from './modules/cellranger_count'


workflow {

    Channel.fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row -> tuple(row.sample, row.ftp) }
        .set { dl_ch }

    //dl_ch.view()

    WGET(dl_ch)
    BAMTOFASTQ(WGET.out)
    COUNT(BAMTOFASTQ.out,params.index)

}