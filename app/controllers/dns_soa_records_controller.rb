# encoding: utf-8

#Author: Johann-Michael THIEBAUT <johann.thiebaut@gmail.com>
#So we can see all type SOA DNS Records.

class DnsSoaRecordsController < DnsRecordsController

  private

    #Override: we only want SOA records
    def set_conditions_and_title
      @conditions = ["rtype = 'SOA'"]
      @title = "Tous les enregistrements de type SOA"
    end

    #Override: we only want to do manipulate SOA records
    def check_record
      @record = DnsRecord.find(params[:id])
      if @record.rtype != 'SOA'
        flash[:error] = "Le champ demandé n'est pas de type SOA"
        redirect_to dns_soa_records_path
      end
    end

end
