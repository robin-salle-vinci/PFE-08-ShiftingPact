import type { Answer } from './Answer'
import type { ClientInformation } from './ClientInformation'

export interface Pact {
  id: string
  id_module_esg: string
  creation_date: string
  client_information: ClientInformation
  answers_commitment: Answer[]
}
