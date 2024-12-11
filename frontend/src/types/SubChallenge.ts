import type { Question } from './Question'

export interface SubChallenge {
  id: string
  index_sub_challenge: number
  questions: Question[]
  value: string
}
