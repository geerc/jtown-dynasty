// src/content.config.ts
import { defineCollection, z } from 'astro:content';

// Define the power_rankings collection
const powerRankings = defineCollection({
  schema: z.object({
    title: z.string(),
    date: z.string(),
    image: z.string().optional(),
  }),
});

export const collections = {
  power_rankings: powerRankings,
};
