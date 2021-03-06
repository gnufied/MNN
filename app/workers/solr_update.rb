class SolrUpdate < BaseWorker

  def perform(classname, id)
    Rails.logger.info("  Queue: Indexing to SOLR #{classname}: #{id}")
    classname.constantize.find(id).solr_index
  end
end
