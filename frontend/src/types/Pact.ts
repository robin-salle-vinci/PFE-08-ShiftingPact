import type { Answer } from './Answer'

export interface Pact {
  id: string
  id_module_esg: string
  creation_date: string
  id_client: string
  answers_commitment: Answer[]
}
