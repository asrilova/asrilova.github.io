<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Change Log
22/Feb/2026 1.0 ASR Version inicial
22/Feb/2026 1.1 ASR Procesar archivos con multiples facturas

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="no"/>
	<xsl:output method="xml" version="1.0" encoding="iso-8859-1"/>
	<xsl:template match="Facturas">
		<Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<CstmrCdtTrfInitn>
				<GrpHdr>
					<MsgId>
						<xsl:value-of select="Lote"/>
					</MsgId>
					<CreDtTm>
						<xsl:value-of select="FechaLote"/>
					</CreDtTm>
					<NbOfTxs><xsl:value-of select="count(Factura)"/></NbOfTxs>
					<InitgPty>
						<Nm>Hijas de Maria Auxiliadora</Nm>
					</InitgPty>
				</GrpHdr>
				<xsl:for-each select="Factura">
				<PmtInf>
					<PmtInfId>
						<xsl:value-of select="NumFactura"/>
					</PmtInfId>
					<PmtMtd>TRF</PmtMtd>
					<PmtTpInf>
						<SvcLvl>
							<Cd>NURG</Cd>
						</SvcLvl>
					</PmtTpInf>
					<ReqdExctnDt>
						<xsl:value-of select="Vencimiento"/>
					</ReqdExctnDt>
					<Dbtr>
						<Nm>Hijas de Maria Auxiliadora</Nm>
						<PstlAdr>
							<TwnNm>León</TwnNm>
							<Ctry>ES</Ctry>
							<AdrLine>San Juan Bosco 20</AdrLine>
						</PstlAdr>
					</Dbtr>
					<DbtrAcct>
						<Id>
							<Othr>
								<Id>ES00001111222233334444</Id>
							</Othr>
						</Id>
						<Ccy>EUR</Ccy>
					</DbtrAcct>
					<DbtrAgt>
						<FinInstnId>
							<BIC>CAIXESBB</BIC>
						</FinInstnId>
					</DbtrAgt>
					<CdtTrfTxInf>
						<PmtId>
							<InstrId>
								<xsl:value-of select="NumFactura"/>
							</InstrId>
							<EndToEndId>
								<xsl:value-of select="NumFactura"/>
							</EndToEndId>
						</PmtId>
						<Amt>
							<InstdAmt>
								<xsl:attribute name="Ccy">EUR</xsl:attribute>
								<xsl:value-of select="Importe"/>
							</InstdAmt>
						</Amt>
						<ChrgBr>SHA</ChrgBr>
						<CdtrAgt>
							<FinInstnId>
								<BIC>
									<xsl:value-of select="Acreedor/BIC"/>
								</BIC>
								<PstlAdr>
									<Ctry>ES</Ctry>
								</PstlAdr>
							</FinInstnId>
						</CdtrAgt>
						<Cdtr>
							<Nm>
								<xsl:value-of select="Acreedor/Nombre"/>
							</Nm>
							<PstlAdr>
								<TwnNm>
									<xsl:value-of select="Acreedor/Poblacion"/>
								</TwnNm>
								<Ctry>
									<xsl:value-of select="Acreedor/Pais"/>
								</Ctry>
								<AdrLine>
									<xsl:value-of select="substring(Acreedor/Direccion, 1, 70)"/>
								</AdrLine>
								<xsl:if test="substring(Acreedor/Direccion, 71)!=''">
								    <AdrLine>
									    <xsl:value-of select="substring(Acreedor/Direccion, 71, 70)"/>
									</AdrLine>
								</xsl:if>

							</PstlAdr>
						</Cdtr>
						<CdtrAcct>
							<Id>
								<IBAN>
									<xsl:value-of select="Acreedor/IBAN"/>
								</IBAN>
							</Id>
						</CdtrAcct>
						<RmtInf>
						    <!-- Caixa acepta un maximo de 35 caracteres por cada linea de concepto -->
							<Ustrd>
								<xsl:value-of select="substring(Concepto,1,35)"/>
							</Ustrd>
							<xsl:if test="substring(Concepto,36)!=''">
								<Ustrd>
									<xsl:value-of select="substring(Concepto,36,35)"/>
								</Ustrd>
							</xsl:if>
						</RmtInf>
					</CdtTrfTxInf>
				</PmtInf>
				</xsl:for-each>
			</CstmrCdtTrfInitn>
		</Document>
	</xsl:template>
</xsl:stylesheet>