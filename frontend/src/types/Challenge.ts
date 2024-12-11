import type { SubChallenge } from './SubChallenge'

export interface Challenge {
  id: string
  index_challenge: number
  value: string
  color: string
  sub_challenges: SubChallenge[]
}
