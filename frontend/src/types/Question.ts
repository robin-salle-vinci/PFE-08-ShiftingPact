import type { Choice } from './Choice'

export interface Question {
  id: string
  index_question: string
  template: string
  value: string
  type_response: string
  choices: Choice[]
}
